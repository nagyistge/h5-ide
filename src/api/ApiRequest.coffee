
define ["ApiRequestDefs", "api/ApiRequestErrors", "api/ApiRequestHandlers", "api/ApiBundle", "MC" ], ( ApiDefination, ApiErrors, ApiHandlers )->
  ###
  # === ApiRequest ===
  #
  # Paramters :
  #   apiName       : (String) The name of the api, see ApiRequestDefs
  #   apiParameters : An object to be send with the api request.
  #         If an api has its parameters map, the `apiParameters` will be converted from OBJECT to ARRAY
  #         If an api has no param map, the apiParameters is considered as the first and only one paramter
  #         to be send with the api.
  ###
  OneParaArray = [""]
  EmptyArray   = []
  EmptyObject  = {}

  RequestData =
    jsonrpc : '2.0'
    id      : "1"
    method  : ''
    params  : {}

  # Helpers
  logAndThrow = ( obj )->
    ### env:dev ###
    console.error obj
    ### env:dev:end ###
    throw obj

  tryParseAws = ( xml, findError )->
    try
      xml  = $.parseXML xml
      json = $.xml2json xml
    catch e
      if findError
        return {
          error  : ApiErrors.InvalidAwsReturn
          result : awsResult
        }
      else
        return null

    if not findError then return json

    xml = $(xml).find("Error")
    {
      error  : xml.find("Code").text()    || ""
      result : xml.find("Message").text() || ""
    }

  # Request Handlers
  AjaxSuccessHandler = (res)->
    if not res or not res.result or res.result.length != 2
      logAndThrow McError( ApiErrors.InvalidRpcReturn , "Invalid JsonRpc Return Data")

    # Some of the error involved with AWS request are considered correct return.
    if res.result[0] isnt 0 and !(ApiErrors.AwsErrorAws <= res.result[0] <= ApiErrors.AwsErrorExternal)
      # We can do aditional global handling for some specific error here.
      # For example, Invalid Session.
      globalHandler = ApiHandlers[ res.result[0] ]
      if globalHandler then return globalHandler( res )

      logAndThrow McError( res.result[0], "Service Error", res.result[1] )


    # Try parse AWS Return result if we have correct return.
    awsresult = res.result[1]
    if awsresult and _.isArray(awsresult) and (typeof awsresult[1] is "string") and awsresult[1][0] is "<"

      if awsresult[0] is 200
        res = tryParseAws( awsresult[1] )
        if not res
          logAndThrow McError( ApiErrors.InvalidAwsReturn, "Aws returns invalid xml data.", res.result )
        else
          return res
      else
        error = McError( res.result[0], "Service Error", res.result[1] )
        error.awsError = awsresult[0]

        awsresult = tryParseAws( awsresult[1], true )
        error.awsErrorCode = "" + awsresult.error
        error.awsResult    = awsresult.result

        globalHandler = ApiHandlers.AwsHandlers[ error.awsError ]
        if globalHandler then return globalHandler( error )

        logAndThrow error

    res.result[1]

  AjaxErrorHandler = (jqXHR, textStatus, error)->
    if !error and jqXHR.status != 200
      logAndThrow McError(-jqXHR.status, "Network Error")

    logAndThrow McError( ApiErrors.XhrFailure, textStatus, error)
    return

  Abort = ()-> this.ajax.abort(); return



  ###
   ApiRequest Defination
  ###
  ApiRequest = ( apiName, apiParameters )->
    ApiDef = ApiDefination.Defs[ apiName ]
    apiParameters = apiParameters || EmptyObject

    if not ApiDef
      console.error "Cannot find defination of the api:", apiName
      return

    if ApiDef.type isnt "aws" and ApiDef.type isnt "forge" and ApiDef.type isnt "marathon"
      console.error "Cannot send non-aws request(#{apiName}) by using `ApiRequest`"
      return

    RequestData.method = ApiDef.method || ""
    if ApiDef.params
      RequestData.params = p = []
      for i in ApiDef.params
        if apiParameters.hasOwnProperty( i )
          p.push apiParameters[i]
        else
          p.push ApiDefination.AutoFill(i)

    else if apiParameters
      OneParaArray[0] = apiParameters
      RequestData.params = OneParaArray
    else
      RequestData.params = EmptyArray

    ajax = $.ajax {
      url      : MC.API_HOST + ApiDef.url
      dataType : "json"
      type     : "POST"
      jsonp    : false
      data     : JSON.stringify RequestData
    }

    # Generic hanlder for the ajax request.
    request = Q(ajax).then(AjaxSuccessHandler, AjaxErrorHandler)

    # Pass result to parser if defined.
    if ApiDefination.Parsers[ apiName ]
      request = request.then( ApiDefination.Parsers[apiName] )

    request.abort = Abort
    request.ajax  = ajax
    request


  ApiRequest.Errors = ApiErrors

  ApiRequest
