
define ["ApiRequest", "backbone"], ( ApiRequest )->

  Backbone.Model.extend {

    constructor : ( attr, options )->
      Backbone.Model.call this, attr, options

      if options and options.RES_TAG
        @RES_TAG = options.RES_TAG

      return

    # Returns a promise which will be resolved when the model is saved to AWS, the resolved data is the model itself
    save : ()->
      if @get("id")
        console.error "The resource is already created. You cannot re-create it again."
        return

      # prevent saving multiple time.
      if not @__savePromise
        self = @
        @__savePromise = @doCreate().then ()->
            self.__collection.add self
            self.tagResource()
            delete self.__collection
            delete self.__savePromise
            self
          , ( error )->
            delete self.__savePromise
            throw error

      @__savePromise

    # Returns a promise which will be resolved when the model is updated.
    update : ( newAttr )->
      if not @get("id")
        console.error "The resource is not yet created, so you can't update the resource.", @
        return

      if not @doUpdate
        console.error "This kind of resource does not support update,", @getCollection().type
        return

      @doUpdate( newAttr )

    # Returns a promise which will be resolved when the model is deleted from AWS
    # When the model is removed, the model will stop listening to any event.
    destroy : ()->
      self = @
      @doDestroy().then ()->
        self.getCollection().remove self
        self
      , (err)->
        # If AWS fail to remove an resource due to `ID.NotFound`, we treat it as
        # the resource is removed.
        if err.awsError is 400 and err.awsErrorCode.indexOf(".NotFound") != -1
          self.getCollection().remove self
          return self

        throw err

    # A convenient method to call ApiRequest
    sendRequest : ( api, params )->
      params = params || {}
      if params.key_id is undefined
        params.key_id = @getCollection().credential()

      if params.region_name is undefined
        # If the region is empty, we DONT assign the empty region to region_name
        # Since ApiRequest will fill a region for us. In such case the region_name
        # is actually useless, but the backend needs it to bypass somekind of check.
        if @getCollection().region()
          params.region_name = @getCollection().region()
        else if @get("category")
          params.region_name = @get("category")

      ApiRequest( api, params )

    # Subclass needs to override these method.
    ###
    dosave    : ()->
    doUpdate  : ( newAttr )->
    doDestroy : ()->
    ###

    getCollection : ()-> @__collection || @collection

    # Tags this resource. It should only called right after the resource is created.
    tagResource : ()->
      if @taggable is false then return

      self = @
      @sendRequest("ec2_CreateTags",{
        resource_ids : [@get("id")]
        tags         : [{Name:"Created by",Value:App.user.get("username")}]
      }).then ()->
        console.log "Success to tag resource", self.get("id")
        return

  }, {
    extend : window.__detailExtend || Backbone.Model.extend
  }
