
define [
    'backbone'
    'constant'
    '../template/TplPanel'
    './panels/ResourcePanel'
    './panels/ConfigPanel'
    './panels/PropertyPanel'
    './panels/StatePanel'

], ( Backbone, constant, PanelTpl, ResourcePanel, ConfigPanel, PropertyPanel, StatePanel )->

  Panels = {
    resource : ResourcePanel
    config   : ConfigPanel
    property : PropertyPanel
    state    : StatePanel
  }

  Backbone.View.extend

    events:
        'click .anchor li'       : '__scrollTo'
        'click .sidebar-title a' : '__openPanel'

    initialize: ( options ) ->
        _.extend this, options
        @render()

    render: () ->
        @setElement @parent.$el.find(".OEPanelRight")

        @$el.html PanelTpl {}
        @open 'resource'

        @

    renderSubPanel: ( subPanel, args ) ->
        @$( '.panel-body' ).html new subPanel( args ).render().el

    scrollTo: ( className ) ->
        $container = @$ '.panel-body'
        $target = $( "section.#{className}" )

        top = $container.offset().top
        newTop = $target.offset().top - top + $container.scrollTop()

        $container.animate scrollTop: newTop

    open: ( panelName, args = {} ) ->
        targetPanel = Panels[ panelName ]
        unless targetPanel then return

        @$el.removeClass( 'hide' )
        isCurrentPanel = @$el.hasClass panelName
        if isCurrentPanel then return

        @$el.prop 'class', "OEPanelRight #{panelName}"
        @renderSubPanel targetPanel, args

    openProperty: ( args ) ->
        @open 'property', args

    __openPanel: ( e ) ->
        targetPanelName = $( e.currentTarget ).prop 'class'
        @open targetPanelName

    __scrollTo: ( e ) ->
        targetClassName = $( e.currentTarget ).data 'scrollTo'
        @scrollTo targetClassName