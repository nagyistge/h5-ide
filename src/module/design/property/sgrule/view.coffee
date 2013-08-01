#############################
#  View(UI logic) for design/property/sgrule
#############################

define [ 'event', 'backbone', 'jquery', 'handlebars' ], ( ide_event ) ->

    SGRuleView = Backbone.View.extend {

        el       : $ document
        tagName  : $ '.property-details'

        template : Handlebars.compile $( '#property-sgrule-tmpl' ).html()

        events   :
            "click #sg-edit-rule-button" : "onEditRule"

        render     : () ->
            console.log 'property:sgrule render'

            this.model.attributes.isAppView = this.isAppView

            $( '.property-details' ).html this.template this.model.attributes

        onEditRule : ( event ) ->

            line_id = $("#property-sgrule").data('line')

            this.trigger "EDIT_RULE", line_id

        setAppView : ( isAppView ) ->
            this.isAppView = isAppView
            null


    }

    view = new SGRuleView()

    return view
