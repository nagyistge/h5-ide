
define [ "ComplexResModel", "constant", "Design", "CloudResources" ], ( ComplexResModel, constant, Design, CloudResources )->

  Model = ComplexResModel.extend {

    type : constant.RESTYPE.OSSERVER
    newNameTmpl : "Server-"

    #    Server sample json
    #    =====================
    #    "server-id": {
    #      "type": "OS::Nova::Server",
    #      "uid": "server-id",
    #      "resource": {
    #        "name": "helloworldserver",
    #        "flavor": "10",
    #        "image": "03f66db6-a74f-40b5-9933-4a19352083da",
    #        "meta": "",
    #        "userdata": "",
    #        "availabilityZone": "",
    #        "blockDeviceMapping" :[],
    #        "key_name": "testkp",
    #        "NICS":[
    #          {
    #            "port-id": "@{port-id.resource.id}"
    #          }
    #        ],
    #        "adminPass" : "12345678",
    #        "id" : ""
    #      }
    #    }

    defaults:
      userData: "User Data Sample"
      meta: ""
      NICS: []
      adminPass: "xxxxxx"
      keypair: "Default-KP"
      blockDeviceMapping: []
      flavor_id: "10"
      availabilityZone: ""
      image: ""
      credential: "keypair"

    initialize : ( attr, option )->
      option = option || {}
      console.assert( attr.imageId, "Invalid attributes when creating OsModelServer", attr )
      @setImage( attr.imageId )
      @setCredential(attr)
      null

    embedPort : ()-> @connectionTargets("OsPortUsage")[0]

    setCredential: (attr)->
      if attr.keypair
        @.set('credential', "keypair")
      else if attr.adminPass
        @.set('credential', 'adminPass')

    setImage : ( imageId )->
      @set "image", imageId
      # Update cached image
      image    = @getImage()
      cached = @get("cachedAmi")
      if image and cached
        cached.os_distro      = image.os_distro
        cached.architecture   = image.architecture
      null

    getImage : ()->
      image = CloudResources( constant.RESTYPE.OSIMAGE, @design().region() ).get( @get("image") )
      if image
        image.toJSON()
      else
        null

    serialize : ()->
      component =
        name : @get("name")
        type : @type
        uid  : @id
        resource :
          id        : @get("appId")
          name      : @get("name")
          flavor    : @get('flavor_id')
          image     : @get('image')
          meta      : @get('meta')
          NICS      : @get('NICS')
          userdata  : @get('userData')
          adminPass : @get('adminPass')
          key_name  : @get("keypair")
          availabilityZone   : @get('availabilityZone')
          blockDeviceMapping : @get('blockDeviceMapping')

      if @get('credential') is "keypair"
        delete component.resource.adminPass
      else
        delete component.resource.key_name

      { component : component }

  }, {

    handleTypes  : constant.RESTYPE.OSSERVER

    deserialize : ( data, layout_data, resolve )->
      server = new Model({
        id    : data.uid
        name  : data.resource.name
        appId : data.resource.id
        imageId : data.resource.image
        adminPass: data.resource.adminPass
        keypair : data.resource.key_name
        x : layout_data.coordinate[0]
        y : layout_data.coordinate[1]
      })

      PortUsage = Design.modelClassForType( "OsPortUsage" )
      for port in data.resource.NICS || []
        port = resolve( MC.extractID( port["port-id"] ) )
        new PortUsage( server, port )

      return
  }

  Model
