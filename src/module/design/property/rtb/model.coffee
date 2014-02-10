#############################
#  View Mode for design/property/rtb
#############################

define [ '../base/model', "Design", 'constant' ], ( PropertyModel, Design, constant ) ->

  RTBModel = PropertyModel.extend {

    setMainRT : () ->
      Design.instance().component( @get("uid") ).setMain()
      null

    reInit : () ->
      @init( @get( "uid" ) )
      null

    init : ( uid ) ->

      design    = Design.instance()

      component = design.component( uid )
      res_type  = constant.AWS_RESOURCE_TYPE

      # uid might be a line connecting RTB and other resource
      if component.node_line
        subnet    = component.getTarget( res_type.AWS_VPC_Subnet )
        component = component.getTarget( res_type.AWS_VPC_RouteTable )

        if subnet
          @set {
            title : 'Subnet-RT Association'
            association :
              subnet : subnet.get("name")
              rtb    : component.get("name")
          }
          return

      VPCModel = Design.modelClassForType( res_type.AWS_VPC_VPC )

      # If this is RTB or this is RTB blue lines, show RTB property
      routes = []
      data =
        uid         : component.id # The component is guarantee to be RTB at this point, and we assign the uid of the property to be the RTB id, because we might need to set attributes of the rtb.
        title       : component.get("name")
        isMain      : component.get("main")
        local_route : VPCModel.theVPC().get("cidr")
        routes      : routes

      for cn in component.connections()
        if cn.type isnt "RTB_Route"
          continue

        theOtherPort = cn.getOtherTarget( res_type.AWS_VPC_RouteTable )

        routes.push {
          name     : theOtherPort.get("name")
          type     : theOtherPort.type
          ref      : cn.id
          isVgw    : theOtherPort.type is res_type.AWS_VPC_VPNGateway
          isProp   : cn.get("propagate")
          cidr_set : cn.get("routes")
        }

      routes = _.sortBy routes, "type"

      @set data
      true

    setPropagation : ( propagate ) ->

      component = Design.instance().component( @get("uid") )

      # Only one vgw will be in a stack. So, RTB can only connects to one VPN
      cn = _.find component.connections(), ( cn )->
        cn.getTarget( constant.AWS_RESOURCE_TYPE.AWS_VPC_VPNGateway ) isnt null

      cn.setPropagate propagate
      null

    setRoutes : ( routeId, routes ) ->
      Design.instance().component( routeId ).set( "routes", routes )
      null
  }

  new RTBModel()
