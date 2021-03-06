define [
    'toolbar_modal'
    'UI.modalplus'
    'component/awscomps/KpDialogTpl'
    'kp_upload'
    'backbone'
    'jquery'
    'constant'
    'JsonExporter'
    'CloudResources'
    'i18n!/nls/lang.js'
    'UI.notification'
], ( toolbar_modal, modalplus, template, upload, Backbone, $, constant, JsonExporter,CloudResources, lang ) ->

    download = JsonExporter.download

    Backbone.View.extend
        __needDownload: false
        __upload: null
        __import: ''
        __mode: 'normal'

        needDownload: () ->
            if arguments.length is 1
                @__needDownload = arguments[ 0 ]
                if arguments[ 0 ] is false
                    @M$( '.cancel' ).prop 'disabled', false
            else
                if @__needDownload then notification 'warning', lang.NOTIFY.YOU_MUST_DOWNLOAD_THE_KEYPAIR

            @__needDownload

        denySlide: () ->
            not @needDownload()

        getRegion: ->
            region = Design.instance().get('region')
            constant.REGION_SHORT_LABEL[ region ]

        getModalOptions: ->
            that = @
            region = Design.instance().get('region')
            regionName = constant.REGION_SHORT_LABEL[ region ]

            title:  sprintf lang.IDE.MANAGE_KP_IN_AREA, regionName
            slideable: _.bind that.denySlide, that
            resourceName: lang.PROP.RESOURCE_NAME_KEYPAIR
            context: that
            buttons: [
                {
                    icon: 'new-stack'
                    type: 'create'
                    name: lang.IDE.COMPONENT_CREATE_KEYPAIR
                }
                {
                    icon: 'import'
                    type: 'import'
                    name: lang.IDE.COMPONENT_IMPORT_KEY_PAIR
                }
                {
                    icon: 'del'
                    type: 'delete'
                    disabled: true
                    name: lang.IDE.COMPONENT_DELETE_KEY_PAIR
                }
                {
                    icon: 'refresh'
                    type: 'refresh'
                    name: ''
                }
            ]
            columns: [
                {
                    sortable: true
                    width: "40%" # or 40%
                    name: lang.IDE.COMPONENT_KEY_PAIR_COL_NAME
                }
                {
                    sortable: false
                    name: lang.IDE.COMPONENT_KEY_PAIR_COL_FINGERPRINT
                }
            ]

        initModal: () ->
            new toolbar_modal @getModalOptions()
            @modal.on 'close', () ->
                @remove()
            , @
            @modal.on 'slidedown', @renderSlides, @
            @modal.on 'action', @doAction, @
            @modal.on 'refresh', @refresh, @


        initialize: ( options ) ->
            _.extend @, options

            @collection = CloudResources Design.instance().credentialId(), constant.RESTYPE.KP, Design.instance().get("region")
            @initModal()
            @modal.render()

            if Design.instance().credential() and not Design.instance().credential().isDemo()
                that = @
                @collection.fetch().then ->
                    that.renderKeys()
            else
                @modal.render 'nocredential'

            @collection.on 'update', @renderKeys, @
            @listenTo Design.instance().credential(), "update", @credChanged
            @listenTo Design.instance().credential(), "change", @credChanged

        credChanged: ()->
            @collection.fetchForce()
            @modal.renderLoading()
            @modal and @refresh()

        renderKeys: () ->
            if not @collection.isReady()
                return false
            data = keys : @collection.toJSON()
            @modal.setContent template.keys data
            @

        __events:

            # actions
            'click #kp-create': 'renderCreate'
            'click #kp-import': 'renderImport'
            'click #kp-delete': 'renderDelete'
            'click #kp-refresh': 'refresh'

            # do action
            #'click .do-action': 'doAction'
            'click .cancel': 'cancel'

        downloadKp: ->
            @__downloadKp and @__downloadKp()

        doAction: ( action, checked ) ->
            @[action] and @[action](@validate(action), checked)

        validate: ( action ) ->
            switch action
                when 'create'
                    return not @M$( '#create-kp-name' ).parsley 'validate'
                when 'import'
                    return not @M$( '#import-kp-name' ).parsley 'validate'


        switchAction: ( state ) ->
            if not state
                state = 'init'

            @M$( '.slidebox .action' ).each () ->
                if $(@).hasClass state
                    $(@).show()
                else
                    $(@).hide()

        genDownload: ( name, str ) ->
            @__downloadKp = ->
                if $("body").hasClass("safari")
                  blob = null
                else
                  blob = new Blob [str]

                if not blob
                    options =
                        template        : template.safari_download keypair: str
                        title           : lang.IDE.TITLE_KEYPAIR_CONTENT
                        disableFooter   : true
                        disableClose    : true
                        width           : '855px'
                        height          : '473px'
                        compact         : true

                    new modalplus options
                    $('.safari-download-textarea').select()

                    return

                download( blob, name )


            @__downloadKp

        genDeleteFinish: ( times ) ->
            success = []
            error = []
            that = @

            finHandler = _.after times, ->
                that.cancel()
                if success.length is 1
                    console.debug success
                    notification 'info', sprintf lang.NOTIFY.XXX_IS_DELETED, success[0].attributes.keyName
                    return
                else if success.length > 1
                    notification 'info', sprintf lang.NOTIFY.SELECTED_KEYPAIRS_ARE_DELETED, success.length
                    return

                if not that.collection.toJSON().length
                    that.M$( '#t-m-select-all' )
                        .get( 0 )
                        .checked = false

                _.each error, ( s ) ->
                    console.log(s)
                if error.length > 0
                    notification 'error', lang.NOTIFY.FAILED_TO_DELETE_KP

            ( res ) ->
                console.debug res
                if not (res.reason|| res.msg)
                    success.push res
                else
                    error.push res

                finHandler()

        create: ( invalid ) ->
            that = @
            if not invalid
                keyName = @M$( '#create-kp-name' ).val()
                @switchAction 'processing'
                @collection.create( {keyName} ).save()
                    .then (res) ->
                        that.needDownload true
                        that.genDownload "#{res.attributes.keyName}.pem", res.attributes.keyMaterial
                        that.switchAction 'download'
                        that.M$( '.before-create' ).hide()
                        that.M$( '.after-create' ).find( 'span' ).text( res.attributes.keyName ).end().show()

                    ,( err ) ->
                        that.modal.error err.awsResult or err.reason or err.msg
                        that.switchAction()

        download: () ->
            @needDownload false
            @__downloadKp and @__downloadKp()
            null

        delete: ( invalid, checked ) ->
            count = checked.length

            onDeleteFinish = @genDeleteFinish count
            @switchAction 'processing'
            that = @
            _.each checked, ( c ) =>
                @collection.findWhere(keyName: c.data.name.toString()).destroy().then onDeleteFinish, onDeleteFinish
        import: ( invalid ) ->
            that = @
            if not invalid
                keyName = @M$( '#import-kp-name' ).val()
                @switchAction 'processing'
                try
                    keyContent = if Base64?.encode then Base64.encode(that.__upload.getData()) else window.btoa(that.__upload.getData())
                catch
                    @modal.error 'Key is not in valid OpenSSH public key format'
                    that.switchAction 'init'
                    return


                @collection.create( {keyName:keyName, keyData: keyContent}).save()
                    .then (res) ->
                        notification 'info', sprintf lang.NOTIFY.XXX_IS_IMPORTED, keyName
                        that.cancel()
                    ,( err ) ->
                        if err.awsResult and err.awsResult.indexOf( 'Length exceeds maximum of 2048' ) >= 0
                            msg = 'Length exceeds maximum of 2048'
                        else
                            msg = err.awsResult or err.error_message or err.reason or err.msg

                        that.modal.error msg
                        that.switchAction 'ready'

        cancel: ->
            @modal.cancel()

        refresh: ->
            @modal?.render "loading"
            @collection.fetchForce().then =>
              @renderKeys()

        renderSlides: ( which, checked ) ->
            tpl = template[ "slide_#{which}" ]
            slides = @getSlides()
            slides[ which ]?.call @, tpl, checked


        getSlides: ->
            that = @
            modal = @modal

            create: ( tpl, checked ) ->
                modal.setSlide tpl

            "delete": ( tpl, checked ) ->
                checkedAmount = checked.length

                if not checkedAmount
                    return

                data = {}

                if checkedAmount is 1
                    data.selecteKeyName = checked[ 0 ].data.name
                else
                    data.selectedCount = checkedAmount

                modal.setSlide tpl data

            import: ( tpl, checked ) ->
                modal.setSlide tpl
                that.__upload and that.__upload.remove()
                that.__upload = new upload({type: lang.IDE.LBL_PUBLIC_KEY})
                that.__upload.on 'load', that.afterImport, @
                that.M$( '.import-zone' ).html that.__upload.render().el


        afterImport: ( result ) ->
            @switchAction 'ready'
