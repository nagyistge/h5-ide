
define [ "ApiRequest", "backbone" ], ( ApiRequest )->

  __maskString = ( text )->
    if text.length > 6
      return (new Array(text-6)).join("*")+text.substr(-6)
    else
      return text

  ###
  # Credential is a model used to represent the credential item of a project.
  # One can obtain the particular credential of a project, then update it with the
  # credential's method.
  ###
  PLATFORM =
    AWS       : "aws"
    OPENSTACK : "openstack"

  PROVIDER =
    AWSGLOBAL : "aws::global"
    AWSCHINA  : "aws::china"


  Credential = Backbone.Model.extend {

    ###
    attr :
      id           : ""
      platform     : ""
      provider     : ""
      isDemo       : ""
      awsAccount   : ""
      awsAccessKey : ""
      awsSecretKey : ""
    ###
    constructor : ( attr, option )->
      Backbone.Model.call this
      console.assert( option && option.project )

      @set {
        project      : option.project
        id           : attr.id
        provider     : attr.provider
        platform     : attr.cloud_type
        isDemo       : attr.is_demo
        alias        : attr.alias
        awsAccount   : attr.account_id
        awsAccessKey : attr.access_key
        awsSecretKey : attr.secret_key
      }
      return

    isDemo   : ()-> !!@get("isDemo")
    platform : ()-> @get("platform")

    __update : ( cred, forceUpdate )->
      ApiRequest( "project_update_credential", {
        project_id   : @get("project").id
        key_id       : @id
        credential   : {
          alias      : cred.alias
          account_id : cred.awsAccount
          access_key : cred.awsAccessKey
          secret_key : cred.awsSecretKey
        }
        force_update : forceUpdate
      } )

    ###
    cred : {
      provider     : ""
      awsAccount   : ""
      awsAccessKey : ""
      awsSecretKey : ""
    }
    ###
    validate : ( cred )->
      cred = $.extend {}, cred
      cred.provider = @get("provider")
      Credential.validate( cred )

    formatCredForRequest: ( cred ) ->
      {
        alias      : cred.alias
        account_id : cred.awsAccount
        access_key : cred.awsAccessKey
        secret_key : cred.awsSecretKey
        provider   : cred.provider or PROVIDER.AWSGLOBAL
      }

    add: () ->
      model = @
      credential = @formatCredForRequest @toJSON()
      project = @get( 'project' )

      ApiRequest( "project_add_credential", {
        project_id: project.id
        credential: credential
      }).then ( res ) ->
        model.set 'id', res[ 1 ]
        project.credentials().push model

        res

    ###
    cred : {
      awsAccount   : ""
      awsAccessKey : ""
      awsSecretKey : ""
    }
    ###
    update : ( cred, forceUpdate = false )->
      self = @
      credential = @formatCredForRequest cred
      p = @__update( credential, forceUpdate )

      p.then ( res )->
        self.set {
          alias        : cred.alias
          awsAccount   : cred.awsAccount
          awsAccessKey : __maskString( cred.awsAccessKey )
          awsSecretKey : __maskString( cred.awsSecretKey )
        }

    save: ( cred, forceUpdate = false, valid = true ) ->
      cred = @toJSON() unless cred

      if @id
        @update cred, forceUpdate, valid
      else
        @add cred, valid

    destroy: ( options ) ->
      model = @
      projectId = @get( 'project' ).id
      ApiRequest( "project_remove_credential", { project_id: projectId, key_id: @id } ).then ( res )->
        model.trigger 'destroy', model, model.collection, options
        res

  }, {
    PLATFORM : PLATFORM
    PROVIDER : PROVIDER

    ###
    credential : {
      provider     : ""
      awsAccount   : ""
      awsAccessKey : ""
      awsSecretKey : ""
    }
    ###
    #validate : ( credential )-> ApiRequest( "project_validate_credential", {credential:credential} )
  }

  Credential
