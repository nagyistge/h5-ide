
define [ "../ResourceModel", "constant" ], ( ResourceModel, constant )->

  Model = ComplexResModel.extend {

    type : constant.AWS_RESOURCE_TYPE.AWS_AutoScaling_ScalingPolicy



  }, {

    handleTypes : constant.AWS_RESOURCE_TYPE.AWS_AutoScaling_ScalingPolicy

    deserialize : ( data, layout_data, resolve )->

      attr =
        id           : data.uid
        name         : data.name

      for key, value of data.resource
        attr[ key ] = value

      new Model( attr )

  }

  Model

