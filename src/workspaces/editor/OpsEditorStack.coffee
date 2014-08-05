
define [
  "./OpsEditorBase"
  "Design"
  "CloudResources"
  "constant"
], ( OpsEditorBase, Design, CloudResources, constant )->

  ###
    StackEditor is mainly for editing a stack
  ###
  class StackEditor extends OpsEditorBase

    title : ()-> (@design || @opsModel).get("name") + " - stack"

    isReady : ()->
      if not @opsModel.hasJsonData() or not @opsModel.isPersisted() then return false

      region      = @opsModel.get("region")
      stateModule = @opsModel.getJsonData().agent.module

      CloudResources( constant.RESTYPE.AZ, region ).isReady()   &&
      CloudResources( constant.RESTYPE.SNAP, region ).isReady() &&
      CloudResources( constant.RESTYPE.DBENGINE, region ).isReady() &&
      CloudResources( constant.RESTYPE.DBOG, region ).isReady() &&
      CloudResources( constant.RESTYPE.DBSNAP,   region ).isReady() &&
      CloudResources( "QuickStartAmi",       region ).isReady() &&
      CloudResources( "MyAmi",               region ).isReady() &&
      CloudResources( "FavoriteAmi",         region ).isReady() &&
      !!App.model.getStateModule( stateModule.repo, stateModule.tag ) &&
      @hasAmiData()

    fetchAdditionalData : ()->
      region      = @opsModel.get("region")
      stateModule = @opsModel.getJsonData().agent.module

      jobs = [
        App.model.fetchStateModule( stateModule.repo, stateModule.tag )
        CloudResources( constant.RESTYPE.AZ,   region ).fetch()
        CloudResources( constant.RESTYPE.SNAP, region ).fetch()
        CloudResources( constant.RESTYPE.DBENGINE, region ).fetch()
        CloudResources( constant.RESTYPE.DBOG, region ).fetch()
        CloudResources( constant.RESTYPE.DBSNAP,   region ).fetch()
        CloudResources( "QuickStartAmi",       region ).fetch()
        CloudResources( "MyAmi",               region ).fetch()
        CloudResources( "FavoriteAmi",         region ).fetch()
        @fetchAmiData()
      ]

      if not @opsModel.isPersisted() then jobs.unshift( @opsModel.save() )

      Q.all(jobs)

    hasAmiData : ()->
      json = @opsModel.getJsonData()
      cln  = CloudResources( constant.RESTYPE.AMI, @opsModel.get("region") )

      for uid, comp of json.component
        if comp.type is constant.RESTYPE.INSTANCE or comp.type is constant.RESTYPE.LC
          imageId = comp.resource.ImageId
          if imageId and not cln.get( imageId )
            return false

      true

    fetchAmiData : ()->
      json = @opsModel.getJsonData()
      toFetch = {}
      for uid, comp of json.component
        if comp.type is constant.RESTYPE.INSTANCE or comp.type is constant.RESTYPE.LC
          imageId = comp.resource.ImageId
          if imageId then toFetch[ imageId ] = true

      CloudResources( constant.RESTYPE.AMI, @opsModel.get("region") ).fetchAmis( _.keys toFetch )

    cleanup : ()->
      # Ask parent to cleanup first, so that removing opsModel won't trigger change event.
      OpsEditorBase.prototype.cleanup.call this

      # If the OpsModel doesn't exist in server, we would destroy it when the editor is closed.
      if not @opsModel.isPersisted()
        @opsModel.remove()
      return

    isModified : ()->
      if not @opsModel.isPersisted() then return true
      @design && @design.isModified()

  StackEditor