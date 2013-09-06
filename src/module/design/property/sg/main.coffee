####################################
#  Controller for design/property/sg module
####################################

define [ 'jquery',
		 'text!./template.html',
		 'text!./app_template.html',
		 'event'
], ( $, template, app_template, ide_event ) ->

	#
	current_view  = null
	current_model = null

	#add handlebars script
	template = '<script type="text/x-handlebars-template" id="property-sg-tmpl">' + template + '</script>'
	$( 'head' ).append template

	app_template = '<script type="text/x-handlebars-template" id="property-sg-app-tmpl">' + app_template + '</script>'
	$( 'head' ).append app_template

	#private
	loadModule = ( sg_uid ) ->

		#
		# MC.data.current_sub_main = current_main

		# if !sg_uid then return

		is_app_view = false
		currentState = MC.canvas.getState()
		if currentState is 'app'
			is_app_view = true

		if !is_app_view
			require [ './module/design/property/sg/view', './module/design/property/sg/model' ], ( view, model ) ->

				# added by song
				model.clear({silent: true})

				if current_view then view.delegateEvents view.events
				#
				current_view  = view
				current_model = model

				#view
				view.model    = model

				if sg_uid
					view.model.getSG sg_uid
				else
					view.model.addSG()

				#render
				$dom = view.render()
				ide_event.trigger ide_event.PROPERTY_OPEN_SUBPANEL, {
					title : model.attributes.sg_detail.component.resource.GroupName
					dom   : $dom
					id    : "SG"
				}

				#temp hack
				view._events = []

				view.on 'SET_SG_NAME', ( value ) ->
					model.setSGName sg_uid, value

				view.on 'REMOVE_SG_RULE', ( rule )->

					model.removeSGRule sg_uid, rule

				view.on 'SET_SG_RULE', ( rule ) ->

					model.setSGRule sg_uid, rule

				view.on 'SET_SG_DESC', ( value ) ->
					model.setSGDescription sg_uid, value

		else

			require [ './module/design/property/sg/view', './module/design/property/sg/model' ], ( view, model ) ->

				# added by song
				model.clear({silent: true})

				view.model = model

				if sg_uid
					model.getAppSG sg_uid

				#render
				$dom = view.render(is_app_view)
				ide_event.trigger ide_event.PROPERTY_OPEN_SUBPANEL, {
					title : model.attributes.sg_app_detail.groupName
					dom   : $dom
					id    : "SG"
				}

	unLoadModule = () ->

	#public
	loadModule   : loadModule
	unLoadModule : unLoadModule
