####################################
#  Controller for navigation module
####################################

define [ 'jquery',
         'event',
         'base_main'
], ( $, ide_event, base_main ) ->

    #private
    initialize = ->
        #extend parent
        _.extend this, base_main

    initialize()

    #private
    loadModule = () ->

        #load remote /module/navigation/view.js
        require [ 'navigation_view', 'navigation_model', 'UI.tooltip', 'hoverIntent' ], ( View, model ) ->

            #view
            #view       = new View()

            view = loadSuperModule loadModule, 'navigation', View, null
            return if !view

            view.model = model
            #refresh view
            view.render()

            #listen vo set change event
            model.on 'change:app_list', () ->
                console.log 'change:app_list'
                #push event
                ide_event.trigger ide_event.RESULT_APP_LIST, model.get 'app_list'
                #refresh view
                view.appListRender()
                #call
                model.stackListService()

            model.on 'change:stack_list', () ->
                console.log 'change:stack_list'
                #push event
                ide_event.trigger ide_event.RESULT_STACK_LIST, model.get 'stack_list'
                #refresh view
                view.stackListRender()
                #call
                model.regionEmptyList()

            model.on 'change:region_empty_list', () ->
                console.log 'change:region_empty_list'
                #push event
                ide_event.trigger ide_event.RESULT_EMPTY_REGION_LIST, null
                #refresh view
                view.regionEmtpyListRender()
                #call
                model.describeRegionsService()

            model.on 'change:region_list', () ->
                console.log 'change:region_list'
                #refresh view
                view.regionListRender()

            #model
            model.appListService()

            ide_event.onLongListen ide_event.UPDATE_APP_LIST, () ->
                console.log 'UPDATE_APP_LIST'
                #call
                model.appListService()

            ide_event.onLongListen ide_event.UPDATE_STACK_LIST, () ->
                console.log 'UPDATE_STACK_LIST'
                #call
                model.stackListService()

            ide_event.onLongListen ide_event.UPDATE_AWS_CREDENTIAL, () ->
                console.log 'navigation:UPDATE_AWS_CREDENTIAL'
                #call
                model.describeRegionsService() if MC.forge.cookie.getCookieByName('has_cred') is 'true'

    unLoadModule = () ->
        #view.remove()

    #public
    loadModule   : loadModule
    unLoadModule : unLoadModule
