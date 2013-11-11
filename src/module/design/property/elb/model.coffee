#############################
#  View Mode for design/property/instance
#############################

define [ '../base/model', 'constant' ], ( PropertyModel, constant ) ->

    ElbModel = PropertyModel.extend {

        defaults :
            'elb_detail'      : null
            'health_detail'   : null
            'listener_detail' : null
            'az_detail'       : null
            'component'       : null
            'uid'             : null
            'is_elb'          : true
            'server_cert'     : null
            'have_vpc'        : null

        init : ( uid ) ->

            this.set 'uid', uid

            this.set 'is_elb', true

            allComp = MC.canvas_data.component

            elb_data = MC.canvas_data.component[ uid ]

            this.set 'component', elb_data

            scheme = elb_data.resource.Scheme

            # have igw ?
            haveIGW = false

            igwCompAry = _.filter allComp, (obj) ->
                obj.type is 'AWS.VPC.InternetGateway'
            if igwCompAry.length isnt 0
                haveIGW = true

            elb_detail = {
                'isInternal' : scheme is 'internal',
                'haveIGW' : haveIGW
            }

            if scheme is 'internal'
                MC.canvas.update uid, 'image', 'elb_scheme', MC.canvas.IMAGE.ELB_INTERNAL_CANVAS
            else
                MC.canvas.update uid, 'image', 'elb_scheme', MC.canvas.IMAGE.ELB_INTERNET_CANVAS

            this.set 'elb_detail', elb_detail

            healthcheck = elb_data.resource.HealthCheck

            target = healthcheck.Target

            #Ping Protocol
            protocol = target.split(':')[0]

            #Ping Port
            port = target.split(':')[1].split('/')[0]

            #Ping Path
            path = '/index.html'
            disabled_path = true
            if target.split('/')[1]
                path = '/' + target.split('/')[1]
                disabled_path = false

            #Health Check Interval
            interval = healthcheck.Interval

            #Response Timeout
            timeout = healthcheck.Timeout

            #Unhealthy Threshold
            unhealthy_threshold = healthcheck.UnhealthyThreshold

            #Healthy Threshold
            healthy_threshold = healthcheck.HealthyThreshold

            this.set 'health_detail', {
                target: target,
                protocol: protocol,
                port: port,
                path: path,
                interval: interval,
                timeout: timeout,
                disabled_path: disabled_path,
                unhealthy_threshold: unhealthy_threshold,
                healthy_threshold: healthy_threshold
            }

            #Listener
            listenerAry = elb_data.resource.ListenerDescriptions
            this.set 'listener_detail', {
                listenerAry: listenerAry
            }

            if MC.aws.vpc.getVPCUID()
                this.set 'az_detail', null
                # return

            #AZ & Instance Info
            azObj = {}
            azObjAry = []
            region = MC.canvas_data.region

            if !MC.data.config[region].zone
                return

            azAry = MC.data.config[region].zone.item
            _.each azAry, (elem) ->
                azObj[elem.zoneName] = 0
                null

            _.each MC.canvas_data.component, (compObj) ->
                compType = compObj.type
                if compType is 'AWS.EC2.Instance'
                    # subnetUID = compObj.resource.SubnetId.split('.')[0].slice(1)
                    # subnetCompObj = MC.canvas_data.component[subnetUID]
                    # azName = subnetCompObj.resource.AvailabilityZone
                    azName = compObj.resource.Placement.AvailabilityZone
                    azObj[azName]++
                null

            # have az ##################################################################
            if !MC.canvas_data.component[uid].resource.VpcId
                azAry = MC.canvas_data.component[uid].resource.AvailabilityZones
                _.each azObj, (value, key) ->
                    obj = {}
                    obj[key] = value

                    selected = (key in azAry)

                    # keep az name to short name
                    # us-east-1a -> US East 1a

                    keyAry = key.split('-')
                    keyAry[0] = keyAry[0].toUpperCase()
                    keyAry[1] = keyAry[1][0].toUpperCase() + keyAry[1].slice(1)
                    keyStr = keyAry.join(' ')

                    disable_selected = MC.aws.elb.haveAssociateInAZ(uid, key)

                    azObjAry.push({
                        az_name: keyStr,
                        az_inner_name: key,
                        disable_selected: disable_selected,
                        instance_num: value,
                        selected: selected
                    })
                    null

                azObjAry.sort (obj1, obj2) ->
                    key1 = obj1.az_name
                    length1 = key1.length
                    key2 = obj2.az_name
                    length2 = key2.length
                    return key1.slice(length1) - key2.slice(length2)

                this.set 'az_detail', azObjAry
            # have az ##################################################################

            defaultVPC = false
            if MC.aws.aws.checkDefaultVPC()
                defaultVPC = true

            if defaultVPC or MC.canvas_data.component[uid].resource.VpcId
                this.set 'have_vpc', true
            else
                this.set 'have_vpc', false

            null

        setELBName  : ( value ) ->
            console.log 'setELBName = ' + value

            uid = @get 'uid'

            # before, modify elb default sg name
            elbSG = MC.aws.elb.getElbDefaultSG uid
            if elbSG
                originELBName = MC.canvas_data.component[uid].resource.LoadBalancerName
                newSGName = value + '-sg'
                elbSGUID = elbSG.uid
                MC.canvas_data.component[elbSGUID].name = newSGName
                MC.canvas_data.component[elbSGUID].resource.GroupName = newSGName

            # after, modify elb name
            MC.canvas_data.component[uid].name = value
            MC.canvas_data.component[uid].resource.LoadBalancerName = value

            null

        setScheme   : ( value ) ->
            console.log 'setScheme = ' + value

            uid = @get 'uid'

            component = MC.canvas_data.component[ uid ]

            if value is 'internal'
                component.resource.Scheme = 'internal'
            else
                component.resource.Scheme = 'internet-facing'

            if value is 'internal'
                MC.canvas.update uid, 'image', 'elb_scheme', MC.canvas.IMAGE.ELB_INTERNAL_CANVAS
                MC.canvas.display(uid, 'port-elb-sg-in', true)
            else
                MC.canvas.update uid, 'image', 'elb_scheme', MC.canvas.IMAGE.ELB_INTERNET_CANVAS
                MC.canvas.display(uid, 'port-elb-sg-in', false)

            component

        setHealthProtocol   : ( value ) ->
            console.log 'setHealthProtocol = ' + value

            uid = @get 'uid'

            target = MC.canvas_data.component[ uid ].resource.HealthCheck.Target
            new_target = value + ':' + target.split(':')[1]

            if value is 'TCP' or value is 'SSL'
                new_target = new_target.split('/')[0]
            else
                path = new_target.split('/')[1]
                if !path
                    new_target += '/index.html'

            MC.canvas_data.component[ uid ].resource.HealthCheck.Target = new_target

            null

        setHealthPort: ( value ) ->
            console.log 'setHealthPort = ' + value

            uid = @get 'uid'

            target = MC.canvas_data.component[ uid ].resource.HealthCheck.Target
            new_target = target.split(':')[0] + ':' + value
            path = target.split('/')[1]
            if path
                new_target += '/' + path

            MC.canvas_data.component[ uid ].resource.HealthCheck.Target = new_target

            null

        setHealthPath: ( value ) ->
            console.log 'setHealthPath = ' + value

            uid = @get 'uid'

            target = MC.canvas_data.component[ uid ].resource.HealthCheck.Target
            new_target = target.split('/')[0] + value

            MC.canvas_data.component[ uid ].resource.HealthCheck.Target = new_target

            null

        setHealthInterval: ( value ) ->
            console.log 'setHealthInterval = ' + value

            uid = @get 'uid'

            MC.canvas_data.component[ uid ].resource.HealthCheck.Interval = Number(value)

            null

        setHealthTimeout: ( value ) ->
            console.log 'setHealthTimeout = ' + value

            uid = @get 'uid'

            MC.canvas_data.component[ uid ].resource.HealthCheck.Timeout = Number(value)

            null

        setHealthUnhealth: ( value ) ->
            console.log 'setHealthUnhealth = ' + value

            uid = @get 'uid'

            MC.canvas_data.component[ uid ].resource.HealthCheck.UnhealthyThreshold = Number(value)

            null

        setHealthHealth: ( value ) ->
            console.log 'setHealthHealth = ' + value

            uid = @get 'uid'

            MC.canvas_data.component[ uid ].resource.HealthCheck.HealthyThreshold = Number(value)

            null

        setListenerAry: ( value ) ->
            console.log 'setHealthHealth = ' + value

            uid = @get 'uid'

            #clean ami
            currentCert = this.getCurrentCert( uid )
            delCertComp = true
            if currentCert
                currentCertUID = currentCert.uid
                _.each value, (obj, index) ->
                    elbProtocolValue = obj.Listener.Protocol
                    if elbProtocolValue isnt 'HTTPS' and elbProtocolValue isnt 'SSL'
                        value[index].Listener.SSLCertificateId = ''
                    else
                        delCertComp = false
                        value[index].Listener.SSLCertificateId = '@' + currentCertUID + '.resource.ServerCertificateMetadata.Arn'
                    null

                if delCertComp
                    delete MC.canvas_data.component[currentCertUID]

            MC.canvas_data.component[uid].resource.ListenerDescriptions = value
            MC.aws.elb.updateRuleToElbSG uid

            null

        getCurrentCert: ( uid ) ->

            console.log 'getCurrentCert'

            if not uid
                uid = @get 'uid'

            certUID = ''
            listenerAry = MC.canvas_data.component[ uid ].resource.ListenerDescriptions
            _.each listenerAry, (obj) ->
                certId = obj.Listener.SSLCertificateId
                if certId != ''
                    try
                        certUID = certId.split('.')[0].slice(1)
                        return false
                    catch err

            MC.canvas_data.component[certUID]

        setListenerCert: ( value ) ->

            uid = @get 'uid'

            listenerAry = MC.canvas_data.component[uid].resource.ListenerDescriptions

            currentCertUID = ''

            currentCert = this.getCurrentCert(uid)
            if currentCert and currentCert.uid
                currentCertUID = currentCert.uid

                #clean ami
                if (!value.name && !value.resource.PrivateKey && !value.resource.CertificateBody)
                    delete MC.canvas_data.component[currentCertUID]
                    _.each listenerAry, (obj, index) ->
                        MC.canvas_data.component[uid].resource.ListenerDescriptions[index].Listener.SSLCertificateId = ''
                        null
            else
                currentCertUID = MC.guid()
                currentCert = $.extend(true, {}, MC.canvas.SRVCERT_JSON).data

            if value and value.name and value.resource.PrivateKey and value.resource.CertificateBody
                currentCert.uid = currentCertUID
                currentCert.name = value.name
                currentCert.resource.PrivateKey = value.resource.PrivateKey
                currentCert.resource.CertificateBody = value.resource.CertificateBody
                currentCert.resource.CertificateChain = value.resource.CertificateChain
                currentCert.resource.ServerCertificateMetadata.ServerCertificateName = value.name

                MC.canvas_data.component[currentCertUID] = currentCert

                certRef = '@' + currentCertUID + '.resource.ServerCertificateMetadata.Arn'
                _.each listenerAry, (obj, index) ->
                    elbProtocolValue = obj.Listener.Protocol
                    if elbProtocolValue is 'HTTPS' or elbProtocolValue is 'SSL'
                        MC.canvas_data.component[uid].resource.ListenerDescriptions[index].Listener.SSLCertificateId = certRef
                    else
                        MC.canvas_data.component[uid].resource.ListenerDescriptions[index].Listener.SSLCertificateId = ''

                    null

            null

        removeAZFromELB: ( value ) ->

            uid = @get 'uid'

            azName = value
            elbComp = MC.canvas_data.component[uid]
            elbAZAry = elbComp.resource.AvailabilityZones
            newAZAry = _.filter elbAZAry, (item) ->
                if azName is item
                    false
                else
                    true

            MC.canvas_data.component[uid].resource.AvailabilityZones = newAZAry

            null

        addAZToELB: ( value ) ->

            uid = @get 'uid'

            azName = value
            addAZToElb = true
            elbComp = MC.canvas_data.component[uid]
            elbAZAry = elbComp.resource.AvailabilityZones
            _.each elbAZAry, (elem, index) ->
                if elem is azName
                    addAZToElb = false
                    null

            if addAZToElb
                MC.canvas_data.component[uid].resource.AvailabilityZones.push(azName)

            null

        getSGList : () ->

            uid = this.get 'uid'
            sgAry = MC.canvas_data.component[uid].resource.SecurityGroups

            sgUIDAry = []
            _.each sgAry, (value) ->
                sgUID = value.slice(1).split('.')[0]
                sgUIDAry.push sgUID
                null

            return sgUIDAry

        unAssignSGToComp : (sg_uid) ->

            elbUID = this.get 'uid'

            originSGAry = MC.canvas_data.component[elbUID].resource.SecurityGroups

            currentSGId = '@' + sg_uid + '.resource.GroupId'

            originSGAry = _.filter originSGAry, (value) ->
                value isnt currentSGId

            MC.canvas_data.component[elbUID].resource.SecurityGroups = originSGAry

            null

        assignSGToComp : (sg_uid) ->

            elbUID = this.get 'uid'

            originSGAry = MC.canvas_data.component[elbUID].resource.SecurityGroups

            currentSGId = '@' + sg_uid + '.resource.GroupId'

            if !Boolean(currentSGId in originSGAry)
                originSGAry.push currentSGId

            MC.canvas_data.component[elbUID].resource.SecurityGroups = originSGAry

            null
    }

    new ElbModel()
