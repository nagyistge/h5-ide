#*************************************************************************************
#* Filename     : eip_parser.coffee
#* Creator      : gen_service.sh
#* Create date  : 2013-05-25 14:06:10
#* Description  : parser return data of eip
# ************************************************************************************
# (c)Copyright 2012 Madeiracloud  All Rights Reserved
# ************************************************************************************

define [  'result_vo', 'constant', 'jquery' ], (result_vo, constant, $ ) ->

    resolvedObjectToArray = ( objs ) ->

        if objs.constructor == Array

            for obj in objs

                obj = resolvedObjectToArray obj

        if objs.constructor == Object

            if $.isEmptyObject objs

                objs = null

            for key, value of objs

                if key == 'item' and value.constructor == Object

                    tmp = []

                    tmp.push resolvedObjectToArray value

                    objs[key] = tmp

                else if value.constructor == Object or value.constructor == Array

                    objs[key] = resolvedObjectToArray value

        objs

    #///////////////// Parser for AllocateAddress return  /////////////////
    #private (parser AllocateAddress return)
    parserAllocateAddressReturn = ( result, return_code, param ) ->

        #1.resolve return_code
        aws_result = result_vo.processAWSReturnHandler result, return_code, param

        #2.return vo
        aws_result

    # end of parserAllocateAddressReturn


    #///////////////// Parser for ReleaseAddress return  /////////////////
    #private (parser ReleaseAddress return)
    parserReleaseAddressReturn = ( result, return_code, param ) ->

        #1.resolve return_code
        aws_result = result_vo.processAWSReturnHandler result, return_code, param

        #2.return vo
        aws_result

    # end of parserReleaseAddressReturn


    #///////////////// Parser for AssociateAddress return  /////////////////
    #private (parser AssociateAddress return)
    parserAssociateAddressReturn = ( result, return_code, param ) ->

        #1.resolve return_code
        aws_result = result_vo.processAWSReturnHandler result, return_code, param

        #2.return vo
        aws_result

    # end of parserAssociateAddressReturn


    #///////////////// Parser for DisassociateAddress return  /////////////////
    #private (parser DisassociateAddress return)
    parserDisassociateAddressReturn = ( result, return_code, param ) ->

        #1.resolve return_code
        aws_result = result_vo.processAWSReturnHandler result, return_code, param

        #2.return vo
        aws_result

    # end of parserDisassociateAddressReturn


    #///////////////// Parser for DescribeAddresses return (need resolve) /////////////////
    #private (resolve result to vo )
    resolveDescribeAddressesResult = ( result ) ->
        #resolve result
        #return vo
        result_set = ($.xml2json ($.parseXML result[1])).DescribeAddressesResponse.addressesSet

        result = resolvedObjectToArray result_set

        if result?.item?

            return result.item

        else

            return null

    #private (parser DescribeAddresses return)
    parserDescribeAddressesReturn = ( result, return_code, param ) ->

        #1.resolve return_code
        aws_result = result_vo.processAWSReturnHandler result, return_code, param

        #2.resolve return_data when return_code is E_OK
        if return_code == constant.RETURN_CODE.E_OK && !aws_result.is_error

            resolved_data = resolveDescribeAddressesResult result

            aws_result.resolved_data = resolved_data


        #3.return vo
        aws_result

    # end of parserDescribeAddressesReturn


    #############################################################
    #public
    {
        parserAllocateAddressReturn              : parserAllocateAddressReturn
        parserReleaseAddressReturn               : parserReleaseAddressReturn
        parserAssociateAddressReturn             : parserAssociateAddressReturn
        parserDisassociateAddressReturn          : parserDisassociateAddressReturn
        parserDescribeAddressesReturn            : parserDescribeAddressesReturn
        resolveDescribeAddressesResult           : resolveDescribeAddressesResult
    }

