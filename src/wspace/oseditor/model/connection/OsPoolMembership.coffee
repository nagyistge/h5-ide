
define [ "ConnectionModel", "constant" ], ( ConnectionModel, constant )->

  ConnectionModel.extend {
    type : "OsPoolMembership"

    defaults: ()->
      port    : 80
      weight  : 1
      appId   : ""

    getPort: ->
      pool = @getOtherTarget constant.RESTYPE.OSPOOL
      pool = pool.embedPort() if pool.type is constant.RESTYPE.OSSERVER

      pool

    portDefs : [
      {
        port1 :
          name : "pool"
          type : constant.RESTYPE.OSPOOL
        port2 :
          name : "pool"
          type : constant.RESTYPE.OSPORT
      }
      {
        port1 :
          name : "pool"
          type : constant.RESTYPE.OSPOOL
        port2 :
          name : "pool"
          type : constant.RESTYPE.OSSERVER
      }
    ]

    constructor : ( p1Comp, p2Comp, attr, option )->
      if p1Comp.type is constant.RESTYPE.OSPORT
        port = p1Comp
        pool = p2Comp
      else if p2Comp.type is constant.RESTYPE.OSPORT
        port = p2Comp
        pool = p1Comp

      if port and port.isEmbedded()
        p1Comp = port.owner()
        p2Comp = pool

      ConnectionModel.call this, p1Comp, p2Comp, attr, option

  }
