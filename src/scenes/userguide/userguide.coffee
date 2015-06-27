define [
    'constant'
    'i18n!/nls/lang.js'
    './userguideTpl'
], (constant, lang, template) ->

    return Backbone.View.extend

        className: 'user-guide'

        tagName: 'section'

        initialize: () ->

            @render()

        events:

            'click .guide-card': 'playVideo'
            'click .guide-video': 'closeVideo'
            'click .guide-close': 'closeGuide'
            'click .guide-view': 'switchView'
            'mousewheel .guide-list': 'scrollHorizontally'

        render: () ->

            that = @
            @$el.html(template())
            $('body').append(@$el)
            video = @$el.find('.guide-video video')[0]
            video.addEventListener 'ended', () ->
                that.closeVideo()
            video.addEventListener 'loadeddata', () ->
                that.$el.find('.box-loading').hide()
            @$el.fadeIn()

        playVideo: (event) ->

            @$el.find('.guide-video').fadeIn()
            video = @$el.find('.guide-video video')[0]
            video.width = $(document).width()
            @$el.find('.box-loading').show()
            video.load()
            video.play()
            @$el.find('.guide-card').removeClass('active')
            $(event.currentTarget).addClass('active')

        closeVideo: () ->

            @$el.find('.guide-video').fadeOut()
            video = @$el.find('.guide-video video')[0]
            video.pause()
            video.currentTime = 0

        closeGuide: () ->

            that = @
            @$el.fadeOut 'normal', () ->
                that.remove()

        switchView: (event) ->

            $target = $(event.currentTarget)
            if $target.hasClass('icon-menu')
                $target.removeClass('icon-menu').addClass('icon-resources')
                @$el.find('.guide-cards').addClass('cube')
            else
                $target.removeClass('icon-resources').addClass('icon-menu')
                @$el.find('.guide-cards').removeClass('cube')

        scrollHorizontally: (event) ->

            delta = Math.max(-1, Math.min(1, (event.originalEvent.wheelDelta || - event.originalEvent.detail)))
            event.currentTarget.scrollLeft -= (delta * 150)
            # event.preventDefault()
