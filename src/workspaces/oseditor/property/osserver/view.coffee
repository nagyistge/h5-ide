define [
  'constant'
  '../OsPropertyView'
  './template'
  'CloudResources'
  'underscore'
], ( constant, OsPropertyView, template, CloudResources, _ ) ->

  OsPropertyView.extend {
    events:
      "change #property-os-server-credential": "onChangeCredential"
      "change #property-os-server-name": "updateServerAttr"
      "change #property-os-server-image": "updateServerAttr"
      "change #property-os-server-CPU":  "updateServerAttr"
      "change #property-os-server-RAM": "updateServerAttr"
      "change #property-os-server-keypair": "updateServerAttr"
      "change #property-os-server-adminPass": "updateServerAttr"
      "change #property-os-server-userdata": "updateServerAttr"


    render: ->
      console.log template
      @$el.html template.stackTemplate(@model.toJSON())
      @bindSelectizeEvent()
      @

    bindSelectizeEvent: ()->
      renderLoadingImageList = @renderLoadingImageList.bind @
      that = @

      that.$el.find('#property-os-server-image').on 'selectized', ->
        that.$el.find("#property-os-server-image")[0].selectize.on 'dropdown_open', renderLoadingImageList

    renderLoadingImageList: ()->
      @$el.find("#property-os-server-image")[0].selectize.lock()
      imageList = CloudResources( constant.RESTYPE.OSIMAGE,  "guangzhou" )
      imageList.fetch().then ->
        _.each imageList.toJSON(), (e)->
          console.log e

    onChangeCredential: (event)->
      result = $(event.currentTarget)
      if result.getValue() is "keypair"
        @$el.find("#property-os-server-keypair").parent().show()
        @$el.find('#property-os-server-adminPass').parent().hide()
      else
        @$el.find("#property-os-server-keypair").parent().hide()
        @$el.find('#property-os-server-adminPass').parent().show()

    updateServerAttr: (event)->
      console.log event

    selectTpl:

      imageItems: (item) ->
        return '<div><img class="property-os-image-icon" src="/assets/images/ide/ami/'+item.value+'" alt=""/><p class="property-os-image-text">' + item.text + '<span>'+item.value+'</span></p></div>'

      imageValue: (item) ->
        return '<div><img src="/assets/images/ide/ami/'+item.value+'" alt=""/>' + item.text + '</div>'

  }, {
    handleTypes: [ constant.RESTYPE.OSSERVER ]
    handleModes: [ 'stack', 'appedit' ]
  }

#  Panel.openProperty({uid:'server0001',type: "OS::Nova::Server"})