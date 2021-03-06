####################################
#  Controller for design/property/rtb module
####################################

define [ '../base/main',
         './model',
         './view',
         './app_model',
         './app_view',
         'event',
         'constant'
], ( PropertyModule, model, view, app_model, app_view, ide_event, constant ) ->

    RTBModule = PropertyModule.extend {

        handleTypes : [ constant.RESTYPE.RT, "RTB_Route", "RTB_Asso" ]

        initStack : () ->
            @model = model
            @model.isAppEdit = false
            @view  = view
            null

        initApp  : () ->
            @model = app_model
            @view  = app_view
            null

        initAppEdit  : () ->
            @model = model
            @model.isAppEdit = true
            @view  = view
            null

    }
    null
