#############################
#  View(UI logic) for design/property/volume
#############################

define [ '../base/view',
         './template/stack',
         'event',
         'i18n!/nls/lang.js'
], ( PropertyView, template, ide_event, lang ) ->

    VolumeView = PropertyView.extend {

        events   :
            'click #volume-type-radios input' : 'volumeTypeChecked'
            'change #volume-device' : 'deviceNameChanged'
            'keyup #volume-size-ranged' : 'sizeChanged'
            'keyup  #volume-size-ranged' : 'processIops'
            #'keyup #volume-size-ranged' : 'sizeChanged'
            'keyup #iops-ranged' : 'sizeChanged'
            #'keyup #iops-ranged' : 'iopsChanged'
            'click #snapshot-info-group' : 'showSnapshotDetail'

        render     : () ->
            console.log 'property:volume render'
            #
            @$el.html( template( @model.attributes ) )
            # parsley bind
            $( '#volume-size-ranged' ).parsley 'custom', ( val ) ->
                val = + val
                if not val || val > 1024 || val < 1
                    return lang.ide.PARSLEY_VOLUME_SIZE_MUST_IN_1_1024

            $( '#iops-ranged' ).parsley 'custom', ( val ) ->
                val = + val
                volume_size = parseInt( $( '#volume-size-ranged' ).val(), 10 )
                if val > 4000 || val < 100
                    return lang.ide.PARSLEY_IOPS_MUST_BETWEEN_100_4000
                else if( val > 10 * volume_size)
                    return lang.ide.PARSLEY_IOPS_MUST_BE_LESS_THAN_10_TIMES_OF_VOLUME_SIZE
            #

            @model.attributes.volume_detail.name

        volumeTypeChecked : ( event ) ->
            @processIops()
            if($('#volume-type-radios input:checked').val() is 'radio-standard')
                $( '#iops-group' ).hide()
                @model.setVolumeTypeStandard()
            else
                $( '#iops-group' ).show()
                @model.setVolumeTypeIops $( '#iops-ranged' ).val()
            @sizeChanged()

        deviceNameChanged : ( event ) ->
            target       = $ event.currentTarget
            name         = target.val()
            devicePrefix = target.prev( 'label' ).text()
            type         = if devicePrefix is '/dev/' then 'linux' else 'windows'

            self = this

            target.parsley 'custom', ( val ) ->
                if not MC.validate.deviceName val, type, true
                    if type is 'linux'
                        return lang.ide.PARSLEY_DEVICENAME_LINUX
                    else
                        return lang.ide.PARSLEY_DEVICENAME_WINDOWS

                if self.model.isDuplicate val
                    sprintf lang.ide.PARSLEY_VOLUME_NAME_INUSE, val

            if target.parsley 'validate'
                @model.setDeviceName name
                @setTitle @model.attributes.volume_detail.name

        processIops: ( event ) ->
            size = parseInt $( '#volume-size-ranged' ).val(), 10
            opsCheck = $( '#radio-iops' ).is ':checked'
            if size >= 10
                @enableIops()
            else if not opsCheck
                @disableIops()

            null

        enableIops: ->
            $( '#volume-type-radios > div' )
                .last()
                .data( 'tooltip', '' )
                .find( 'input' )
                .removeAttr( 'disabled' )

        disableIops: ->
            $( '#volume-type-radios > div' )
                .last()
                .data( 'tooltip', 'Volume size must be at least 10 GB to use Provisioned IOPS volume type.' )
                .find( 'input' )
                .attr( 'disabled', '' )


        sizeChanged : ( event ) ->
            volumeSize = parseInt $( '#volume-size-ranged' ).val(), 10
            iopsValidate = true
            volumeValidate = $( '#volume-size-ranged' ).parsley 'validate'
            iopsEnabled = $( '#radio-iops' ).is ':checked'
            if iopsEnabled
                iopsValidate = $( '#iops-ranged' ).parsley 'validate'
            if volumeValidate and iopsValidate
                this.trigger 'VOLUME_SIZE_CHANGED', volumeSize
                if iopsEnabled
                    @model.setVolumeIops $( '#iops-ranged' ).val()
            null


        showSnapshotDetail : ( event ) ->
            @trigger "OPEN_SNAPSHOT", $("#snapshot-info-group").data("uid")
            null
    }

    new VolumeView()
