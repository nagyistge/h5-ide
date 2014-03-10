
define [ "constant", "../ComplexResModel", "../ConnectionModel"  ], ( constant, ComplexResModel, ConnectionModel )->

  SslCertModel = ComplexResModel.extend {

    type : constant.AWS_RESOURCE_TYPE.AWS_IAM_ServerCertificate

    defaults :
      name   : ""
      body   : ""
      chain  : ""
      key    : ""
      arn    : ""
      certId : ""

    serialize : ()-> # Doesn't do anything. It's implemented in Elb's serialize()

  },{
    deserialize : ( data )->
      new SslCertModel({
        id     : data.uid
        name   : data.name
        body   : data.resource.CertificateBody
        chain  : data.resource.CertificateChain
        key    : data.resource.PrivateKey
        arn    : data.resource.ServerCertificateMetadata.Arn
        certId : data.resource.ServerCertificateMetadata.ServerCertificateId
      })
      null
    serialize : () ->
      return {
        uid : @id
        type : "AWS.IAM.ServerCertificate"
        name : @get("name")
        resource :
          PrivateKey : @get("key")
          CertificateBody : @get("body")
          CertificateChain : @get("chain")
          ServerCertificateMetadata :
            ServerCertificateName : @get("name")
            Arn : @get("arn") or ""
            ServerCertificateId : @get("certId") or ""
      }
    remove : () ->

      # remove forme all elb cert ref
      elbModelAry = Design.modelClassForType(constant.AWS_RESOURCE_TYPE.AWS_ELB).allObjects()
      _.each elbModelAry, (elbModel) ->
        elbCertModel = elbCertModel.get('sslCert')
        if elbCertModel is this
          elbModel.setSslCert(null)

      ComplexResModel.prototype.remove.call this

    updateValue : (certObj) ->
      for key, value of certObj
        this.set(key, value)
      null
  }

  SslCertModel
