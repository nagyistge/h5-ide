define [ 'constant', 'MC','i18n!/nls/lang.js' ], ( constant, MC, lang ) ->

    isAZAlone = () ->

        # check if have Instance/LSG
        instanceCount = _.countBy MC.canvas_data.component, (compObj) ->
            if compObj.type in [constant.RESTYPE.INSTANCE, constant.RESTYPE.LC]
                return 'instance'
            else
                return 'others'
        if !instanceCount.instance
            return null

        count = _.countBy MC.canvas_data.component, ( component ) ->
            if component.type is constant.RESTYPE.AZ then 'az' else 'others'

        if count.az > 1
            return null

        tipInfo = lang.TA.WARNING_SINGLE_AZ

        # return
        level   : constant.TA.WARNING
        info    : tipInfo

    # public
    isAZAlone : isAZAlone
