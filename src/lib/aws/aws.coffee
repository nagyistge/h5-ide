define [ 'MC', 'constant', 'underscore', 'jquery', 'Design' ], ( MC, constant, _, $, Design ) ->
    getOSFamily = (osType, ami) ->
        me = this

        osFamily = 'linux'

        if osType
            if constant.OS_TYPE_MAPPING[osType]
                osFamily = constant.OS_TYPE_MAPPING[osType]

            if osType in constant.WINDOWS
                osFamily = 'mswin'

                try
                    if ami
                        sql_web_pattern = /sql.*?web.*?/
                        sql_standerd_pattern = /sql.*?standard.*?/

                        if ( 'name' of ami and ami.name.toLowerCase().match(sql_web_pattern) ) or ( 'description' of ami and ami.description.toLowerCase().match(sql_web_pattern) ) or ( 'imageLocation' of ami and ami.imageLocation.toLowerCase().match(sql_web_pattern) )
                            osFamily = 'mswinSQLWeb'

                        else if ( 'name' of ami and ami.name.toLowerCase().match(sql_standerd_pattern) ) or ( 'description' of ami and ami.description.toLowerCase().match(sql_standerd_pattern) ) or ( 'imageLocation' of ami and ami.imageLocation.toLowerCase().match(sql_standerd_pattern) )
                            osFamily = 'mswinSQL'

                catch error
                    console.info error

        osFamily

    collectReference = ( canvas_component ) ->

        key = {}

        #collect reference
        for uid, comp of canvas_component

            if constant.AWS_RESOURCE_KEY[comp.type] and comp.resource[constant.AWS_RESOURCE_KEY[comp.type]]

                key[comp.resource[constant.AWS_RESOURCE_KEY[comp.type]]] = MC.genResRef(uid, "resource.#{constant.AWS_RESOURCE_KEY[comp.type]}")

                # if comp.type is "AWS.EC2.KeyPair"

                #     key[comp.resource.KeyName + '-keypair'] = MC.genResRef(uid, 'resource.KeyName')

                if comp.type is "AWS.AutoScaling.Group"

                    key[comp.resource.AutoScalingGroupName + '-asg'] = MC.genResRef(uid, 'resource.AutoScalingGroupName')

                if comp.type is "AWS.AutoScaling.LaunchConfiguration"

                    key[comp.resource.LaunchConfigurationName + '-lc'] = MC.genResRef(uid, 'resource.LaunchConfigurationName')

                ## no need for app ##
                # if comp.type is 'AWS.VPC.NetworkInterface'

                #     for idx, ipset of comp.resource.PrivateIpAddressSet

                #         key[ipset.PrivateIpAddress] = MC.genResRef(uid, "resource.PrivateIpAddressSet.#{idx}.PrivateIpAddress")

        #replace reference
        for uid, comp of canvas_component

            canvas_component[uid] = replaceReference comp, key, constant.AWS_RESOURCE_KEY[comp.type]

        [canvas_component, key]


    replaceReference = ( obj, reference, except_key ) ->

        switch typeof(obj)

            when 'object'

                for k, v of obj

                    if typeof(v) is 'string'

                        if k is 'LaunchConfigurationName'

                            if reference[v + '-lc'] and k not in [except_key, 'name']

                                obj[k] = reference[v + '-lc']

                        else if k is 'AutoScalingGroupName'

                            if reference[v + '-asg'] and k not in [except_key, 'name']

                                obj[k] = reference[v + '-asg']

                        else if k is 'KeyName'

                            if reference[v + '-keypair'] and k not in [except_key, 'name'] and not obj.KeyFingerprint

                                obj[k] = reference[v + '-keypair']

                        else if reference[v] and k not in [except_key, 'name']

                            obj[k] = reference[v]

                    if typeof(v) is 'object'

                        replaceReference obj[k], reference, except_key

                    if typeof(v) is 'array'

                        replaceReference obj[k], reference, except_key

            when 'array'

                for index, slot of obj

                    if typeof(v) is 'string' and reference[slot]

                        obj[index] = reference[slot]

                    if typeof(v) is 'object'

                        replaceReference obj[index], reference, except_key

                    if typeof(v) is 'array'

                        replaceReference obj[index], reference, except_key

        obj

            # switch comp.type

            #     when 'AWS.EC2.Instance'

            #         key[comp.resource.InstanceId] = "@#{uid}.resource.InstanceId"

            #     when 'AWS.EC2.EBS.Volume'

            #         key[comp.resource.VolumeId] = "@#{uid}.resource.VolumeId"

            #     when 'AWS.VPC.NetworkInterface'

            #         key[comp.resource.NetworkInterfaceId] = "@#{uid}.resource.NetworkInterfaceId"

            #     when 'AWS.VPC.DhcpOptions'

            #         key[comp.resource.DhcpOptionsId] = "@#{uid}.resource.DhcpOptionsId"

            #     when 'AWS.VPC.VPC'

            #         key[comp.resource.VpcId] = "@#{uid}.resource.VpcId"

            #     when 'AWS.VPC.Subnet'

            #         key[comp.resource.SubnetId] = "@#{uid}.resource.SubnetId"

            #     when 'AWS.VPC.SecurityGroup'

            #         key[comp.resource.GroupId] = "@#{uid}.resource.GroupId"

    getCompByResIdForState = ( resId ) ->

        result =
            parent: null
            self: null

        Design.instance().eachComponent ( component ) ->
            groupMembers = component.groupMembers and component.groupMembers()
            resourceInList = MC.data.resource_list[ Design.instance().region() ]
            if result.parent or result.self
                null
            if component.get( 'appId' ) is resId
                # ServerGroup
                if groupMembers and groupMembers.length
                    result.parent = component
                    result.self = new Backbone.Model 'name': "#{component.get 'name'}-0"
                # Instance
                else
                    result.self = component
                null
            # ServerGroup
            else if groupMembers and resId in _.pluck( groupMembers, 'appId' )
                if component.type is constant.RESTYPE.LC
                    result.parent = component.parent()
                else
                    result.parent = component
                    for index, member of groupMembers
                        if member.appId is resId
                            result.self = new Backbone.Model 'name': "#{component.get 'name'}-#{+index + 1}"
                            break
                null

        result

    checkPrivateIPIfHaveEIP = (allCompData, eniUID, priIPNum) ->

        haveEIP = false
        _.each allCompData, (compData) ->

            if compData.type is constant.RESTYPE.EIP
                currentENIUIDRef = compData.resource.NetworkInterfaceId
                currentENIUID = MC.extractID(currentENIUIDRef)
                if eniUID is currentENIUID
                    currentPriIPNumAry = compData.resource.PrivateIpAddress.split('.')
                    currentPriIPNum = currentPriIPNumAry[3]
                    if Number(currentPriIPNum) is priIPNum
                        haveEIP = true
            null
        return haveEIP

    genAttrRefList = (currentCompData, allCompData) ->

        currentCompUID = currentCompData.uid
        currentCompType = currentCompData.type

        currentIsASG = false
        currentASGName = null
        if currentCompType is constant.RESTYPE.LC
            currentIsASG = true

        currentIsISG = false
        currentIsInstance = false
        currentInstanceName = null
        currentISGName = null
        if currentCompData.number
            if currentCompData.number > 1
                currentIsISG = true
                currentISGName = currentCompData.serverGroupName
            else
                currentIsInstance = true
                currentInstanceName = currentCompData.serverGroupName

        allCompData = allCompData or @get('allCompData')

        autoCompList = []

        awsPropertyData = constant.STATE_REF_DICT

        _.each allCompData, (compData, uid) ->

            compName = compData.name
            compUID = compData.uid
            compType = compData.type

            checkASGPublicIP = false

            if compUID is currentCompUID
                compName = 'self'

            if compType is constant.RESTYPE.ASG
                lcUIDRef = compData.resource.LaunchConfigurationName
                if lcUIDRef
                    lcUID = MC.extractID(lcUIDRef)
                    lcCompData = allCompData[lcUID]
                    if currentCompType is constant.RESTYPE.LC and currentCompUID is lcUID
                        currentASGName = compName
                        compName = 'self'
                        asgHaveSelf = true

                    if lcCompData.resource.AssociatePublicIpAddress
                        asgHavePublicIP = true

            if compType is constant.RESTYPE.INSTANCE
                return

            # replace instance default eni name to instance name
            if compType is constant.RESTYPE.ENI
                if compData.index isnt 0
                    return
                if compData.serverGroupUid isnt compUID
                    return
                instanceRef = compData.resource.Attachment.InstanceId
                if not instanceRef
                    return
                if compData.resource.Attachment.DeviceIndex in ['0', 0]
                    instanceUID = MC.extractID(instanceRef)
                    if instanceUID
                        compName = allCompData[instanceUID].serverGroupName
                        compUID = instanceUID
                        if instanceUID is currentCompUID
                            compName = 'self'

            supportType = compType.replace(/\./ig, '_')

            # found supported type
            attrList = awsPropertyData[supportType]
            if attrList

                _.each attrList, (isArray, attrName) ->

                    autoCompStr = (compName + '.') # host1.
                    autoCompRefStr = (compUID + '.') # uid.

                    if attrName is '__array'
                        return
                    else
                        autoCompStr += attrName
                        autoCompRefStr += attrName

                    instanceNoMainPublicIP = false

                    if attrName in ['PublicIp']

                        if compType is constant.RESTYPE.ASG
                            if not asgHavePublicIP
                                return

                        if compType is constant.RESTYPE.ENI
                            if (not MC.aws.aws.checkPrivateIPIfHaveEIP(allCompData, compData.uid, 0)) and
                            (not compData.resource.AssociatePublicIpAddress)
                                instanceNoMainPublicIP = true

                    if not instanceNoMainPublicIP

                        autoCompList.push({
                            name: autoCompStr,
                            value: autoCompRefStr,
                            uid: compUID
                        })

                    if isArray

                        if supportType is 'AWS_AutoScaling_Group'
                            if attrName in ['AvailabilityZones']
                                azAry = compData.resource.AvailabilityZones
                                if azAry.length > 1
                                    _.each azAry, (azName, idx) ->
                                        # if idx is 0 then return
                                        autoCompList.push({
                                            name: autoCompStr + '[' + idx + ']',
                                            value: autoCompRefStr + '[' + idx + ']',
                                            uid: compUID
                                        })
                                        null

                        if supportType is 'AWS_VPC_NetworkInterface'
                            if attrName in ['PublicDnsName', 'PublicIp', 'PrivateDnsName', 'PrivateIpAddress']
                                ipObjAry = compData.resource.PrivateIpAddressSet
                                if compData.index isnt 0
                                    return
                                if ipObjAry.length > 1
                                    _.each ipObjAry, (ipObj, idx) ->
                                        # if idx is 0 then return
                                        if attrName in ['PublicIp']
                                            if not MC.aws.aws.checkPrivateIPIfHaveEIP(allCompData, compData.uid, idx)
                                                return
                                        autoCompList.push({
                                            name: autoCompStr + '[' + idx + ']',
                                            value: autoCompRefStr + '[' + idx + ']',
                                            uid: compUID
                                        })
                                        null

                        if supportType is 'AWS_ELB'
                            if attrName in ['AvailabilityZones']
                                azAry = compData.resource.AvailabilityZones
                                if azAry.length > 1
                                    _.each azAry, (azName, idx) ->
                                        # if idx is 0 then return
                                        autoCompList.push({
                                            name: autoCompStr + '[' + idx + ']',
                                            value: autoCompRefStr + '[' + idx + ']',
                                            uid: compUID
                                        })
                                        null

                    null

            null

        # append asg/isg ref
        groupAutoCompList = []
        instanceAutoCompList = []
        _.each autoCompList, (autoCompObj) ->
            if autoCompObj.name.indexOf('self.') is 0

                if currentIsInstance
                    instanceCompNameStr = autoCompObj.name.replace('self', currentInstanceName)
                    instanceCompUIDStr = autoCompObj.value.replace('self', currentInstanceName)
                    instanceAutoCompList.push({
                        name: instanceCompNameStr,
                        value: instanceCompUIDStr,
                        uid: autoCompObj.uid
                    })

                if currentIsASG or currentIsISG
                    groupCompNameStr = null
                    groupCompUIDStr = null
                    if currentIsASG
                        groupCompNameStr = autoCompObj.name.replace('self', currentASGName)
                        groupCompUIDStr = autoCompObj.value.replace('self', currentASGName)
                    else if currentIsISG
                        groupCompNameStr = autoCompObj.name.replace('self', currentISGName)
                        groupCompUIDStr = autoCompObj.value.replace('self', currentISGName)
                    groupAutoCompList.push({
                        name: groupCompNameStr,
                        value: groupCompUIDStr,
                        uid: autoCompObj.uid
                    })

        autoCompList = autoCompList.concat(groupAutoCompList)
        autoCompList = autoCompList.concat(instanceAutoCompList)

        resAttrDataAry = _.map autoCompList, (autoCompObj) ->

            if autoCompObj.name.indexOf('self.') is 0
                autoCompObj.value = autoCompObj.value.replace(autoCompObj.uid, 'self')
                autoCompObj.uid = 'self'
            return {
                name: "#{autoCompObj.name}",
                value: "#{autoCompObj.name}",
                ref: "#{autoCompObj.value}",
                uid: "#{autoCompObj.uid}"
            }

        # filter all self's AZ ref
        resAttrDataAry = _.filter resAttrDataAry, (autoCompObj) ->

            if autoCompObj.name.indexOf('self.') is 0
                if autoCompObj.name.indexOf('.AvailabilityZones') isnt -1
                    return false
                else
                    return true

            return true

        # sort autoCompList
        resAttrDataAry = resAttrDataAry.sort((obj1, obj2) ->
            if obj1.name < obj2.name then return -1
            if obj1.name > obj2.name then return 1
        )

        return resAttrDataAry

    isValidInIPRange = (ipStr, validIPType) ->

        pubIPAry = [
            {
                low: '1.0.0.1',
                high: '126.255.255.254'
            },
            {
                low: '128.1.0.1',
                high: '191.254.255.254'
            },
            {
                low: '192.0.1.1',
                high: '223.255.254.254'
            }
        ]

        priIPAry = [
            {
                low: '10.0.0.0',
                high: '10.255.255.255'
            },
            {
                low: '172.16.0.0',
                high: '172.31.255.255'
            },
            {
                low: '192.168.0.0',
                high: '192.168.255.255'
            }
        ]

        ipRangeValid = (ipAryStr1, ipAryStr2, ipStr) ->

            ipAry1 = ipAryStr1.split('.')
            ipAry2 = ipAryStr2.split('.')
            curIPAry = ipStr.split('.')

            isInIPRange = true
            _.each curIPAry, (ipNum, idx) ->
                if not (Number(curIPAry[idx]) >= Number(ipAry1[idx]) and
                Number(curIPAry[idx]) <= Number(ipAry2[idx]))
                    isInIPRange = false
                null

            return isInIPRange

        ipRangeAry = []

        if validIPType is 'public'
            ipRangeAry = pubIPAry
        else if validIPType is 'private'
            ipRangeAry = priIPAry

        isInAryRange = false
        _.each ipRangeAry, (ipRangeObj) ->
            lowRange = ipRangeObj.low
            highRange = ipRangeObj.high
            isInRange = ipRangeValid(lowRange, highRange, ipStr)
            if isInRange
                isInAryRange = true
            null

        return isInAryRange

    #public
    collectReference            : collectReference
    getOSFamily                 : getOSFamily
    getCompByResIdForState      : getCompByResIdForState
    genAttrRefList              : genAttrRefList
    isValidInIPRange            : isValidInIPRange
    checkPrivateIPIfHaveEIP     : checkPrivateIPIfHaveEIP
