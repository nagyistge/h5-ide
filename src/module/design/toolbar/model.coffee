#############################
#  View Mode for design/toolbar module
#############################

define [ 'MC', 'backbone', 'jquery', 'underscore', 'event', 'stack_model', 'app_model', 'constant' ], (MC, Backbone, $, _, ide_event, stack_model, app_model, constant) ->

    app_state_list = [ 'request', 'inprocess', 'done', 'failed' ]

    #item state map
    # {app_id:{'name':name, 'state':state, 'is_running':true|false, 'is_pending':true|false, 'is_use_ami':true|false},
    #  stack_id:{'name':name, 'is_run':true|false, 'is_duplicate':true|false, 'is_delete':true|false}}
    item_state_map = {}
    is_tab = true

    #websocket
    ws = MC.data.websocket

    #private
    ToolbarModel = Backbone.Model.extend {

        defaults :
            'item_name'     : null
            'item_type'     : null

            'item_flags'    : null

        setFlag : (id, flag, value) ->
            me = this

            if flag is 'NEW_STACK'
                item_state_map[id] = {'name':MC.canvas_data.name, 'is_run':false, 'is_duplicate':false, 'is_delete':false}
                is_tab = true

            else if flag is 'OPEN_STACK'
                id = id.resolved_data[0].id
                item_state_map[id] = {'name':MC.canvas_data.name, 'is_run':true, 'is_duplicate':true, 'is_delete':true}
                is_tab = true

            else if flag is 'SAVE_STACK'
                item_state_map[id] = {'name':MC.canvas_data.name, 'is_run':true, 'is_duplicate':true, 'is_delete':true}

                if value
                    delete item_state_map[value]

            else if flag is 'DELETE_STACK' and value
                delete item_state_map[id]
                return

            else if flag is 'OPEN_APP'
                is_running = false
                is_pending = false

                if MC.canvas_data.state == 'Stopped'
                    is_running = false
                else if MC.canvas_data.state == 'Running'
                    is_running = true
                else
                    is_running = false
                    is_pending = true

                id = id.resolved_data[0].id
                item_state_map[id] = { 'name':MC.canvas_data.name, 'state':MC.canvas_data.state, 'is_running':is_running, 'is_pending':is_pending, 'is_use_ami':me.isInstanceStore() }

                is_tab = true

            else if flag is 'START_APP'
                if value is 'done'
                    item_state_map[id].state = 'Running'
                    item_state_map[id].is_running = true
                    item_state_map[id].is_pending = false
                else if value is 'failed'
                    item_state_map[id].state = 'Stopped'
                    item_state_map[id].is_running = false
                    item_state_map[id].is_pending = false
                else
                    item_state_map[id].is_pending = true

            else if flag is 'STOP_APP'
                if value is 'done'
                    item_state_map[id].state = 'Stopped'
                    item_state_map[id].is_running = false
                    item_state_map[id].is_pending = false
                else if value is 'failed'
                    item_state_map[id].state = 'Running'
                    item_state_map[id].is_running = true
                    item_state_map[id].is_pending = false
                else
                    item_state_map[id].is_pending = true

            else if flag is 'TERMINATE_APP'
                if value is 'done'
                    delete app_state_map[id]
                    return
                else if value is 'failed'
                    item_state_map[id].state = 'Stopped'
                    item_state_map[id].is_running = false
                    item_state_map[id].is_pending = false
                else
                    item_state_map[id].is_pending = true

            if id == MC.canvas_data.id and is_tab
                me.set 'item_flags', item_state_map[id]

                if id.indexOf('app-') == 0
                    me.trigger 'UPDATE_TOOLBAR', 'app'
                else
                    me.trigger 'UPDATE_TOOLBAR', 'stack'

        setTabFlag : (flag) ->
            is_tab = flag

            if flag
                id = MC.canvas_data.id
                me.set 'item_flags', item_state_map[id]

                if id.indexOf('app-') == 0
                    me.trigger 'UPDATE_TOOLBAR', 'app'
                else
                    me.trigger 'UPDATE_TOOLBAR', 'stack'

            null

        #save stack
        saveStack : (region, id, data) ->
            me = this

            if id.indexOf('stack-', 0) == 0   #save
                stack_model.save { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, data

                stack_model.once 'STACK_SAVE_RETURN', (result) ->
                    console.log 'STACK_SAVE_RETURN'
                    console.log result

                    if !result.is_error
                        console.log 'save stack successfully'

                        #update initial data
                        MC.canvas_property.original_json = JSON.stringify( MC.canvas_data )

                        me.trigger 'TOOLBAR_STACK_SAVE_SUCCESS'

                        ide_event.trigger ide_event.UPDATE_STACK_LIST

                        #call save png
                        me.savePNG true

                        #set toolbar flag
                        me.setFlag id, 'SAVE_STACK'
                    else
                        me.trigger 'TOOLBAR_STACK_SAVE_FAILED'

            else    #new
                stack_model.create { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, data

                stack_model.once 'STACK_CREATE_RETURN', (result) ->
                    console.log 'STACK_CREATE_RETURN'
                    console.log result

                    if !result.is_error
                        console.log 'create stack successfully'

                        new_id = result.resolved_data
                        MC.canvas_data.id = new_id

                        #update initial data
                        MC.canvas_property.original_json = JSON.stringify( MC.canvas_data )

                        me.trigger 'TOOLBAR_STACK_SAVE_SUCCESS'

                        ide_event.trigger ide_event.UPDATE_STACK_LIST

                        ide_event.trigger ide_event.UPDATE_TABBAR, MC.canvas_data.id, MC.canvas_data.name + ' - stack'

                        MC.data.stack_list[MC.canvas_data.region].push MC.canvas_data.name

                        #call save png
                        me.savePNG true

                        #set toolbar flag
                        me.setFlag new_id, 'SAVE_STACK', id

                    else
                        me.trigger 'TOOLBAR_STACK_SAVE_FAILED'

        #duplicate
        duplicateStack : (region, id, new_name, name) ->
            me = this

            if me.isChanged()
                me.saveStack()

            stack_model.save_as { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, id, new_name, name
            stack_model.once 'STACK_SAVE__AS_RETURN', (result) ->
                console.log 'STACK_SAVE__AS_RETURN'
                console.log result

                if !result.is_error
                    console.log 'save as stack successfully'

                    #update stack name list
                    if new_name not in MC.data.stack_list[MC.canvas_data.region]
                        MC.data.stack_list[MC.canvas_data.region].push new_name

                    #trigger event
                    me.trigger 'TOOLBAR_STACK_DUPLICATE_SUCCESS'
                    ide_event.trigger ide_event.UPDATE_STACK_LIST
                else
                    me.trigger 'TOOLBAR_STACK_DUPLICATE_FAILED'

        #delete
        deleteStack : (region, id, name) ->
            me = this

            stack_model.remove { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, id, name
            stack_model.once 'STACK_REMOVE_RETURN', (result) ->
                console.log 'STACK_REMOVE_RETURN'
                console.log result

                if !result.is_error
                    console.log 'send delete stack successful message'

                    #update stack name list
                    if MC.canvas_data.name in MC.data.stack_list[MC.canvas_data.region]
                        index = MC.data.stack_list[MC.canvas_data.region].indexOf(MC.canvas_data.name)
                        MC.data.stack_list[MC.canvas_data.region].splice(index, 1)

                    #trigger event
                    me.trigger 'TOOLBAR_STACK_DELETE_SUCCESS'
                    ide_event.trigger ide_event.STACK_DELETE, MC.canvas_data.name, MC.canvas_data.id

                    me.setFlag id, 'DELETE_STACK'

                else
                    me.trigger 'TOOLBAR_STACK_DELETE_FAILED'

        #run
        runStack : ( region, id, app_name ) ->
            me = this

            if me.isChanged
                me.saveStack()

            #src, username, session_id, region_name, stack_id, app_name, app_desc=null, app_component=null, app_property=null, app_layout=null, stack_name=null
            stack_model.run { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, id, app_name
            stack_model.once 'STACK_RUN_RETURN', (result) ->
                console.log 'STACK_RUN_RETURN'
                console.log result

                me.handleRequest result, 'RUN_STACK', MC.canvas_data.region, app_name

        #zoomin
        zoomIn : () ->
            me = this

            MC.canvas.zoomIn()

            zoomin_flag = true
            if MC.canvas_property.SCALE_RATIO <= 1
                zoomin_flag = false

            me.setFlag('ZOOM_IN', zoomin_flag)
            me.setFlag('ZOOM_OUT', true)

            null

        #zoomout
        zoomOut : () ->
            me = this

            MC.canvas.zoomOut()

            zoomout_flag = true
            if MC.canvas_property.SCALE_RATIO >= 1.6
                zoomout_flag = false

            me.setFlag('ZOOM_OUT', zoomout_flag)
            me.setFlag('ZOOM_IN', true)

            null

        savePNG : ( is_thumbnail ) ->
            console.log 'savePNG'
            me = this
            #
            $.ajax {
                url  : MC.SAVEPNG_URL,
                type : 'post',
                data : {
                    'usercode'   : $.cookie( 'usercode'   ),
                    'session_id' : $.cookie( 'session_id' ),
                    'thumbnail'  : is_thumbnail,
                    'json_data'  : MC.canvas.layout.save(),
                    'stack_id'   : MC.canvas_data.id
                },
                success : ( res ) ->
                    console.log 'phantom callback'
                    console.log res
                    console.log res.status
                    if res.status is 'success'
                        if res.thumbnail is 'true'
                            console.log 's3 url = ' + res.result
                        else
                            me.trigger 'SAVE_PNG_COMPLETE', res.result
                    else
                        #
            }

        isChanged : () ->
            #check if there are changes
            ori_data = MC.canvas_property.original_json
            new_data = JSON.stringify( MC.canvas_data )

            if ori_data != new_data
                return true
            else
                return false

        startApp : (region, id, name) ->
            me = this

            app_model.start { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, id, name
            app_model.once 'APP_START_RETURN', (result) ->
                console.log 'APP_START_RETURN'
                console.log result

                me.handleRequest result, 'START_APP', region, id, name

        stopApp : (region, id, name) ->
            me = this

            app_model.stop { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, id, name
            app_model.once 'APP_STOP_RETURN', (result) ->
                console.log 'APP_STOP_RETURN'
                console.log result

                me.handleRequest result, 'STOP_APP', region, id, name

        terminateApp : (region, id, name) ->
            me = this

            #terminate : ( src, username, session_id, region_name, app_id, app_name=null )
            app_model.terminate { sender : this }, $.cookie( 'usercode' ), $.cookie( 'session_id' ), region, id, name
            app_model.once 'APP_TERMINATE_RETURN', (result) ->
                console.log 'APP_TERMINATE_RETURN'
                console.log result

                me.handleRequest result, 'TERMINATE_APP', region, id, name

        handleRequest : (result, flag, region, id, name) ->
            me = this

            if flag isnt 'RUN_STACK'
                me.setFlag id, flag, 'pending'

            if !result.is_error
                if flag == 'RUN_STACK'
                    console.log 'run stack request successfully'
                    me.trigger 'TOOLBAR_STACK_RUN_REQUEST_SUCCESS'
                else if flag == 'START_APP'
                    console.log 'start app request successfully'
                    me.trigger 'TOOLBAR_APP_START_REQUEST_SUCCESS'
                else if flag == 'STOP_APP'
                    console.log 'stop app request successfully'
                    me.trigger 'TOOLBAR_APP_STOP_REQUEST_SUCCESS'
                else if flag == 'TERMINATE_APP'
                    console.log 'terminate app request successfully'
                    me.trigger 'TOOLBAR_APP_TERMINATE_SUCCESS'

                if ws
                    req_id = result.resolved_data.id
                    console.log 'request id:' + req_id
                    query = ws.collection.request.find({id:req_id})
                    handle = query.observeChanges {
                        changed : (id, req) ->

                            console.log 'request ' + req.data + "," + req.state
                            handle.stop()

                            is_success = false

                            if req.state == "Done"
                                if flag == 'RUN_STACK'
                                    me.trigger 'TOOLBAR_STACK_RUN_SUCCESS'
                                else if flag == 'START_APP'
                                    me.trigger 'TOOLBAR_APP_START_SUCCESS'
                                    MC.canvas_data.state = 'Running'
                                else if flag == 'STOP_APP'
                                    me.trigger 'TOOLBAR_APP_STOP_SUCCESS'
                                    MC.canvas_data.state = 'Stopped'
                                else if flag == 'TERMINATE_APP'
                                    me.trigger 'TOOLBAR_APP_TERMINATE_SUCCESS'

                                    # remove the app name from app_list
                                    if app_name in MC.data.app_list[region]
                                        MC.data.app_list[region].splice MC.data.app_list[region].indexOf(app_name), 1

                                is_success = true
                                #push event
                                ide_event.trigger ide_event.UPDATE_APP_LIST, null

                            else if req.state == "Failed"
                                if flag == 'RUN_STACK'
                                    me.trigger 'TOOLBAR_STACK_RUN_FAILED'

                                    if app_name in MC.data.app_list[MC.canvas_data.region]
                                        MC.data.app_list[region].splice MC.data.app_list[region].indexOf(app_name), 1

                                else if flag == 'START_APP'
                                    me.trigger 'TOOLBAR_APP_START_FAILED'
                                else if flag == 'STOP_APP'
                                    me.trigger 'TOOLBAR_APP_STOP_FAILED'
                                else if flag == 'TERMINATE_APP'
                                    me.trigger 'TOOLBAR_APP_TERMINATE_FAILED'

                            if flag is 'TERMINATE_APP' and is_success
                                ide_event.trigger ide_event.APP_TERMINATE, MC.canvas_data.name, MC.canvas_data.id
                            else if flag isnt 'RUN_STACK'
                                me.setFlag id, flag, if is_success then 'done' else 'failed'

                    }

                    null

            else
                if flag == 'RUN_STACK'
                    me.trigger 'TOOLBAR_STACK_RUN_REQUEST_FAILED'

                    if app_name in MC.data.app_list[MC.canvas_data.region]
                        MC.data.app_list[region].splice MC.data.app_list[region].indexOf(app_name), 1

                else if flag == 'START_APP'
                    me.trigger 'TOOLBAR_APP_START_REQUEST_FAILED'
                    MC.canvas_data.state = 'Stopped'
                else if flag == 'STOP_APP'
                    me.trigger 'TOOLBAR_APP_STOP_REQUEST_FAILED'
                    MC.canvas_data.state = 'Running'
                else if flag == 'TERMINATE_APP'
                    me.trigger 'TOOLBAR_APP_TERMINATE_REQUEST_FAILED'
                    MC.canvas_data.state = 'Stopped'

                if flag isnt 'RUN_STACK'
                    me.setFlag id, flag, 'failed'

        isInstanceStore : () ->

            is_instance_store = false

            if 'component' in MC.canvas_data.layout and 'node' in MC.canvas_data.layout.component
                for node in MC.canvas_data.layout.component.node
                    if node.rootDeviceType == 'instance-store'
                        is_instance_store = true
                        break

            is_instance_store

    }

    model = new ToolbarModel()

    return model
