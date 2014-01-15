#############################
#  View(UI logic) for design/property/sgrule
#############################

define [ '../base/view',
         'text!./template/stack.html',
         "component/sgrule/SGRulePopup"
], ( PropertyView, template, SGRulePopup ) ->

    template = Handlebars.compile template

    SgRuleView = PropertyView.extend {
        events   :
            "click #sg-edit-rule-button" : "onEditRule"

        render : () ->
            for group in @model.attributes.groups
                group.ruleListTpl = MC.template.sgRuleList( group.rules )

            @$el.html template @model.attributes

            "Security Group Rule"

        onEditRule : ( event ) ->
            new SGRulePopup( @model.get("uid") )
            false

    }

    new SgRuleView()
