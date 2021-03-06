
###
----------------------------
  The collection for stack / app
----------------------------

  This collection will trigger an "update" event when the list ( containing all visible items ) is changed.

###

define [ "constant", "backbone" ], ( constant )->

  ProjectLog = Backbone.Model.extend {

    comparator  : ( m1, m2 )-> -(m1.attributes.time - m2.attributes.time)

    constructor : ( attr, opt )->
      cate = attr.action.split(".")

      Backbone.Model.call this, {
        id       : attr.id
        usercode : attr.username
        username : Base64.decode( attr.username || "" )

        type    : cate[1] || ""
        action  : cate[2] || ""
        success : attr.result is 0
        detail  : attr.detail

        target   : attr.target
        targetId : attr.target_id

        time     : attr.time
        duration : attr.duration
      }, opt

  }, {
    TYPE : {
      APP        : "App"
      APPSTATE   : "AppState"
      STACK      : "Stack"
      PROJECT    : "Project"
      MEMBER     : "Member"
      PAYMENT    : "Payment"
      CREDENTIAL : "Credential"
      TOKEN      : "Token"
    }
  }

  AuditType = {}
  AuditType[ ProjectLog.TYPE.PROJECT ] = true
  AuditType[ ProjectLog.TYPE.MEMBER ] = true
  AuditType[ ProjectLog.TYPE.PAYMENT ] = true
  AuditType[ ProjectLog.TYPE.CREDENTIAL ] = true
  AuditType[ ProjectLog.TYPE.TOKEN ] = true
  historyFilter = ( model )-> !AuditType[model.get("type")]
  auditFilter   = ( model )-> AuditType[model.get("type")]

  ProjectLog.Collection = Backbone.Collection.extend {
    model : ProjectLog

    # Returns history of the project
    history : ()-> @filter historyFilter
    # Returns audits of the project
    audit : ()-> @filter auditFilter
  }

  ProjectLog
