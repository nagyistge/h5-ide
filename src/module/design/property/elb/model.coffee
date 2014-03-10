#############################
#  View Mode for design/property/instance
#############################

define [ '../base/model', "event", "Design", 'constant' ], ( PropertyModel, ide_event, Design, constant ) ->

    ElbModel = PropertyModel.extend {

        init : ( uid ) ->

            component = Design.instance().component( uid )

            @getAppData( uid )

            attr        = component.toJSON()
            attr.uid    = uid
            attr.isVpc  = not Design.instance().typeIsClassic()

            # Format ping
            pingArr  = component.getHealthCheckTarget()
            attr.pingProtocol = pingArr[0]
            attr.pingPort     = pingArr[1]
            attr.pingPath     = pingArr[2]

            if attr.sslCert
                attr.sslCert = attr.sslCert.toJSON()

            # See if we need to should certificate
            for i in attr.listeners
                if i.protocol is "SSL" or i.protocol is "HTTPS"
                    attr.showCert = true
                    break

            # Get AZ List
            if not attr.isVpc

                AzModel = Design.modelClassForType( constant.AWS_RESOURCE_TYPE.AWS_EC2_AvailabilityZone )

                connectedAzMap = {}
                for ami in component.connectionTargets("ElbAmiAsso")
                    if ami.parent().type is constant.AWS_RESOURCE_TYPE.AWS_AutoScaling_Group
                        az = ami.parent().parent()
                    else
                        az = ami.parent()
                    connectedAzMap[ az.get("name") ] = true

                reg = /-[\w]/g
                replaceFunc = (g)-> " " + g[1].toUpperCase()
                filterFunc  = (ch)-> ch.type is constant.AWS_RESOURCE_TYPE.AWS_EC2_Instance

                azArr = AzModel.allPossibleAZ()
                for az in azArr
                    if connectedAzMap[ az.name ]
                        az.disabled = connectedAzMap[ az.name ]
                        az.selected = true
                    else
                        az.disabled = false
                        az.selected = attr.AvailabilityZones.indexOf( az.name ) isnt -1

                    az.displayName = az.name.replace reg, replaceFunc
                    az.displayName = az.displayName[0].toUpperCase() + az.displayName.substr(1)

                    if az.id
                        azComp = Design.instance().component( az.id )
                        az.instanceCount = _.filter( azComp.children(), filterFunc ).length

                attr.azArray = azArr

            # Get SSL Cert List
            currentSSLCert = component.get('sslCert')
            allCertModelAry = Design.modelClassForType(constant.AWS_RESOURCE_TYPE.AWS_IAM_ServerCertificate).allObjects()
            sslCertItem = []
            noSSLCert = true
            _.each allCertModelAry, (sslCertModel) ->
                sslCertUID = sslCertModel.id
                sslCertName = sslCertModel.get('name')
                sslCertSelected = false
                if currentSSLCert and (currentSSLCert.id is sslCertUID)
                    sslCertSelected = true
                    noSSLCert = false
                sslCertItem.push({
                    uid: sslCertUID,
                    name: sslCertName,
                    selected: sslCertSelected
                })
            attr.sslCertItem = sslCertItem
            attr.noSSLCert = noSSLCert
            @set attr
            null

        getAppData : ( uid )->
            uid = uid or @get("uid")

            myElbComponent = Design.instance().component( uid )

            appData = MC.data.resource_list[ Design.instance().region() ]
            elb     = appData[ myElbComponent.get 'appId' ]

            if not elb then return

            @set {
                appData    : true
                isInternet : elb.Scheme is 'internet-facing'
                DNSName    : elb.DNSName
                CanonicalHostedZoneNameID : elb.CanonicalHostedZoneNameID
            }
            null

        setScheme   : ( value ) ->
            value = value is "internal"
            Design.instance().component( @get("uid") ).setInternal( value )

            # Trigger an event to tell canvas that we want an IGW
            if not value and Design.instance().typeIsVpc()
                Design.modelClassForType( constant.AWS_RESOURCE_TYPE.AWS_VPC_InternetGateway ).tryCreateIgw()
            null

        setElbCrossAZ : ( value )->
            Design.instance().component( @get("uid") ).set( "crossZone", !!value )
            null

        setHealthProtocol   : ( value ) ->
            Design.instance().component( @get("uid") ).setHealthCheckTarget( value )
            null

        setHealthPort: ( value ) ->
            Design.instance().component( @get("uid") ).setHealthCheckTarget( undefined, value )
            null

        setHealthPath: ( value ) ->
            Design.instance().component( @get("uid") ).setHealthCheckTarget( undefined, undefined, value )
            null

        setHealthInterval: ( value ) ->
            Design.instance().component( @get("uid") ).set("healthCheckInterval", value )
            null

        setHealthTimeout: ( value ) ->
            Design.instance().component( @get("uid") ).set("healthCheckTimeout", value )
            null

        setHealthUnhealth: ( value ) ->
            Design.instance().component( @get("uid") ).set("unHealthyThreshold", value )
            null

        setHealthHealth: ( value ) ->
            Design.instance().component( @get("uid") ).set("healthyThreshold", value )
            null

        setListener: ( idx, value ) ->
            Design.instance().component( @get("uid") ).setListener( idx, value )
            null

        removeListener : ( idx )->
            Design.instance().component( @get("uid") ).removeListener( idx )
            null

        setCert : ( value )->
            Design.instance().component( @get("uid") ).setSslCert( value )
            null

        addCert : ( value )->
            Design.instance().component( @get("uid") ).addSslCert( value )
            null

        removeCert : ( value ) ->
            Design.instance().component( @get("uid") ).removeSslCert( value )
            null

        updateElbAZ : ( azArray )->
            Design.instance().component( @get("uid") ).set("AvailabilityZones", azArray )
            null

        changeCert : ( certUID ) ->
            Design.instance().component( @get("uid") ).changeSslCert(certUID)
            null

        updateCert : (certUID, certObj) ->
            Design.instance().component( @get("uid") ).updateSslCert(certUID, certObj)
            null

        removeAllCert : (  ) ->

            elbUID = @get("uid")

            try

                elbModel = Design.instance().component(elbUID)
                sslModel = elbModel.get('sslCert')

                if sslModel
                    Design.instance().component(sslModel.id).remove()

            catch err

                console.log('remove cert failed')

            null
    }

    new ElbModel()
