define [
    'constant'
    '../OsPropertyView'
    './template'
    'CloudResources'
], ( constant, OsPropertyView, template, CloudResources ) ->

    OsPropertyView.extend {

        events:

            "change [data-target]": "updateAttribute"

        render: ->

            if @model.owner()
                value = _.extend {
                    hasFloatIP: @model.getFloatingIp()
                }, @model.toJSON()
                @$el.html template.stack(value)
            else
                @$el.html template.unattached(value)
            @

        updateAttribute: (event)->

            $target = $(event.currentTarget)

            attr = $target.data 'target'
            value = $target.getValue()

            if attr is 'float_ip'
                @model.setFloatingIp(value)
            else
                @model.set(attr, value)

            @setTitle(value) if attr is 'name'

        }, {
            handleTypes: [ constant.RESTYPE.OSPORT ]
            handleModes: [ 'stack', 'appedit' ]
        }
