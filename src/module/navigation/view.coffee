#############################
#  View(UI logic) for navigation
#############################

define [ 'event',  'backbone', 'jquery', 'handlebars' ], ( ide_event ) ->

    NavigationView = Backbone.View.extend {

        el       : $( '#navigation' )

        template : Handlebars.compile $( '#navigation-tmpl' ).html()

        events   :
            'click #nav-dashboard-region a' : 'dashboardRegionClick'
            'click .stack-list a'           : 'stackListItemsClick'
            'click .app-list a'             : 'appListItemsClick'
            'click .show-unused-region a'   : 'showEmptyRegionClick'
            'click .create-new-stack'       : 'createNewStackClick'

        initialize : ->
            #

        render     : ->
        	#render html
            console.log 'navigation render'
            $( this.el ).html this.template this.model.attributes

            #Collapsed Navigation Mouse Interaction
            this.hoverIntent()

            #push event
            ide_event.trigger ide_event.NAVIGATION_COMPLETE

        dashboardRegionClick : ( event ) ->
            if event.target.parentNode.className isnt 'show-unused-region'
                alert 'add dashboard region'
                #open dashboard region
                #ide_event.trigger ide_event.OPEN_DASHBOARD, 'dashboard'

        stackListItemsClick : ( event ) ->
            console.log 'stack tab click event'
            target   = event.target
            nav      = $ '#navigation'
            main     = $ '#main'
            tab_name = $( target ).text()

            ide_event.trigger ide_event.OPEN_STACK_TAB, tab_name, $( target ).attr( 'data-region-name' ), $( target ).attr( 'data-stack-id' )

            nav.addClass 'collapsed'
            nav.removeClass 'scroll-wrap'
            main.addClass 'wide'

            $( '#first-level-nav' ).removeClass 'accordion'
            $( '.nav-head').removeClass 'accordion-group'
            $( '.sub-menu-wrapper').removeClass 'accordion-body'

            if nav.hasClass( 'collapsed' )
                $( '.sub-menu-wrapper' ).each () ->
                    this.style.cssText = ''
                    null

        appListItemsClick : ( event ) ->
            console.log 'app tab click event'
            target   = event.target
            nav      = $ '#navigation'
            main     = $ '#main'
            tab_name = $( target ).text()

            ide_event.trigger ide_event.OPEN_APP_TAB, $.trim( tab_name ), $( target ).attr 'data-region-name'

            nav.addClass 'collapsed'
            nav.removeClass 'scroll-wrap'
            main.addClass 'wide'

            $( '#first-level-nav' ).removeClass 'accordion'
            $( '.nav-head').removeClass 'accordion-group'
            $( '.sub-menu-wrapper').removeClass 'accordion-body'

            if nav.hasClass( 'collapsed' )
                $( '.sub-menu-wrapper' ).each () ->
                    this.style.cssText = ''
                    null

        showEmptyRegionClick : ( event ) ->
            $( event.target ).parent().prev().find('.hide').show()
            $( event.target ).hide()

        createNewStackClick : ( event ) ->
            console.log 'createNewStackClick'
            ide_event.trigger ide_event.ADD_STACK_TAB

        hoverIntent          : ->
            $('.nav-head').hoverIntent {

                timeout  : 100

                over     : () ->
                    if $('#navigation').hasClass 'collapsed'
                        $( this ).delay( 300 ).addClass 'collapsed-show'

                out      : () ->
                    $( this ).removeClass 'collapsed-show'
            }
    }

    return NavigationView