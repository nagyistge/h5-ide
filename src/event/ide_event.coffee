###

###

define [ 'underscore', 'backbone' ], () ->

    ###
    #private
    event = {
        NAVIGATION_COMPLETE : 'NAVIGATION_COMPLETE'
    }

    #bind event to Backbone.Events
    _.extend event, Backbone.Events

    #public
    event
    ###

    class Event

        #temp
        NAVIGATION_COMPLETE : 'NAVIGATION_COMPLETE'
        HEADER_COMPLETE     : 'HEADER_COMPLETE'
        DASHBOARD_COMPLETE  : 'DASHBOARD_COMPLETE'
        DESIGN_COMPLETE     : 'DESIGN_COMPLETE'
        RESOURCE_COMPLETE   : 'RESOURCE_COMPLETE'
        DESIGN_SUB_COMPLETE : 'DESIGN_SUB_COMPLETE'
        #
        RELOAD_RESOURCE     : 'RELOAD_RESOURCE'
        OPEN_PROPERTY       : 'OPEN_PROPERTY'
        OPEN_SG             : 'OPEN_SG'
        OPEN_INSTANCE       : 'OPEN_INSTANCE'

        #
        ADD_STACK_TAB       : 'ADD_STACK_TAB'
        OPEN_STACK_TAB      : 'OPEN_STACK_TAB'
        OPEN_APP_TAB        : 'OPEN_APP_TAB'
        #
        SWITCH_TAB          : 'SWITCH_TAB'
        SWITCH_DASHBOARD    : 'SWITCH_DASHBOARD'

        TERMINATE_APP_TAB   : 'TERMINATE_APP_TAB'

        SAVE_DESIGN_MODULE  : 'SAVE_DESIGN_MODULE'

        #result app stack region empty_region list
        RESULT_APP_LIST     : 'RESULT_APP_LIST'
        RESULT_STACK_LIST   : 'RESULT_STACK_LIST'
        RESULT_EMPTY_REGION_LIST  : 'RESULT_EMPTY_REGION_LIST'

        #return overview region tab
        RETURN_OVERVIEW_TAB : 'RETURN_OVERVIEW_TAB'
        RETURN_REGION_TAB   : 'RETURN_REGION_TAB'

        #app/stack in region
        APP_RUN             : 'APP_RUN'
        APP_STOP            : 'APP_STOP'
        APP_TERMINATE       : 'APP_TERMINATE'
        UPDATE_APP_LIST     : 'UPDATE_APP_LIST'
        UPDATE_STACK_LIST   : 'UPDATE_STACK_LIST'
        STACK_DELETE        : 'STACK_DELETE'

        #navigation to dashboard - region
        NAVIGATION_TO_DASHBOARD_REGION : 'NAVIGATION_TO_DASHBOARD_REGION'

        constructor : ->
            _.extend this, Backbone.Events

        onListen : ( type ,callback ) ->
            this.once type, callback

        onLongListen : ( type ,callback ) ->
            this.on type, callback

    event = new Event()

    event
