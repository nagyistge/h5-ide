

define ["Scene", "./ProjectView", "Workspace"], ( Scene, ProjectView, Workspace )->

  # The ProjectScene work with Workspace objects. It's a Workspace Manager itself.

  class ProjectScene extends Scene

    type : "ProjectScene"

    constructor : ( projectId, opsmodelId )->
      ss = App.sceneManager.find( projectId )

      if ss
        ss.activate()
        ss.loadSpace( opsmodelId )
        return ss

      return Scene.call this, { pid : projectId, opsid : opsmodelId }

    initialize : ( attr )->
      console.log "ProjectScene"
      self = @
      @__spaces     = []
      @__awakeSpace = null
      @__spacesById = {}

      @project = App.model.projects().get( attr.pid ) || App.model.getPrivateProject()
      @view    = new ProjectView { scene : @ }
      console.log @view, "ProjectScene"
      @listenTo @view, "wsOrderChanged", ()->   @__updateSpaceOrder()
      @listenTo @view, "wsClicked",      (id)-> @awakeSpace( id )
      @listenTo @view, "wsClosed",       (id)-> @removeSpace( id )

      @activate()
      self.loadDashboard()
      self.loadSpace( attr.opsid )
      return

    becomeActive : ()->
      @view.$el.show()
      @updateUrl()
      @updateTitle()
      # # Remove all other projects
      # for s in App.sceneManager.scenes()
      #   if s.type is "ProjectScene" and s is @
      #     s.remove()
      # return

    isRemovable    : ()-> _.all @__spaces, ( ws )-> !ws.isModified()
    becomeInactive : ()-> Scene.prototype.becomeInactive.call this
    cleanup        : ()-> Scene.prototype.cleanup.call this

    isWorkingOn : ( projectId )-> @project.id is projectId

    title : ()->
      name = @project.get("name")
      if @getAwakeSpace()
        name = @getAwakeSpace().title() + " on " + name
      name

    url   : ()->
      basic = @project.url() + "/"
      if @getAwakeSpace()
        basic += @getAwakeSpace().url()

      basic.replace /\/+$/, ""


    ### -------------------------------
    # Funtions to manage the workspaces.
    ------------------------ ###
    # Load a workspace to work with the specified opsmodel.
    loadSpace : ( opsModelOrId )->
      if not opsModelOrId
        return @loadDashboard()

      attr = {
        opsModel : if _.isString(opsModelOrId) then @project.getOpsModel(opsModelOrId) else opsModelOrId
      }

      if not attr.opsModel then return

      (@createSpace(attr)).activate()
      return

    loadDashboard : ()-> (@createSpace({type:"Dashboard"})).activate()

    createSpace : ( data )->
      existing = @findSpace(data)
      if existing then return existing

      SpaceClass = Workspace.findSuitableSpace( data )
      console.assert( SpaceClass, "Cannot find suitable workspace to work with the data", data )
      new SpaceClass( data, {scene:@} )

    spaceParentElement : ()-> @view.$wsparent

    __updateSpaceOrder : ()->
      dict = @__spacesById
      @__spaces = @view.spaceOrder().map (id)-> dict[id]
      return

    updateSpace : ( workspace )->
      if workspace is @__awakeSpace
        @updateUrl()
        @updateTitle()

      @view.updateSpace workspace.id, workspace.title(), workspace.tabClass()
      workspace

    # Returns all the spaces that is within current scene
    spaces : ()-> @__spaces.slice(0)

    getAwakeSpace : ()-> @__awakeSpace
    getSpace      : ( spaceId )-> @__spacesById[ spaceId ]
    findSpace     : ( attribute )-> _.find @__spaces, ( space )-> space.isWorkingOn( attribute )

    moveSpace : ( workspace, idx )->
      @view.moveSpace workspace.id, workspace.isFixed(), idx
      @__updateSpaceOrder()
      return

    # This method is only used by Workspace.
    addSpace : ( workspace )->
      if @__spacesById[ workspace.id ] then return

      @__spacesById[ workspace.id ] = workspace

      @view.addSpace {
        title    : workspace.title()
        id       : workspace.id
        closable : not workspace.isFixed()
        klass    : workspace.tabClass()
      }, -1, workspace.isFixed()

      @__updateSpaceOrder()

      if @__spaces.length is 1
        @awakeSpace( workspace )

      workspace

    awakeSpace : ( workspace )->
      if not workspace then return

      if _.isString(workspace) then workspace = @__spacesById[workspace]

      if @__awakeSpace is workspace then return

      if workspace.isRemoved() then return

      if @__awakeSpace then @__awakeSpace.sleep()

      @__awakeSpace = workspace

      @updateTitle()
      @updateUrl()

      @view.awakeSpace( workspace.id )

      promise = workspace.awake()
      if promise and promise.then and promise.isFulfilled and not promise.isFulfilled()
        promise.then ()=> @view.hideLoading()
        @view.showLoading()
      else
        @view.hideLoading()
      return

    removeSpace : ( workspace, force )->
      if not workspace then return

      if _.isString(workspace) then workspace = @__spacesById[workspace]

      if not force and not workspace.isRemovable() then return

      id = workspace.id

      @view.removeSpace( id )
      delete @__spacesById[id]
      @__spaces.splice (@__spaces.indexOf workspace), 1

      workspace.stopListening()
      workspace.cleanup()

      if @__awakeSpace is workspace
        @__awakeSpace = null
        @awakeSpace( @__spaces[ @__spaces.length - 1 ] )

      workspace

    removeAllSpaces : ()->
      for space in @spaces()
        @removeSpace( space, true )
      return

    removeNotFixedSpaces : ( filter )->
      for space in @spaces()
        if not space.isFixed() and ( not filter or filter(space) )
          @removeSpace( space, true )
      return

  Scene.SetDefaultScene ProjectScene

  ProjectScene

