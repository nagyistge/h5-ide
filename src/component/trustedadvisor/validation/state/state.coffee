###
This file use for validate component about state.
###

define [ 'constant', 'MC', '../result_vo', 'Design', '../../helper' ], ( CONST, MC, resultVO, Design, Helper ) ->

    i18n = Helper.i18n.short()
    __wrap = ( method ) ->
        ( uid ) ->
            if __hasState uid
                method uid
            else
                null

    __getComp = ( uid, rework ) ->
        if rework
            Design.instance().component uid
        else
            MC.canvas_data.component[ uid ]

    __hasState = ( uid ) ->
        if Design.instance().get('agent').enabled is false
            return false
        if uid
            component = __getComp uid, true
            if component
                state = component.get 'state'
                state and state.length
            else
                false
        else
            had = false
            Design.instance().eachComponent ( component ) ->
                if __hasState component.id
                    had = true
                    false
            had

    __hasType = ( type ) ->
        Design.modelClassForType( type ).allObjects().length

    __getEniByInstance = ( instance ) ->
        _.filter MC.canvas_data.component, ( component ) ->
            if component.type is CONST.RESTYPE.ENI
                if MC.extractID( component.resource.Attachment.InstanceId ) is instance.uid
                    true

    __getSg = ( component ) ->
        sgs = []
        # LC
        if component.type is CONST.RESTYPE.LC
            for sgId in component.resource.SecurityGroups
                sgs.push __getComp MC.extractID sgId
        # Instance
        else if component.type is CONST.RESTYPE.INSTANCE
            enis = __getEniByInstance component

            for eni in enis
                for sg in eni.resource.GroupSet
                    sgs.push __getComp MC.extractID sg.GroupId

        _.uniq _.compact sgs

    __isPortTcpAllowed = ( permission, port ) ->
        res = false

        if permission.IpProtocol in [ '-1', '6', 'tcp' ]
            formPort = + permission.FromPort
            toPort = + permission.ToPort
            if  formPort is toPort is port
                res = true
            else if + permission.FromPort <= port and permission.ToPort >= port
                res = true


        res


    __sgsHasOutPort80and443 = ( sgs, strict ) ->
        __80 = __443 = 0

        for sg in sgs
            for permission in sg.resource.IpPermissionsEgress

                if strict and permission.IpRanges is '0.0.0.0/0' or not strict
                    if __isPortTcpAllowed permission, 80
                        __80++
                    if __isPortTcpAllowed permission, 443
                        __443++

        __80 > 0 and __443 > 0

    __hasEipOrPublicIp = ( component ) ->
        if component.type is "ExpandedAsg"
            lc = component.get( 'originalAsg' ).get 'lc'
            lc.get( 'publicIp' ) is true
        # LC
        else if component.type is CONST.RESTYPE.LC
            component.get( 'publicIp' ) is true
        # Instance
        else if component.type is CONST.RESTYPE.INSTANCE

            enis = component.connectionTargets('EniAttachment')
            enis.push component.getEmbedEni()
            hasEip = _.some enis, ( eni ) -> eni.hasEip()
            component.hasAutoAssignPublicIp() or hasEip

    __getSubnetRtb = ( component ) ->
        subnet = component.parent()
        if subnet.type isnt CONST.RESTYPE.SUBNET
            subnet = subnet.parent()

        subnet.connectionTargets('RTB_Asso')[ 0 ]

    __isRouteIgw = ( component ) ->
        uid = component.uid or component.id
        component = Design.instance().component uid

        rtbs = [] # RTB Connected to component or component's ENI
        rtbs.push __getSubnetRtb( component )

        enis = component.connectionTargets("EniAttachment")

        for eni in enis
            rtbs.push __getSubnetRtb( eni )

        _.some rtbs, ( rtb ) ->
            rtbConn = rtb.connectionTargets('RTB_Route')
            igw = _.where rtbConn, type: CONST.RESTYPE.IGW
            igw.length > 0

    __natOut = ( component ) ->
        if component.type in [ CONST.RESTYPE.INSTANCE, CONST.RESTYPE.LC ]
            rtb = __getSubnetRtb component
            if rtb
                instances = _.where rtb.connectionTargets('RTB_Route'), type: CONST.RESTYPE.INSTANCE
                return _.some instances, ( instance ) ->
                    __isInstanceNat instance

        false

    # parameter required a rework instance.
    __isInstanceNat = ( instance ) ->
        __isRouteIgw( instance ) and __isEniSourceDestUncheck( instance )



    __isEniSourceDestUncheck = ( instance ) ->
        enis = instance.connectionTargets('EniAttachment')
        enis.push instance.getEmbedEni()
        _.some enis, ( eni ) ->
            not eni.get 'sourceDestCheck'


    __selfOut = ( component, result, subnetName ) ->
        # if there is no EIP or publicIP, push an error and stop continued validate.
        if not __hasEipOrPublicIp( component )
            name = component.get( 'name' )
            if component.type is 'ExpandedAsg'
                lc = component.get('originalAsg').get('lc')
                subnetName = component.parent().get 'name'
                name = lc and lc.get 'name'

            result.push Helper.message.error component.id, i18n.TA_MSG_ERROR_NO_EIP_OR_PIP, name, name, subnetName
            true
        else if __isRouteIgw( component )
            true
        else
            false

    __genConnectedError = ( subnetName, uid ) ->
        Helper.message.error uid, i18n.TA_MSG_ERROR_NOT_CONNECT_OUT, subnetName


    __isLcConnectedOut = ( uid ) ->
        lc = __getComp uid, true
        lcOld = __getComp uid
        result = []

        asg = lc.parent()
        expandedAsgs = asg.get 'expandedList'

        subnet = lc.parent().parent()
        subnetName = subnet.get 'name'
        subnetId = subnet.id

        isLcNatOut = __natOut( lc )

        if not (isLcNatOut or __selfOut( lc, result, subnetName ))
            result.push __genConnectedError subnetName, subnetId

        for asg in expandedAsgs
            if not ( isLcNatOut or __selfOut( asg, result, subnetName ))
                subnetName = asg.parent().get 'name'
                result.push __genConnectedError subnetName, subnetId

        result


    __isInstanceConnectedOut = ( uid ) ->
        component = __getComp uid, true
        result = []

        subnet = component.parent()
        subnetName = subnet.get 'name'
        subnetId = subnet.id

        # The order is important. isNat must be put before notNat,
        # becauce notNat will validate EIP and PublicIP,
        # if the instance is connected out through NAT and it doesn't have an EIP or PublicIP
        # We can't throw any error.

        if __natOut( component ) or __selfOut( component, result, subnetName )
            return result

        result.push __genConnectedError subnetName, subnetId

        result



    ### Public ###

    isHasIgw = ( uid ) ->
        if __hasType CONST.RESTYPE.IGW
            return null

        Helper.message.error uid, i18n.TA_MSG_ERROR_NO_CGW

    isHasOutPort80and443 = ( uid ) ->
        component = __getComp uid

        sgs = __getSg component
        if __sgsHasOutPort80and443 sgs
            return null

        Helper.message.error uid, i18n.TA_MSG_ERROR_NO_OUTBOUND_RULES, component.name

    isHasOutPort80and443Strict = ( uid ) ->
        component = __getComp uid

        sgs = __getSg component
        if isHasOutPort80and443( uid ) or __sgsHasOutPort80and443 sgs, true
            return null

        Helper.message.warning uid, i18n.TA_MSG_WARNING_OUTBOUND_NOT_TO_ALL, component.name

    isConnectedOut = ( uid ) ->
        result = []
        component = __getComp uid
        if component.type is CONST.RESTYPE.LC
            return __isLcConnectedOut( uid )
        else
            return __isInstanceConnectedOut( uid )






    # public
    isHasIgw                    : __wrap isHasIgw
    isHasOutPort80and443        : __wrap isHasOutPort80and443
    isHasOutPort80and443Strict  : __wrap isHasOutPort80and443Strict
    isConnectedOut              : __wrap isConnectedOut

