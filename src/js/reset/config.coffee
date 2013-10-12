
require.config {

	baseUrl               : './'

	waitSeconds           : 30

	deps                  : [ 'main' ]

	locale                : 'zh-cn'

	urlArgs               : 'v=' + version

	paths                 :

		#main
		'main'            : 'js/reset/main'
		'router'          : 'js/reset/router'
		'reset'           : 'module/reset/main'
		'reset_model'     : 'module/reset/model'
		'reset_view'      : 'module/reset/view'

		#vender
		'jquery'          : [ '//code.jquery.com/jquery-2.0.3.min' , 'vender/jquery/jquery' ]
		'underscore'      : 'vender/underscore/underscore'
		'backbone'        : 'vender/backbone/backbone'
		'handlebars'      : 'vender/handlebars/handlebars'

		'domReady'        : 'vender/requirejs/domReady'
		'i18n'            : 'vender/requirejs/i18n'
		'text'            : 'vender/requirejs/text'

		#
		'base_main'       : 'module/base/base_main'

		#
		'event'           : 'event/ide_event'

		#
		'UI.notification'    : 'ui/common/UI.notification'

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
		'forge_handle'    : 'lib/forge/main'

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

}

#requirejs.onError = ( err ) ->
#    console.log 'error type: ' + err.requireType + ', modules: ' + err.requireModules
