
define [ "backbone", "svgjs" ], ()->

  __detailExtend = Backbone.Model.extend
  ### env:dev ###
  __detailExtend = ( protoProps, staticProps )->
    ### jshint -W061 ###

    parent = this

    funcName = protoProps.ClassName || protoProps.type.split(".").pop()
    childSpawner = eval( "(function(a) { var #{funcName} = function(){ return a.apply( this, arguments ); }; return #{funcName}; })" )

    if protoProps and protoProps.hasOwnProperty "constructor"
      cstr = protoProps.constructor
    else
      cstr = ()-> return parent.apply( this, arguments )

    child = childSpawner( cstr )

    _.extend(child, parent, staticProps)

    funcName = "PROTO_" + funcName
    prototypeSpawner = eval( "(function(a) { var #{funcName} = function(){ this.constructor = a }; return #{funcName}; })" )

    Surrogate = prototypeSpawner( child )
    Surrogate.prototype = parent.prototype
    child.prototype = new Surrogate()

    if protoProps
      _.extend(child.prototype, protoProps)

    child.__super__ = parent.prototype
    ### jshint +W061 ###

    child
  ### env:dev:end ###


  SubElements = {}
  CanvasElement = Backbone.View.extend {

    initialize : ( options )->
      @canvas = options.canvas
      @$el = $()
      @addView( @create() )
      @render()
      return

    addView    : ( dom )->
      @$el = @$el.add if dom.node then dom.node else dom
      @

    remvoeView : ( dom )->
      @$el = @$el.not if dom.node then dom.node else dom
      @

    portPosition : ( portName )->
      if this.portPosMap then this.portPosMap[ portName ] else null

    render : ()->

    initNode : ( node, x, y )->
      node.move( x * MC.canvas.GRID_WIDTH, y * MC.canvas.GRID_HEIGHT )

      for child in node.children()
        cc = child.node
        if cc.tagName.toLowerCase() isnt "use" then continue

        name = child.attr("data-alias") or child.attr("data-name")
        if name
          pos = @portPosition( name )
          if pos
            child.move( pos[0], pos[1] )
      null

    createNode : ( option )->
      # A helper function to create a SVG Element to represent a group
      m = @model

      x      = m.x()
      y      = m.y()
      width  = m.width()  * MC.canvas.GRID_WIDTH
      height = m.height() * MC.canvas.GRID_HEIGHT

      svg = @canvas.svg
      el  = svg.group()

      el.add([
        svg.rect(width, height).radius(5).classes("node-background")
        svg.image( MC.IMG_URL + option.image, option.imageW, option.imageH ).move( option.imageX, option.imageY )
      ]).attr({ "data-id" : @cid }).classes( 'dragable ' + @type.replace(/\./g, "-") )

      if option.labelBg
        el.add( svg.use("label_path").classes("node-label-name-bg") )

      if option.label
        el.add( svg.plain(option.label).move( width/2, height-4 ).classes( "node-label" ) )

      if option.sg
        el.add(
          svg.group().add([
            svg.rect(7, 5).move(10, 6).classes('node-sg-color-border tooltip')
            svg.rect(7, 5).move(20, 6).classes('node-sg-color-border tooltip')
            svg.rect(7, 5).move(30, 6).classes('node-sg-color-border tooltip')
            svg.rect(7, 5).move(40, 6).classes('node-sg-color-border tooltip')
            svg.rect(7, 5).move(50, 6).classes('node-sg-color-border tooltip')
          ]).classes("node-sg-color-group").move(8,63)
        )

      el

    createGroup : ()->
      # A helper function to create a SVG Element to represent a group
      m = @model

      x      = m.x()
      y      = m.y()
      width  = m.width()  * MC.canvas.GRID_WIDTH
      height = m.height() * MC.canvas.GRID_HEIGHT

      pad = 10

      svg = @canvas.svg
      el  = svg.group()

      el.add([
        svg.rect(width, height).radius(5).classes("group")

        svg.rect( width - 2*pad, pad  ).x(pad).classes("group-resizer top")
        svg.rect( pad, height - 2*pad ).y(pad).classes("group-resizer left")
        svg.rect( pad, height - 2*pad ).move(width - pad, pad).classes("group-resizer right")
        svg.rect( width - 2*pad, pad  ).move(pad, height - pad).classes("group-resizer bottom")

        svg.rect( pad, pad ).classes("group-resizer topleft")
        svg.rect( pad, pad ).x(width - pad).classes('group-resizer topright')
        svg.rect( pad, pad ).y(height - pad).classes("group-resizer bottomleft")
        svg.rect( pad, pad ).move(width - pad, height - pad).classes("group-resizer bottomright")

        svg.text("").move(5,15).classes("group-label")
      ]).attr({ "data-id" : @cid }).classes("dragable " + @type.replace(/\./g, "-") )

  }, {

    getClassByType : ( type )-> SubElements[ type ]

    extend : ( protoProps, staticProps ) ->
      console.assert protoProps.type, "Subclass of CanvasElement does not specifying a type"

      staticProps = staticProps || {}
      staticProps.type = protoProps.type

      # Create subclass
      subClass = __detailExtend.call( this, protoProps, staticProps )

      SubElements[ protoProps.type ] = subClass
      subClass
  }

  CanvasElement.constant =
    PORT_RIGHT_ANGLE  : 0
    PORT_UP_ANGLE     : 90
    PORT_LEFT_ANGLE   : 180
    PORT_DOWN_ANGLE   : 270

  CanvasElement
