#*************************************************************************************
#* Filename     : parametergroup_model.coffee
#* Creator      : gen_model.sh
#* Create date  : 2013-08-26 12:19:53
#* Description  : model know service
#* Action       : 1.define vo
#*                2.invoke api by service
#*                3.dispatch event to controller
# ************************************************************************************
# (c)Copyright 2012 Madeiracloud  All Rights Reserved
# ************************************************************************************

define [ 'backbone', 'underscore', 'parametergroup_service', 'base_model' ], ( Backbone, _, parametergroup_service, base_model ) ->

    ParameterGroupModel = Backbone.Model.extend {

        initialize : ->
            _.extend this, base_model

        ###### api ######
        #DescribeDBParameterGroups api (define function)
        DescribeDBParameterGroups : ( src, username, session_id, region_name, pg_name=null, marker=null, max_records=null ) ->

            me = this

            src.model = me

            parametergroup_service.DescribeDBParameterGroups src, username, session_id, region_name, pg_name, marker, max_records, ( aws_result ) ->

                if !aws_result.is_error
                #DescribeDBParameterGroups succeed

                    #dispatch event (dispatch event whenever login succeed or failed)
                    if src.sender and src.sender.trigger then src.sender.trigger 'RDS_PG_DESC_DB_PARAM_GRPS_RETURN', aws_result

                else
                #DescribeDBParameterGroups failed

                    console.log 'parametergroup.DescribeDBParameterGroups failed, error is ' + aws_result.error_message
                    me.pub aws_result



        #DescribeDBParameters api (define function)
        DescribeDBParameters : ( src, username, session_id, region_name, pg_name, source=null, marker=null, max_records=null ) ->

            me = this

            src.model = me

            parametergroup_service.DescribeDBParameters src, username, session_id, region_name, pg_name, source, marker, max_records, ( aws_result ) ->

                if !aws_result.is_error
                #DescribeDBParameters succeed

                    #dispatch event (dispatch event whenever login succeed or failed)
                    if src.sender and src.sender.trigger then src.sender.trigger 'RDS_PG_DESC_DB_PARAMS_RETURN', aws_result

                else
                #DescribeDBParameters failed

                    console.log 'parametergroup.DescribeDBParameters failed, error is ' + aws_result.error_message
                    me.pub aws_result




    }

    #############################################################
    #private (instantiation)
    parametergroup_model = new ParameterGroupModel()

    #public (exposes methods)
    parametergroup_model

