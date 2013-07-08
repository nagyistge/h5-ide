####################################
#  Controller for design/canvas module
####################################

define [ 'jquery', 'text!/module/design/canvas/template.html', 'event' ], ( $, template, ide_event ) ->

    #private
    loadModule = () ->

        #load remote module1.js
        require [ './module/design/canvas/view' ], ( View ) ->

            #view
            view       = new View()
            view.render template

            #listen RELOAD_RESOURCE
            ide_event.onLongListen ide_event.RELOAD_RESOURCE, ( region_name, type ) ->
                console.log 'canvas:RELOAD_RESOURCE'
                #temp
                if type is 'NEW_STACK'
                    require [ 'canvas_layout' ], ( canvas_layout ) -> MC.canvas.layout.create(region_name)
                else if type is 'OPEN_STACK'
                    require [ 'canvas_layout' ], ( canvas_layout ) -> canvas_layout.ready()
                null


    unLoadModule = () ->
        #view.remove()

    #public
    loadModule   : loadModule
    unLoadModule : unLoadModule