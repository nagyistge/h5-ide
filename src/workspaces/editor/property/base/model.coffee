
####################################
#  Base Class for Model of Property Module
####################################

define [ 'backbone', 'Design', "constant" ], ( Backbone, Design, constant )->

    ###

    -------------------------------
     PropertyModel is a base class that every property view should inherit.
    -------------------------------

    ###

    PropertyModel = Backbone.Model.extend {

        init : () ->
            null

        setName : ( name )->
            id = @get("uid")
            console.assert( id, "This property model doesn't have an id" )

            Design.instance().component( id ).setName( name )
            @set "name", name
            null


        isNameDup : ( newName )->

            id = @get("uid")
            console.assert( id, "This property model doesn't have an id" )

            comp = Design.instance().component( id )

            if comp.get("name") is newName
                return false

            dup = false
            Design.instance().eachComponent ( comp )->
                if comp.get("name") is newName
                    dup = true
                    return false

            dup

        isOldName: (newName)->
            originJson = Design.instance().__opsModel.getJsonData()
            dup = false
            if originJson.component
                _.each originJson.component, (comp, key)->
                    if comp.type in [constant.RESTYPE.ELB, constant.RESTYPE.ASG, constant.RESTYPE.LC, constant.RESTYPE.SP, constant.RESTYPE.SA, constant.RESTYPE.CW] and comp.name is newName
                        dup = true
                        return false
            dup

        isReservedName : ( newName ) ->

            result = false
            if newName in ['self', 'this', 'global', 'meta', 'madeira']
                result = true

            return result
    }

    PropertyModel
