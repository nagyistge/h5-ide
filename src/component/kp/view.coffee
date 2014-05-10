define [ './template', './template_modal', 'backbone', 'jquery', 'constant' ], ( template, template_modal, Backbone, $, constant ) ->
    modalView = Backbone.View.extend
        initialize: () ->
            @model.on 'change:keys', () ->
                @render true
            , @

        render: (refresh) ->
            data = @model.toJSON()
            region = Design.instance().get('region')
            data.regionName = constant.REGION_SHORT_LABEL[ region ]
            @$el.html template_modal.frame data
            if not refresh
                @open()
            @

        renderLoading: () ->
            @$( '.content-wrap' ).html template_modal.loading

        stopPropagation: ( event ) ->
            exception = '.sortable'
            if not $(event.target).is( exception )
                event.stopPropagation()

        open: () ->
            modal @el
            $( '#modal-wrap' ).click @stopPropagation

        showErr: (msg) ->
            @$( '.error' ).text( msg ).show()

        hideErr: () ->
            @$( '.error' ).hide()

        events:
            'click .modal-close' : 'close'
            'change #kp-select-all': 'checkAll'
            'change .one-cb': 'checkOne'

            # actions
            'click #create-kp': 'renderCreate'
            'click #kp-import': 'renderImport'
            'click #kp-delete': 'renderDelete'
            'click #kp-refresh': 'refresh'

            # do action
            'click .do-action': 'doAction'
            'click .cancel': 'cancel'

        doAction: ( event ) ->
            action = $( event.currentTarget ).data 'action'
            @[action] and @[action](@validate(action))

        validate: ( action ) ->
            switch action
                when 'create'
                    return not @$( '#create-kp-name' ).parsley 'validate'

        processing: ( action ) ->
            switch action
                when 'create'
                    @$( '.do-action' )
                        .prop( 'disabled', true )
                        .text ( 'Creating' )


        create: ( invalid ) ->
            that = @
            if not invalid
                keyName = @$( '#create-kp-name' ).val()
                @processing 'create'
                @model.create( keyName ).then (
                    ( res ) ->
                        console.log(res)
                    ( error ) ->
                        console.log(error);
                )


        delete: () ->

        import: () ->


        cancel: ->
            $content = @$( '.content-wrap' )
            $slidebox = @$( '.slidebox' )
            $content.removeClass( 'show-create show-import show-delete' )
            $slidebox.removeClass 'show'

        refresh: ->
            @model.getKeys()
            @renderLoading()


        renderSlide: ( html ) ->
            @$( '.slidebox .content' ).html html


            @

        # if the type need rendered return true
        # or return false
        preSlide: ( type ) ->
            $content = @$( '.content-wrap' )
            $slidebox = @$( '.slidebox' )
            currentType = $content.hasClass "show-#{type}"
            if not currentType
                $content
                    .removeClass( 'show-create show-import show-delete' )
                    .addClass( "show-#{type}" )

                $slidebox.addClass 'show'
            else
                $content.removeClass( 'show-create show-import show-delete' )
                $slidebox.removeClass 'show' # for transition effective

            not currentType

        renderCreate: () ->
            if @preSlide 'create'
                tpl = template_modal.slideCreate

                data = {}
                html = tpl data
                @renderSlide html

        renderDelete: () ->
            if @preSlide 'delete'
                tpl = template_modal.slideDelete

                data = {}
                html = tpl data
                @renderSlide html

        renderImport: () ->
            if @preSlide 'import'
                tpl = template_modal.slideImport

                data = {}
                html = tpl data
                @renderSlide html



        checkOne: ( event ) ->
            if event.currentTarget.id isnt 'kp-select-all'
                cbAll = @$ '#kp-select-all'
                cbAmount = @model.get( 'keys' ).length
                checkedAmount = @$('.one-cb:checked').length
                if checkedAmount is cbAmount
                    cbAll.prop 'checked', true
                else if cbAmount - checkedAmount is 1
                    cbAll.prop 'checked', false


        checkAll: ( event ) ->
            if event.currentTarget.checked
                @$('input[type="checkbox"]').prop 'checked', true
            else
                @$('input[type="checkbox"]').prop 'checked', false


        close: ( event ) ->
            $( '#modal-wrap' ).off 'click', @stopPropagation
            modal.close()
            @remove()
            false

    Backbone.View.extend

        tagName: 'section'

        events:
            'click #keypair-filter'     : 'returnFalse'
            'click .manage-kp'          : 'manageKp'
            'OPTION_SHOW .selectbox'    : 'show'
            'OPTION_CHANGE .selectbox'  : 'setKey'

        setKey: ( event, name ) ->
            if name is '@default'
                @model.setKey ''
            else if name is '@no'
                @model.setKey '', true
            else
                @model.setKey name

        returnFalse: ( event ) ->
            false

        manageKp: ( event ) ->
            @renderModal()
            false

        initialize: ( options ) ->
            @model.on 'change:keys', @renderKeys, @
            @model.on 'sync:error', @syncErrorHandler, @

        show: () ->
            if not @model.haveGot()
                @model.getKeys()


        render: () ->
            @renderFrame()
            @

        syncErrorHandler: () ->
            @renderEmptyKey()


        renderKeys: () ->
            keys = @model.get('keys')
            data = keys: @model.get('keys')

            if @model.resModel.isNoKey()
                data.noKey = true
            if @model.resModel.isDefaultKey()
                data.defaultKey = true

            @$('#kp-list').html template.keys data
            @showManageBtn()
            @

        renderFrame: () ->
            data = @model.toJSON()
            if data.keyName is '$DefaultKeyPair'
                data.defaultKey = true
            else if data.keyName is 'No Key Pair'
                data.noKey = true

            @$el.html template.frame data

        renderModal: () ->
            new modalView(model: @model).render()

        showManageBtn: ->
            @$( '.manage-kp' ).show()






