
define [ "./CanvasElement", "constant", "CanvasManager", "event" ], ( CanvasElement, constant, CanvasManager, ide_event )->

  CeVolume = ( component )->
    if _.isString( component )
      @id = component
      @nodeType = "node"
      @type = constant.AWS_RESOURCE_TYPE.AWS_EBS_Volume
    else
      CanvasElement.apply( this, arguments )
    null


  CanvasElement.extend( CeVolume, constant.AWS_RESOURCE_TYPE.AWS_EBS_Volume )
  ChildElementProto = CeVolume.prototype


  ###
  # Child Element's interface.
  ###
  ChildElementProto.remove = ()->
    # # #
    # Quick Hack for supporting AppEdit
    # Ask the component if it supports AppEdit Mode
    #
    if @model.design().modeIsAppEdit()
      if (@model.get("owner") || {}).type is constant.AWS_RESOURCE_TYPE.AWS_AutoScaling_LaunchConfiguration
        notification "error", "This operation is not supported yet."
        return false
    #
    # #
    # # #
    CeVolume.super.remove.call this


  ChildElementProto.select = ( subId )->
    ide_event.trigger ide_event.OPEN_PROPERTY, @type, subId or @id
    MC.canvas.volume.select( @id )
    true

  null
