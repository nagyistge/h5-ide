####################################
#  Controller for design/property/sg module
####################################

define [ 'jquery',
         'text!/module/design/property/sg/template.html',
         'event'
], ( $, template, ide_event ) ->

    #private
    loadModule = ( uid_parent, expended_accordion_id ) ->

        #add handlebars script
        template = '<script type="text/x-handlebars-template" id="property-sg-tmpl">' + template + '</script>'
        #load remote html template
        $( 'head' ).append template

        #
        require [ './module/design/property/sg/view', './module/design/property/sg/model' ], ( view, model ) ->

            #view
            view.model    = model

            if uid_parent
                if uid_parent.uid

                    view.model.getSG uid_parent.uid, uid_parent.parent

                else

                    view.model.addSG uid_parent.parent
            else

                view.model.addSG()

            #render
            view.render( expended_accordion_id )
            
            view.on 'SET_SG_NAME', ( uid, value ) ->

                model.setSGName uid, value

                view.render()

            view.on 'REMOVE_SG_RULE', ( uid, rule )->

                model.removeSGRule uid, rule

            view.on 'SET_SG_RULE', ( uid, rule ) ->

                model.setSGRule uid, rule

            view.on 'SET_SG_DESC', ( uid, value ) ->

                model.setSGDescription uid, value


    unLoadModule = () ->
        #view.remove()

    #public
    loadModule   : loadModule
    unLoadModule : unLoadModule