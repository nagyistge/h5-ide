
version  = '130830.1912'
language = 'en-us'
current_jquery = if /msie (9|8|7|6)/ig.test(navigator.userAgent.toLowerCase()) then '//code.jquery.com/jquery-1.10.2.min' else '//code.jquery.com/jquery-2.0.3.min'

require.config {

	baseUrl               : './'

	waitSeconds           : 30

	deps                  : [ 'main' ]

	locale                : language

	urlArgs               : 'v=' + version

	paths                 :

		#main
		'main'            : 'js/reset/main'
		'router'          : 'js/reset/router'
		'reset'           : 'module/reset/main'
		'reset_model'     : 'module/reset/model'
		'reset_view'      : 'module/reset/view'

		#vender
		'jquery'          : [ current_jquery , 'vender/jquery/jquery' ]
		'underscore'      : 'vender/underscore/underscore'
		'backbone'        : 'vender/backbone/backbone'
		'handlebars'      : 'vender/handlebars/handlebars'

		'domReady'        : 'vender/requirejs/domReady'
		'i18n'            : 'vender/requirejs/i18n'
		'text'            : 'vender/requirejs/text'

		#
		'base_main'       : 'module/base/base_main'

		#
		'event'           : 'lib/ide_event'

		#
		'UI.notification'    : 'ui/UI.notification'

		#core lib
		'MC'              : 'lib/MC.core'

		#common lib
		'constant'        : 'lib/constant'

		#base_model
		'base_model'      : 'model/base_model'
		'account_model'   : 'model/account_model'
		'account_service' : 'service/account/account_service'

		#result_vo
		'result_vo'       : 'service/result_vo'

		#forge handle
		'common_handle'    : 'lib/common/main'

	shim                  :

		'jquery'          :
			exports       : '$'

		'underscore'      :
			exports       : '_'

		'backbone'        :
			deps          : [ 'underscore', 'jquery' ]
			exports       : 'Backbone'

		'handlebars'      :
			exports       : 'Handlebars'

		'MC'              :
			deps          : [ 'jquery','constant' ]
			exports       : 'MC'

		'reset'           :
			deps          : [ 'reset_view', 'reset_model', 'MC' ]

		'main'            :
			deps          : [ 'jquery' ]

}

#requirejs.onError = ( err ) ->
#    console.log 'error type: ' + err.requireType + ', modules: ' + err.requireModules
