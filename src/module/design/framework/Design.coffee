define [ "constant", "module/design/framework/CanvasElement", "module/design/framework/CanvasManager" ], ( constant, CanvasElement, CanvasManager ) ->

  ### $canvas is a adaptor for MC.canvas.js ###
  $canvas = ( id )->
    new CanvasElement( Design.instance().component(id) )

  $canvas.size   = ( w, h  )-> design_instance.canvas.size( w, h )
  $canvas.scale  = ( ratio )-> design_instance.canvas.scale( ratio )
  $canvas.offset = ( x, y  )-> design_instance.canvas.offset( x, y )
  $canvas.node   = ()->
    _.map design_instance.__canvasNodes, ( comp )->
      new CanvasElement( comp )

  $canvas.group  = ()->
    _.map design_instance.__canvasGroups, ( comp )->
      new CanvasElement( comp )

  window.$canvas = $canvas

  ### Canvas is used by $canvas to store data of svg canvas ###
  Canvas = ( size )->
    this.size   = size
    this.offset = [0, 0]
    this.scale  = 1
    this

  Canvas.prototype.scale = ( ratio )->
    if ratio is undefined
      return this.scale

    this.scale = ratio
    null

  Canvas.prototype.offset = ( x, y )->
    if x is undefined
      return this.offset

    this.offset[0] = x
    this.offset[1] = y
    null

  Canvas.prototype.size = ( w, h )->
    if w is undefined
      return this.size

    this.size[0] = w
    this.size[1] = h
    null


  ###
    -------------------------------
     Design is the main controller of the framework. It handles the input / ouput of the Application ( a.k.a the DesignCanvas ).
     The input and ouput is the same : the JSON data.
    -------------------------------


    ++ Class Method ++

    # instance() : Design
        description : returns the currently used Design object.


    ++ Object Method ++

    # component( uid ) : ResourceModel
        description : returns a resource model of uid

    # getAZ( azName ) : AzModel
        description : returns a AzModel, if the azModel doesn't exist, it will be created.

    # createConnection( p1U, p1N, p2U, p2N ) : ConnectionModel
        description : returns a ConnectionModel for the connection.

    # serialize() : Object
        description : returns a Plain JS Object that is indentical to JSON data.

    # serializeLayout() : Object
        description : returns a Plain JS Object that is indentical to Layout data.

  ###

  design_instance = null



  Design = ( json_data, layout_data, options )->

    design = (new DesignImpl( options )).use()
    design.canvas = new Canvas( layout_data.size )

    # Temporarily set layout_data in design, so that getAZ can use it
    design.groupLayoutData = layout_data.component.group

    layout_data = $.extend {}, layout_data.component.node, layout_data.component.group

    # Deserialize

    # A helper function to let each resource to get its dependency
    resolveDeserialize = ( uid )->

      obj = design_instance.__componentMap[ uid ]
      if obj
        return obj

      # Check if we have recursive dependency
      console.assert (not recursiveCheck[uid] && recursiveCheck[uid] = true ), "Recursive dependency found when deserializing JSON_DATA"



      component_data = json_data[ uid ]

      ModelClass = Design.modelClassForType( component_data.type )
      if not ModelClass
        console.warn "We do not support deserializing resource of type : #{component_data.type}"
        return

      ModelClass.deserialize( component_data, layout_data[uid], resolveDeserialize )

      design_instance.__componentMap[ uid ]

    # Use resolve to replace component(), so that during deserialization,
    # dependency can be resolved by using design.component()
    _old_get_component_ = design.component
    design.component = resolveDeserialize

    # Always deserialize VPC resource first
    for uid, comp of json_data
      if uid.type is constant.AWS_RESOURCE_TYPE.AWS_VPC_VPC
        resolveDeserialize uid

    # Deserialize other resources
    for uid, comp of json_data
      recursiveCheck = {}
      resolveDeserialize uid

    design.component = _old_get_component_

    delete design.groupLayoutData

    design

  DesignImpl = ( options )->
    @__componentMap = {}
    @__canvasNodes  = {}
    @__canvasGroups = {}
    @__classCache   = {}
    @__type         = options.type
    @__mode         = options.mode
    null


  Design.TYPE = {
    Classic    : "Classic"
    Vpc        : "Vpc"
    DefaultVpc : "DefaultVpc"
  }
  Design.MODE = {
    Stack   : "Stack"
    App     : "App"
    AppEdit : "AppEdit"
  }

  ### Private Interface ###
  Design.__modelClassMap = {}
  Design.registerModelClass = ( type, modelClass )->
    @__modelClassMap[ type ] = modelClass
    null

  Design.modelClassForType = ( type )-> @__modelClassMap[ type ]

  DesignImpl.prototype.classCacheForCid = ( cid )->
    if @__classCache[ cid ]
      return @__classCache[ cid ]

    cache = @__classCache[ cid ] = []
    return cache

  DesignImpl.prototype.cacheComponent = ( id, comp )->
    if not comp
      delete @__componentMap[ id ]
      delete @__canvasGroups[ id ]
      delete @__canvasNodes[ id ]
    else
      @__componentMap[ id ] = comp

      # Cache them into another cache if they are visual objects
      if _.isFunction comp.draw
        if comp.get("group")
          @__canvasGroups[ id ] = comp
        else
          @__canvasNodes[ id ] = comp
    null
  ### Private Interface End ###


  Design.instance = ()-> design_instance


  DesignImpl.prototype.mode          = ()-> this.__mode
  DesignImpl.prototype.modeIsStack   = ()-> this.__mode == Design.MODE.Stack
  DesignImpl.prototype.modeIsApp     = ()-> this.__mode == Design.MODE.App
  DesignImpl.prototype.modeIsAppEdit = ()-> this.__mode == Design.MODE.AppEdit
  DesignImpl.prototype.setMode = (m)->
    this.__mode = m
    null

  DesignImpl.prototype.type             = ()-> this.__type
  DesignImpl.prototype.typeIsClassic    = ()-> this.__type == Design.TYPE.Classic
  DesignImpl.prototype.typeIsDefaultVpc = ()-> this.__type == Design.TYPE.DefaultVpc
  DesignImpl.prototype.typeIsVpc        = ()-> this.__type == Design.TYPE.Vpc


  DesignImpl.prototype.shouldDraw = ()-> true

  DesignImpl.prototype.use = ()->
    window.DesignInst = design_instance = @
    @

  DesignImpl.prototype.component = ( uid )-> @__componentMap[ uid ]

  DesignImpl.prototype.getAZ = ( azName, x, y , width, height )->
    AzModel = Design.modelClassForType( constant.AWS_RESOURCE_TYPE.AWS_EC2_AvailabilityZone )

    allAzs = AzModel.allObjects()
    for az in allAzs
      if az.get("name") is azName
        return az

    # Retrieve AZ's layout info from layoutData
    if @groupLayoutData
      for uid, layout of @groupLayoutData
        if layout.type is constant.AWS_RESOURCE_TYPE.AWS_EC2_AvailabilityZone and layout.name is azName
          attr =
            id     : uid
            name   : azName
            x      : layout.coordinate[0]
            y      : layout.coordinate[1]
            width  : layout.size[0]
            height : layout.size[1]

    if not attr
      attr = {
        name   : azName
        x      : x
        y      : y
        width  : width
        height : height
      }

    new AzModel( attr )

  DesignImpl.prototype.serialize = ()->

    json_data   = {}

    connections = []
    mockArray   = []

    # ResourceModel can only add json component.
    for uid, comp of @__componentMap
      if comp.get("connection")
        connections.push comp
        continue

      json = comp.serialize()
      if not json
        continue

      # Make json to be an array
      if not _.isArray( json )
        mockArray[0] = json
        json = mockArray

      for j in json
        console.assert( j.uid, "Serialized JSON data has no uid." )
        console.assert( not json_data[ j.uid ], "ResourceModel cannot modify existing JSON data." )
        json_data[ j.uid ] = j

    # Connection
    for c in connections
      c.serialize( json_data )

    json_data


  DesignImpl.prototype.serializeLayout = ()->

  DesignImpl.prototype.createConnection = ( p1Uid, port1, p2Uid, port2 )->
    if port1 < port2
      p1Comp = @component( p1Uid )
      p2Comp = @component( p2Uid )
      type = port1 + "<" + port2
    else
      p1Comp = @component( p2Uid )
      p2Comp = @component( p1Uid )
      type = port2 + "<" + port1

    C = Design.modelClassForType( type )

    console.assert( C, "Cannot found Class for type: #{type}" )

    new C( p1Comp, p2Comp )

  # Inject dependency, so that CanvasManager won't require Design.js
  CanvasManager.setDesign( Design )

  Design
