
define [
  "ide/submodels/OpsCollection"
  "Credential"
  "backbone"
], ( OpsCollection, Credential )->


  MEMBERROLE =
    ADMIN    : "admin"
    MEMBER   : "collaborator"
    OBSERVER : "observer"


  Backbone.Model.extend {

    ###
    # Possible events that will trigger on this model:
    `change:credential`
    ###
    defaults : ()->
      name         : ""
      billingState : ""
      tokens       : []
      credentials  : []
      stacks       : new OpsCollection()
      apps         : new OpsCollection()
      history      : new Backbone.Collection()
      audits       : new Backbone.Collection()
      myRole       : "observer"
      private      : false

    initialize : ( attr )->
      # Normal attr
      @set {
        id      : attr.id
        name    : attr.name or "Private Project"
        private : !attr.name
      }

      # Token
      for t, idx in attr.tokens
        if not t.name
          @attributese.defaultToken = t.token
        else
          @attributes.tokens.push t

      # Credential
      self  = @
      onCredChange = ()-> self.trigger "change:credential", @

      opts  = { project : @ }
      for cred in attr.credential
        credObj = new Credential( cred, opts )
        credObj.on "change", onCredChange
        @attributes.credentials.push credObj

      # Check my role
      @__checkMyRole( attr.members )
      return


    # Getters.
    stacks       : ()-> @get("stacks")
    apps         : ()-> @get("apps")
    credentials  : ()-> @get("credentials")
    history      : ()-> @get("history")
    audits       : ()-> @get("audits")
    tokens       : ()-> @get("tokens")
    defaultToken : ()-> @get("defaultToken")


    # Convenient Methods
    isPrivate     : ()-> @get("private")
    hasCredential : ()-> @get("credentials").length > 0

    amIAdmin    : ()-> @get("myRole") is MEMBERROLE.ADMIN
    amIMeber    : ()-> @get("myRole") is MEMBERROLE.MEMBER
    amIObserver : ()-> @get("myRole") is MEMBERROLE.OBSERVER


    # Token related. Unlike credential,
    # token is managed through project object. Since they are really lightweight.
    createToken : ()->
      tmpl = "MyToken"
      base = 1
      nameMap = {}
      for t in @attributes.tokens
        nameMap[ t.name ] = true

      while true
        newName = tmpl + base
        if nameMap[ newName ]
          base += 1
        else
          break

      self = this
      ApiRequest("token_create", {token_name:newName}).then (res)->
        self.attributes.tokens.splice 0, 0, {
          name  : res[0]
          token : res[1]
        }

    removeToken : (token)->
      for t, idx in @attributes.tokens
        if t.token is token
          break

      self = this
      ApiRequest("token_remove", {token:token,token_name:t.name}).then ( res )->
        idx = self.attributes.tokens.indexOf t
        if idx >= 0
          self.attributes.tokens.splice idx, 1

    updateToken : ( token, newName )->
      self = this
      ApiRequest("token_update", {token:token, new_token_name:newName}).then ( res )->
        for t, idx in self.attributes.tokens
          if t.token is token
            t.name = newName
            break




        createImportOps : ( region, provider, msrId )->
      m = @attributes.appList.findWhere({importMsrId:msrId})
      if m then return m
      m = new OpsModel({
        name        : "ImportedApp"
        importMsrId : msrId
        region      : region
        provider    : provider
        state       : OpsModel.State.Running
      })
      @attributes.appList.add m
      m


    # OpsModel Related.

    # This method creates a new stack in IDE, and returns that model.
    # The stack is not automatically stored in server.
    # You need to call save() after that.
    createStack : ( region, provider = Credential.PROVIDER.AWSGLOBAL )->
      @stacks().add( new OpsModel({
        region   : region
        provider : provider
      }, {
        initJsonData : true
      }) )

    createStackByJson : ( json, updateLayout = false )->
      @stacks().add( new OpsModel({
        name       : json.name
        region     : json.region
        autoLayout : updateLayout
        __________itsshitdontsave : updateLayout
      }, {
        jsonData : json
      }) )

    __parseListRes : ( res )->
      r = []

      for ops in res
        r.push {
          id         : ops.id
          updateTime : ops.time_update
          region     : ops.region
          usage      : ops.usage
          name       : ops.name
          version    : ops.version
          provider   : ops.provider
          state      : OpsModel.State[ ops.state ] || OpsModel.State.UnRun
          stoppable  : not (ops.property and ops.property.stoppable is false)
        }
      r

    __checkMyRole : ( members )->
      username = App.user.get("username")
      for m in members
        if m.id is username
          @set "myRole", m.role
          return
  }, {
    MEMBERROLE : MEMBERROLE
  }
