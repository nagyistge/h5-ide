#############################
#  View Mode for header module
#############################

define [ 'event', 'backbone', 'jquery', 'underscore', 'constant' ], ( ide_event, Backbone, $, _, constant ) ->

    ProcessModel = Backbone.Model.extend {

        defaults:
            'flag_list'         : null  #flag_list = {'is_pending':true|false, 'is_inprocess':true|false, 'is_done':true|false, 'is_failed':true|false, 'steps':0, 'dones':0, 'rate':0}

        initialize  : ->
            me = this

            me.set 'flag_list', {'is_pending':true}

        getProcess  : (tab_name) ->
            me = this

            if MC.process[tab_name]

                # get the data
                flag_list = MC.process[tab_name].flag_list

                console.log 'tab name:' + tab_name
                console.log 'flag_list:' + flag_list

                last_flag = me.get 'flag_list'

                me.set 'flag_list', flag_list

                if 'is_done' of flag_list and flag_list.is_done     # completed

                    # complete the progress
                    $('#progress_bar').css('width', "100%" )
                    $('#progress_num').text last_flag.steps
                    $('#progress_total').text last_flag.steps

                    ide_event.trigger ide_event.SWITCH_WAITING_BAR

                    # hold on 1 second
                    setTimeout () ->

                        app_id = flag_list.app_id
                        region = MC.process[tab_name].region

                        # save png
                        app_name = MC.process[tab_name].name

                        # not current tab return
                        if MC.data.current_tab_id isnt 'process-' + region + '-' + app_name
                            return

                        # hold on two seconds
                        setTimeout () ->

                            # update tab
                            ide_event.trigger ide_event.UPDATE_DESIGN_TAB, app_id, app_name + ' - app'

                            # reload app
                            ide_event.trigger ide_event.OPEN_DESIGN_TAB, 'RELOAD_APP', app_name, region, app_id

                            #ide_event.trigger ide_event.PROCESS_RUN_SUCCESS, app_id, region
                            #ide_event.trigger ide_event.DELETE_TAB_DATA, tab_name
                            #ide_event.trigger ide_event.UPDATE_APP_LIST, null

                        , 800
                    , 1000

                else if 'is_inprocess' of flag_list and flag_list.is_inprocess # in progress

                    if flag_list.dones > 0 and 'steps' of flag_list and flag_list.steps > 0
                        $('#progress_bar').css('width', Math.round( flag_list.dones/flag_list.steps*100 ) + "%" )
                        $('#progress_num').text flag_list.dones

                    else
                        $('#progress_bar').css('width', "0" )
                        $('#progress_num').text '0'

                    $('#progress_total').text flag_list.steps

                else

                    me.set 'flag_list', flag_list

            null


    }

    model = new ProcessModel()
    return model
