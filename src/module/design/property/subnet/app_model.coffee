#############################
#  View Mode for design/property/subnet
#############################

define [ '../base/model', 'constant', 'Design' ], ( PropertyModel, constant, Design ) ->

    SubnetAppModel = PropertyModel.extend {

        init : ( uid )->

            mySubnetComponent = Design.instance().component( uid )

            appData = MC.data.resource_list[ Design.instance().region() ]
            subnet  = appData[ mySubnetComponent.get 'appId' ]

            if not subnet
                return false

            subnet      = $.extend true, {}, subnet
            subnet.name = mySubnetComponent.get 'name'
            subnet.acl  = this.getACL( uid ).toJSON()
            subnet.uid  = uid

            # Get RouteTable ID

            routeTable = mySubnetComponent.connectionTargets( 'RTB_Asso' )[ 0 ]

            linkedRT = routeTable.get 'appId'
            if routeTable.get 'main'
                defaultRT = routeTable.get 'appId'

            subnet.routeTable = if linkedRT then linkedRT else defaultRT

            this.set subnet
            null

        getACL : ( uid ) ->

            component = Design.instance().component( uid )

            acl = component.connectionTargets( 'AclAsso' )[ 0 ]
            linkedACL = acl

            if acl.isDefault()
                defaultACL = acl


            if linkedACL then linkedACL else defaultACL
    }

    new SubnetAppModel()
