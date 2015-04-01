
###
----------------------------
  The Model for stack / app
----------------------------

  This model represent a stack or an app. It contains serveral methods to manipulate the stack / app

###

define ["OpsModel", "ApiRequest", "constant" ], ( OpsModel, ApiRequest, constant )->

  MesosDataModel = Backbone.Model.extend {
    getSlave: ( hostname ) -> _.findWhere @get( 'slaves' ), hostname: '10.0.0.222'
  }

  AwsOpsModel = OpsModel.extend {

    type : OpsModel.Type.Amazon

    getMsrId : ()->
      msrId = OpsModel.prototype.getMsrId.call this
      if msrId then return msrId
      if not @__jsonData then return undefined
      for uid, comp of @__jsonData.component
        if comp.type is constant.RESTYPE.VPC
          return comp.resource.VpcId
      undefined

    __mesosData: new MesosDataModel()

    setMesosData: ( data ) -> @__mesosData.set data

    getMesosData: -> @__mesosData

    __defaultJson : ()->
      jsonType = @getStackType()
      if jsonType is "aws"
        @___defaultJson()
      else
        scale = @__jsonScale || "small"
        @___mesosJson(scale)

    ___defaultJson : ()->
      json   = OpsModel.prototype.__defaultJson.call this
      vpcId  = MC.guid()
      vpcRef = "@{#{vpcId}.resource.VpcId}"

      layout =
        VPC :
          coordinate : [5,3]
          size       : [60,60]
        RTB :
          coordinate : [50,5]
          groupUId   : vpcId

      component =
        KP :
          type : "AWS.EC2.KeyPair"
          name : "DefaultKP"
          resource : {
            KeyName : "DefaultKP"
            KeyFingerprint : ""
          }
        SG :
          type : "AWS.EC2.SecurityGroup"
          name : "DefaultSG"
          resource :
            IpPermissions: [{
              IpProtocol : "tcp",
              IpRanges   : "0.0.0.0/0",
              FromPort   : "22",
              ToPort     : "22",
            }],
            IpPermissionsEgress : [{
              FromPort: "0",
              IpProtocol: "-1",
              IpRanges: "0.0.0.0/0",
              ToPort: "65535"
            }],
            Default          : true
            GroupId          : ""
            GroupName        : "DefaultSG"
            GroupDescription : 'default VPC security group'
            VpcId            : vpcRef
        ACL :
          type : "AWS.VPC.NetworkAcl"
          name : "DefaultACL"
          resource :
            AssociationSet : []
            Default        : true
            NetworkAclId   : ""
            VpcId          : vpcRef
            EntrySet : [
              {
                RuleAction : "allow"
                Protocol   : -1
                CidrBlock  : "0.0.0.0/0"
                Egress     : true
                IcmpTypeCode : { Type : "", Code : "" }
                PortRange    : { To   : "", From : "" }
                RuleNumber   : 100
              }
              {
                RuleAction : "allow"
                Protocol   : -1
                CidrBlock  : "0.0.0.0/0"
                Egress     : false
                IcmpTypeCode : { Type : "", Code : "" }
                PortRange    : { To   : "", From : "" }
                RuleNumber   : 100
              }
              {
                RuleAction : "deny"
                Protocol   : -1
                CidrBlock  : "0.0.0.0/0"
                Egress     : true
                IcmpTypeCode : { Type : "", Code : "" }
                PortRange    : { To   : "", From : "" }
                RuleNumber   : 32767
              }
              {
                RuleAction : "deny"
                Protocol   : -1
                CidrBlock  : "0.0.0.0/0"
                Egress     : false
                IcmpTypeCode : { Type : "", Code : "" }
                PortRange    : { To   : "", From : "" }
                RuleNumber   : 32767
              }
            ]
        VPC :
          type : "AWS.VPC.VPC"
          name : "vpc"
          resource :
            VpcId              : ""
            CidrBlock          : "10.0.0.0/16"
            DhcpOptionsId      : ""
            EnableDnsHostnames : false
            EnableDnsSupport   : true
            InstanceTenancy    : "default"
        RTB :
          type : "AWS.VPC.RouteTable"
          name : "RT-0"
          resource :
            VpcId : vpcRef
            RouteTableId: ""
            AssociationSet : [{
              Main:"true"
              SubnetId : ""
              RouteTableAssociationId : ""
            }]
            PropagatingVgwSet:[]
            RouteSet : [{
              InstanceId           : ""
              NetworkInterfaceId   : ""
              Origin               : 'CreateRouteTable'
              GatewayId            : 'local'
              DestinationCidrBlock : '10.0.0.0/16'
            }]

      # Generate new GUID for each component
      for id, comp of component
        if id is "VPC"
          comp.uid = vpcId
        else
          comp.uid = MC.guid()
        json.component[ comp.uid ] = comp
        if layout[ id ]
          l = layout[id]
          l.uid = comp.uid
          json.layout[ comp.uid ] = l

      json

    ___mesosJson: (scale)->

      simpleMesosMap = {
        small: {
          component: {
            "6FF14346-1CEF-4F05-837A-5BE2BD143103": {
              "name": "RT-0",
              "description": "",
              "type": "AWS.VPC.RouteTable",
              "uid": "6FF14346-1CEF-4F05-837A-5BE2BD143103",
              "resource": {
                "PropagatingVgwSet": [],
                "RouteTableId": "",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "AssociationSet": [
                  {
                    "Main": "true",
                    "RouteTableAssociationId": "",
                    "SubnetId": ""
                  }
                ],
                "RouteSet": [
                  {
                    "Origin": "CreateRouteTable",
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "InstanceId": "",
                    "NetworkInterfaceId": "",
                    "GatewayId": "local"
                  },
                  {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "Origin": "",
                    "InstanceId": "",
                    "NetworkInterfaceId": "",
                    "GatewayId": "@{D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1.resource.InternetGatewayId}"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "37C8D4D4-5FE0-41A9-8E83-47AA9FF87DF9": {
              "name": "DefaultACL",
              "type": "AWS.VPC.NetworkAcl",
              "uid": "37C8D4D4-5FE0-41A9-8E83-47AA9FF87DF9",
              "resource": {
                "AssociationSet": [
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{68A92730-A034-4C35-B4DA-A92FFC3B7E23.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5.resource.SubnetId}"
                  }
                ],
                "Default": true,
                "EntrySet": [
                  {
                    "Egress": true,
                    "Protocol": -1,
                    "RuleAction": "allow",
                    "RuleNumber": 100,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": false,
                    "Protocol": -1,
                    "RuleAction": "allow",
                    "RuleNumber": 100,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": true,
                    "Protocol": -1,
                    "RuleAction": "deny",
                    "RuleNumber": 32767,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": false,
                    "Protocol": -1,
                    "RuleAction": "deny",
                    "RuleNumber": 32767,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  }
                ],
                "NetworkAclId": "",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "614019C2-FE77-47FE-8688-E4BB1E362D54": {
              "type": "AWS.AutoScaling.LaunchConfiguration",
              "uid": "614019C2-FE77-47FE-8688-E4BB1E362D54",
              "name": "slave-lc-0",
              "description": "",
              "state": [
                {
                  "id": "slave-lc-0",
                  "module": "linux.mesos.slave",
                  "parameter": {
                    "masters_addresses": [
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      }
                    ],
                    "attributes": [
                      {
                        "key": "asg",
                        "value": "slave-asg"
                      }
                    ],
                    "slave_ip": "@{self.PrivateIpAddress}"
                  }
                }
              ],
              "resource": {
                "UserData": "",
                "LaunchConfigurationARN": "",
                "InstanceMonitoring": false,
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "SecurityGroups": [
                  "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                ],
                "LaunchConfigurationName": "slave-lc-0",
                "InstanceType": "t2.small",
                "AssociatePublicIpAddress": true
              }
            },
            "734547B2-25A5-41F3-A0E4-AA8A842A7173": {
              "name": "mesos",
              "description": "",
              "type": "AWS.VPC.VPC",
              "uid": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "resource": {
                "EnableDnsSupport": true,
                "InstanceTenancy": "default",
                "EnableDnsHostnames": false,
                "DhcpOptionsId": "",
                "VpcId": "",
                "CidrBlock": "10.0.0.0/16"
              }
            },
            "7CB6402A-2A9D-47D2-8C52-D82F40F779CF": {
              "uid": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "name": "us-east-1e",
              "type": "AWS.EC2.AvailabilityZone",
              "resource": {
                "ZoneName": "us-east-1e",
                "RegionName": "us-east-1"
              }
            },
            "B2185847-E9CE-49C6-9ECE-55CC53507558": {
              "name": "sched-b",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "resource": {
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.3.0/24"
              }
            },
            "A66EF8E5-CBCB-49B3-97B2-2B73BE541292": {
              "type": "AWS.EC2.Instance",
              "uid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "name": "master-2",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "serverGroupName": "master-2",
              "state": [
                {
                  "id": "state-master-2",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateSmall",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "3",
                    "masters_addresses": [
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      }
                    ],
                    "hostname": "master-2",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "t2.small",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "E767D0C1-84E0-47E8-9B7C-39102F60C33B": {
              "index": 0,
              "uid": "E767D0C1-84E0-47E8-9B7C-39102F60C33B",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-2-eni0",
              "serverGroupUid": "E767D0C1-84E0-47E8-9B7C-39102F60C33B",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.3.4",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "73391D87-F983-4796-B787-932600747F7D": {
              "name": "DefaultKP",
              "type": "AWS.EC2.KeyPair",
              "uid": "73391D87-F983-4796-B787-932600747F7D",
              "resource": {
                "KeyFingerprint": "",
                "KeyName": ""
              }
            },
            "408ECAC2-5785-4179-AF16-2A8D28711314": {
              "uid": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "name": "us-east-1d",
              "type": "AWS.EC2.AvailabilityZone",
              "resource": {
                "ZoneName": "us-east-1d",
                "RegionName": "us-east-1"
              }
            },
            "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1": {
              "name": "Internet-gateway",
              "type": "AWS.VPC.InternetGateway",
              "uid": "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1",
              "resource": {
                "InternetGatewayId": "",
                "AttachmentSet": [
                  {
                    "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}"
                  }
                ]
              }
            },
            "E98340BB-EF19-43A3-9DB7-C08968200568": {
              "name": "cpu-policy",
              "type": "AWS.AutoScaling.ScalingPolicy",
              "uid": "E98340BB-EF19-43A3-9DB7-C08968200568",
              "resource": {
                "ScalingAdjustment": "5",
                "PolicyName": "cpu-policy",
                "PolicyARN": "",
                "Cooldown": "300",
                "AutoScalingGroupName": "@{D8AAA535-952D-471A-885E-3C0298B347EB.resource.AutoScalingGroupName}",
                "AdjustmentType": "ChangeInCapacity",
                "MinAdjustmentStep": ""
              }
            },
            "5EDA5B24-28AA-4FAF-AB01-32D00AE7AF12": {
              "name": "cpu-policy-alarm",
              "type": "AWS.CloudWatch.CloudWatch",
              "uid": "5EDA5B24-28AA-4FAF-AB01-32D00AE7AF12",
              "resource": {
                "AlarmArn": "",
                "AlarmName": "cpu-policy-alarm",
                "ComparisonOperator": ">=",
                "EvaluationPeriods": "2",
                "MetricName": "CPUUtilization",
                "Namespace": "AWS/AutoScaling",
                "Period": 300,
                "Statistic": "Average",
                "Threshold": "80",
                "Unit": "",
                "Dimensions": [
                  {
                    "name": "AutoScalingGroupName",
                    "value": "@{D8AAA535-952D-471A-885E-3C0298B347EB.resource.AutoScalingGroupName}"
                  }
                ],
                "AlarmActions": [
                  "@{E98340BB-EF19-43A3-9DB7-C08968200568.resource.PolicyARN}"
                ],
                "InsufficientDataActions": [],
                "OKAction": []
              }
            },
            "68A92730-A034-4C35-B4DA-A92FFC3B7E23": {
              "name": "slave-a",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "68A92730-A034-4C35-B4DA-A92FFC3B7E23",
              "resource": {
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.0.0/24"
              }
            },
            "D8AAA535-952D-471A-885E-3C0298B347EB": {
              "uid": "D8AAA535-952D-471A-885E-3C0298B347EB",
              "name": "slave-asg",
              "description": "",
              "type": "AWS.AutoScaling.Group",
              "resource": {
                "AvailabilityZones": [
                  "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                  "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                ],
                "VPCZoneIdentifier": "@{68A92730-A034-4C35-B4DA-A92FFC3B7E23.resource.SubnetId} , @{DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5.resource.SubnetId}",
                "LoadBalancerNames": [],
                "AutoScalingGroupARN": "",
                "DefaultCooldown": "300",
                "MinSize": "5",
                "MaxSize": "50",
                "HealthCheckType": "EC2",
                "HealthCheckGracePeriod": "300",
                "TerminationPolicies": [
                  "Default"
                ],
                "AutoScalingGroupName": "asg0",
                "DesiredCapacity": "5",
                "LaunchConfigurationName": "@{614019C2-FE77-47FE-8688-E4BB1E362D54.resource.LaunchConfigurationName}"
              }
            },
            "84A5E8B7-37D6-45A2-8FC9-55CD7528024B": {
              "name": "sched-a",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "resource": {
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.2.0/24"
              }
            },
            "5370F073-C8FA-4780-8020-F028EAB99F6B": {
              "type": "AWS.EC2.Instance",
              "uid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "name": "master-0",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "serverGroupName": "master-0",
              "state": [
                {
                  "id": "state-master-0",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateSmall",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "1",
                    "masters_addresses": [
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      }
                    ],
                    "hostname": "master-0",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "t2.small",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "DC92F67A-B503-4BCE-A88B-DC62315FC95E": {
              "index": 0,
              "uid": "DC92F67A-B503-4BCE-A88B-DC62315FC95E",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-0-eni0",
              "serverGroupUid": "DC92F67A-B503-4BCE-A88B-DC62315FC95E",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.4",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "CDBBEFDF-513B-415C-A875-0C54E6C44963": {
              "name": "DefaultSG",
              "type": "AWS.EC2.SecurityGroup",
              "uid": "CDBBEFDF-513B-415C-A875-0C54E6C44963",
              "resource": {
                "Default": true,
                "GroupId": "",
                "GroupName": "DefaultSG",
                "GroupDescription": "default VPC security group",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "IpPermissions": [
                  {
                    "FromPort": "22",
                    "ToPort": "22",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "5050",
                    "ToPort": "5050",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}",
                    "IpProtocol": "-1"
                  }
                ],
                "IpPermissionsEgress": [
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "-1"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF": {
              "name": "MesosSG",
              "type": "AWS.EC2.SecurityGroup",
              "uid": "2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF",
              "resource": {
                "Default": false,
                "GroupId": "",
                "GroupName": "MesosSG",
                "GroupDescription": "Custom Security Group",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "IpPermissions": [
                  {
                    "FromPort": "5050",
                    "ToPort": "5050",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "8080",
                    "ToPort": "8080",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "@{2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF.resource.GroupId}",
                    "IpProtocol": "-1"
                  }
                ],
                "IpPermissionsEgress": [
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "-1"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "false"
                  }
                ]
              }
            },
            "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5": {
              "name": "slave-b",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "resource": {
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.1.0/24"
              }
            },
            "71962761-6E11-48EB-9C72-5862B14D6274": {
              "type": "AWS.EC2.Instance",
              "uid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "name": "master-1",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "serverGroupName": "master-1",
              "state": [
                {
                  "id": "state-master-1",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateSmall",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "2",
                    "masters_addresses": [
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      }
                    ],
                    "hostname": "master-1",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "t2.small",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "37455AEF-A1C3-4820-9CB5-97E50F2678B0": {
              "index": 0,
              "uid": "37455AEF-A1C3-4820-9CB5-97E50F2678B0",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-1-eni0",
              "serverGroupUid": "37455AEF-A1C3-4820-9CB5-97E50F2678B0",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.5",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{71962761-6E11-48EB-9C72-5862B14D6274.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            }
          }

          layout: {
            "6FF14346-1CEF-4F05-837A-5BE2BD143103": {
              "coordinate": [
                77,
                8
              ],
              "uid": "6FF14346-1CEF-4F05-837A-5BE2BD143103",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173"
            },
            "614019C2-FE77-47FE-8688-E4BB1E362D54": {
              "coordinate": [
                0,
                0
              ],
              "uid": "614019C2-FE77-47FE-8688-E4BB1E362D54",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "734547B2-25A5-41F3-A0E4-AA8A842A7173": {
              "coordinate": [
                8,
                7
              ],
              "uid": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                81,
                64
              ]
            },
            "7CB6402A-2A9D-47D2-8C52-D82F40F779CF": {
              "coordinate": [
                14,
                43
              ],
              "uid": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                55,
                24
              ]
            },
            "B2185847-E9CE-49C6-9ECE-55CC53507558": {
              "coordinate": [
                17,
                46
              ],
              "uid": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "groupUId": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "size": [
                28,
                18
              ]
            },
            "A66EF8E5-CBCB-49B3-97B2-2B73BE541292": {
              "coordinate": [
                21,
                51
              ],
              "uid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "groupUId": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "408ECAC2-5785-4179-AF16-2A8D28711314": {
              "coordinate": [
                14,
                14
              ],
              "uid": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                55,
                25
              ]
            },
            "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1": {
              "coordinate": [
                4,
                8
              ],
              "uid": "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173"
            },
            "68A92730-A034-4C35-B4DA-A92FFC3B7E23": {
              "coordinate": [
                47,
                17
              ],
              "uid": "68A92730-A034-4C35-B4DA-A92FFC3B7E23",
              "groupUId": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "size": [
                19,
                19
              ]
            },
            "D8AAA535-952D-471A-885E-3C0298B347EB": {
              "coordinate": [
                50,
                20
              ],
              "uid": "D8AAA535-952D-471A-885E-3C0298B347EB",
              "groupUId": "68A92730-A034-4C35-B4DA-A92FFC3B7E23"
            },
            "84A5E8B7-37D6-45A2-8FC9-55CD7528024B": {
              "coordinate": [
                17,
                17
              ],
              "uid": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "groupUId": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "size": [
                27,
                19
              ]
            },
            "5370F073-C8FA-4780-8020-F028EAB99F6B": {
              "coordinate": [
                21,
                22
              ],
              "uid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5": {
              "coordinate": [
                47,
                46
              ],
              "uid": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "groupUId": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "size": [
                19,
                18
              ]
            },
            "71962761-6E11-48EB-9C72-5862B14D6274": {
              "coordinate": [
                32,
                22
              ],
              "uid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "3CDDB9EB-111B-4610-A175-C2F306A8B093": {
              "coordinate": [
                50,
                49
              ],
              "uid": "3CDDB9EB-111B-4610-A175-C2F306A8B093",
              "groupUId": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "type": "ExpandedAsg",
              "originalId": "D8AAA535-952D-471A-885E-3C0298B347EB"
            },
            "size": [
              240,
              240
            ]
          }
        }
        medium: {
          component: {
            "6FF14346-1CEF-4F05-837A-5BE2BD143103": {
              "name": "RT-0",
              "description": "",
              "type": "AWS.VPC.RouteTable",
              "uid": "6FF14346-1CEF-4F05-837A-5BE2BD143103",
              "resource": {
                "PropagatingVgwSet": [],
                "RouteTableId": "",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "AssociationSet": [
                  {
                    "Main": "true",
                    "RouteTableAssociationId": "",
                    "SubnetId": ""
                  }
                ],
                "RouteSet": [
                  {
                    "Origin": "CreateRouteTable",
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "InstanceId": "",
                    "NetworkInterfaceId": "",
                    "GatewayId": "local"
                  },
                  {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "Origin": "",
                    "InstanceId": "",
                    "NetworkInterfaceId": "",
                    "GatewayId": "@{D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1.resource.InternetGatewayId}"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "37C8D4D4-5FE0-41A9-8E83-47AA9FF87DF9": {
              "name": "DefaultACL",
              "type": "AWS.VPC.NetworkAcl",
              "uid": "37C8D4D4-5FE0-41A9-8E83-47AA9FF87DF9",
              "resource": {
                "AssociationSet": [
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{68A92730-A034-4C35-B4DA-A92FFC3B7E23.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5.resource.SubnetId}"
                  }
                ],
                "Default": true,
                "EntrySet": [
                  {
                    "Egress": true,
                    "Protocol": -1,
                    "RuleAction": "allow",
                    "RuleNumber": 100,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": false,
                    "Protocol": -1,
                    "RuleAction": "allow",
                    "RuleNumber": 100,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": true,
                    "Protocol": -1,
                    "RuleAction": "deny",
                    "RuleNumber": 32767,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": false,
                    "Protocol": -1,
                    "RuleAction": "deny",
                    "RuleNumber": 32767,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  }
                ],
                "NetworkAclId": "",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "614019C2-FE77-47FE-8688-E4BB1E362D54": {
              "type": "AWS.AutoScaling.LaunchConfiguration",
              "uid": "614019C2-FE77-47FE-8688-E4BB1E362D54",
              "name": "slave-lc-0",
              "description": "",
              "state": [
                {
                  "id": "slave-lc-0",
                  "module": "linux.mesos.slave",
                  "parameter": {
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "attributes": [
                      {
                        "key": "asg",
                        "value": "slave-asg"
                      }
                    ],
                    "slave_ip": "@{self.PrivateIpAddress}"
                  }
                }
              ],
              "resource": {
                "UserData": "",
                "LaunchConfigurationARN": "",
                "InstanceMonitoring": false,
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "SecurityGroups": [
                  "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                ],
                "LaunchConfigurationName": "slave-lc-0",
                "InstanceType": "c4.large",
                "AssociatePublicIpAddress": true
              }
            },
            "734547B2-25A5-41F3-A0E4-AA8A842A7173": {
              "name": "mesos",
              "description": "",
              "type": "AWS.VPC.VPC",
              "uid": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "resource": {
                "EnableDnsSupport": true,
                "InstanceTenancy": "default",
                "EnableDnsHostnames": false,
                "DhcpOptionsId": "",
                "VpcId": "",
                "CidrBlock": "10.0.0.0/16"
              }
            },
            "7CB6402A-2A9D-47D2-8C52-D82F40F779CF": {
              "uid": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "name": "us-east-1e",
              "type": "AWS.EC2.AvailabilityZone",
              "resource": {
                "ZoneName": "us-east-1e",
                "RegionName": "us-east-1"
              }
            },
            "B2185847-E9CE-49C6-9ECE-55CC53507558": {
              "name": "sched-b",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "resource": {
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.3.0/24"
              }
            },
            "A66EF8E5-CBCB-49B3-97B2-2B73BE541292": {
              "type": "AWS.EC2.Instance",
              "uid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "name": "master-2",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "serverGroupName": "master-2",
              "state": [
                {
                  "id": "state-master-2",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateMedium",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "4",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-2",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.large",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "E767D0C1-84E0-47E8-9B7C-39102F60C33B": {
              "index": 0,
              "uid": "E767D0C1-84E0-47E8-9B7C-39102F60C33B",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-2-eni0",
              "serverGroupUid": "E767D0C1-84E0-47E8-9B7C-39102F60C33B",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.3.4",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "73391D87-F983-4796-B787-932600747F7D": {
              "name": "DefaultKP",
              "type": "AWS.EC2.KeyPair",
              "uid": "73391D87-F983-4796-B787-932600747F7D",
              "resource": {
                "KeyFingerprint": "",
                "KeyName": ""
              }
            },
            "408ECAC2-5785-4179-AF16-2A8D28711314": {
              "uid": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "name": "us-east-1d",
              "type": "AWS.EC2.AvailabilityZone",
              "resource": {
                "ZoneName": "us-east-1d",
                "RegionName": "us-east-1"
              }
            },
            "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1": {
              "name": "Internet-gateway",
              "type": "AWS.VPC.InternetGateway",
              "uid": "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1",
              "resource": {
                "InternetGatewayId": "",
                "AttachmentSet": [
                  {
                    "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}"
                  }
                ]
              }
            },
            "84A5E8B7-37D6-45A2-8FC9-55CD7528024B": {
              "name": "sched-a",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "resource": {
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.2.0/24"
              }
            },
            "BF743DF0-1730-4135-BFC1-652A13066B96": {
              "type": "AWS.EC2.Instance",
              "uid": "BF743DF0-1730-4135-BFC1-652A13066B96",
              "name": "master-4",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "BF743DF0-1730-4135-BFC1-652A13066B96",
              "serverGroupName": "master-4",
              "state": [
                {
                  "id": "state-master-4",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateMedium",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "5",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-4",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.large",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "1C602A36-BB35-41A7-83CD-78ADD657FED2": {
              "index": 0,
              "uid": "1C602A36-BB35-41A7-83CD-78ADD657FED2",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-4-eni0",
              "serverGroupUid": "1C602A36-BB35-41A7-83CD-78ADD657FED2",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.6",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{BF743DF0-1730-4135-BFC1-652A13066B96.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "CDBBEFDF-513B-415C-A875-0C54E6C44963": {
              "name": "DefaultSG",
              "type": "AWS.EC2.SecurityGroup",
              "uid": "CDBBEFDF-513B-415C-A875-0C54E6C44963",
              "resource": {
                "Default": true,
                "GroupId": "",
                "GroupName": "DefaultSG",
                "GroupDescription": "default VPC security group",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "IpPermissions": [
                  {
                    "FromPort": "22",
                    "ToPort": "22",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "5050",
                    "ToPort": "5050",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}",
                    "IpProtocol": "-1"
                  }
                ],
                "IpPermissionsEgress": [
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "-1"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "5370F073-C8FA-4780-8020-F028EAB99F6B": {
              "type": "AWS.EC2.Instance",
              "uid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "name": "master-0",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "serverGroupName": "master-0",
              "state": [
                {
                  "id": "state-master-0",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateMedium",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "2",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-0",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.large",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "DC92F67A-B503-4BCE-A88B-DC62315FC95E": {
              "index": 0,
              "uid": "DC92F67A-B503-4BCE-A88B-DC62315FC95E",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-0-eni0",
              "serverGroupUid": "DC92F67A-B503-4BCE-A88B-DC62315FC95E",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.4",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF": {
              "name": "MesosSG",
              "type": "AWS.EC2.SecurityGroup",
              "uid": "2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF",
              "resource": {
                "Default": false,
                "GroupId": "",
                "GroupName": "MesosSG",
                "GroupDescription": "Custom Security Group",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "IpPermissions": [
                  {
                    "FromPort": "5050",
                    "ToPort": "5050",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "8080",
                    "ToPort": "8080",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "@{2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF.resource.GroupId}",
                    "IpProtocol": "-1"
                  }
                ],
                "IpPermissionsEgress": [
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "-1"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "false"
                  }
                ]
              }
            },
            "364B215C-F322-4F82-90EE-C6944452499A": {
              "type": "AWS.EC2.Instance",
              "uid": "364B215C-F322-4F82-90EE-C6944452499A",
              "name": "master-3",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "364B215C-F322-4F82-90EE-C6944452499A",
              "serverGroupName": "master-3",
              "state": [
                {
                  "id": "state-master-3",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateMedium",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "1",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-3",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.large",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "6B0F081E-1D97-40F1-AB36-3015AAEDB200": {
              "index": 0,
              "uid": "6B0F081E-1D97-40F1-AB36-3015AAEDB200",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-3-eni0",
              "serverGroupUid": "6B0F081E-1D97-40F1-AB36-3015AAEDB200",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.3.5",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{364B215C-F322-4F82-90EE-C6944452499A.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "68A92730-A034-4C35-B4DA-A92FFC3B7E23": {
              "name": "slave-a",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "68A92730-A034-4C35-B4DA-A92FFC3B7E23",
              "resource": {
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.0.0/24"
              }
            },
            "D8AAA535-952D-471A-885E-3C0298B347EB": {
              "uid": "D8AAA535-952D-471A-885E-3C0298B347EB",
              "name": "slave-asg",
              "description": "",
              "type": "AWS.AutoScaling.Group",
              "resource": {
                "AvailabilityZones": [
                  "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                  "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                ],
                "VPCZoneIdentifier": "@{68A92730-A034-4C35-B4DA-A92FFC3B7E23.resource.SubnetId} , @{DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5.resource.SubnetId}",
                "LoadBalancerNames": [],
                "AutoScalingGroupARN": "",
                "DefaultCooldown": "300",
                "MinSize": "10",
                "MaxSize": "200",
                "HealthCheckType": "EC2",
                "HealthCheckGracePeriod": "300",
                "TerminationPolicies": [
                  "Default"
                ],
                "AutoScalingGroupName": "asg0",
                "DesiredCapacity": "10",
                "LaunchConfigurationName": "@{614019C2-FE77-47FE-8688-E4BB1E362D54.resource.LaunchConfigurationName}"
              }
            },
            "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5": {
              "name": "slave-b",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "resource": {
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.1.0/24"
              }
            },
            "71962761-6E11-48EB-9C72-5862B14D6274": {
              "type": "AWS.EC2.Instance",
              "uid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "name": "master-1",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "serverGroupName": "master-1",
              "state": [
                {
                  "id": "state-master-1",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateMedium",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "3",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-1",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.large",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "37455AEF-A1C3-4820-9CB5-97E50F2678B0": {
              "index": 0,
              "uid": "37455AEF-A1C3-4820-9CB5-97E50F2678B0",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-1-eni0",
              "serverGroupUid": "37455AEF-A1C3-4820-9CB5-97E50F2678B0",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.5",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{71962761-6E11-48EB-9C72-5862B14D6274.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "9A3AA57D-4014-4D3E-9C1E-3035A728ED43": {
              "name": "cpu-policy",
              "type": "AWS.AutoScaling.ScalingPolicy",
              "uid": "9A3AA57D-4014-4D3E-9C1E-3035A728ED43",
              "resource": {
                "ScalingAdjustment": "5",
                "PolicyName": "cpu-policy",
                "PolicyARN": "",
                "Cooldown": "300",
                "AutoScalingGroupName": "@{D8AAA535-952D-471A-885E-3C0298B347EB.resource.AutoScalingGroupName}",
                "AdjustmentType": "ChangeInCapacity",
                "MinAdjustmentStep": ""
              }
            },
            "DFE4D869-C2D1-4F8C-883E-B2AAB31B4273": {
              "name": "cpu-policy-alarm",
              "type": "AWS.CloudWatch.CloudWatch",
              "uid": "DFE4D869-C2D1-4F8C-883E-B2AAB31B4273",
              "resource": {
                "AlarmArn": "",
                "AlarmName": "cpu-policy-alarm",
                "ComparisonOperator": ">=",
                "EvaluationPeriods": "2",
                "MetricName": "CPUUtilization",
                "Namespace": "AWS/AutoScaling",
                "Period": 300,
                "Statistic": "Average",
                "Threshold": "80",
                "Unit": "",
                "Dimensions": [
                  {
                    "name": "AutoScalingGroupName",
                    "value": "@{D8AAA535-952D-471A-885E-3C0298B347EB.resource.AutoScalingGroupName}"
                  }
                ],
                "AlarmActions": [
                  "@{9A3AA57D-4014-4D3E-9C1E-3035A728ED43.resource.PolicyARN}"
                ],
                "InsufficientDataActions": [],
                "OKAction": []
              }
            }
          },

          layout: {
            "6FF14346-1CEF-4F05-837A-5BE2BD143103": {
              "coordinate": [
                77,
                8
              ],
              "uid": "6FF14346-1CEF-4F05-837A-5BE2BD143103",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173"
            },
            "614019C2-FE77-47FE-8688-E4BB1E362D54": {
              "coordinate": [
                0,
                0
              ],
              "uid": "614019C2-FE77-47FE-8688-E4BB1E362D54",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "734547B2-25A5-41F3-A0E4-AA8A842A7173": {
              "coordinate": [
                8,
                7
              ],
              "uid": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                97,
                76
              ]
            },
            "7CB6402A-2A9D-47D2-8C52-D82F40F779CF": {
              "coordinate": [
                13,
                56
              ],
              "uid": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                84,
                24
              ]
            },
            "B2185847-E9CE-49C6-9ECE-55CC53507558": {
              "coordinate": [
                16,
                59
              ],
              "uid": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "groupUId": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "size": [
                55,
                18
              ]
            },
            "A66EF8E5-CBCB-49B3-97B2-2B73BE541292": {
              "coordinate": [
                20,
                64
              ],
              "uid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "groupUId": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "408ECAC2-5785-4179-AF16-2A8D28711314": {
              "coordinate": [
                13,
                26
              ],
              "uid": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                84,
                25
              ]
            },
            "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1": {
              "coordinate": [
                4,
                8
              ],
              "uid": "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173"
            },
            "84A5E8B7-37D6-45A2-8FC9-55CD7528024B": {
              "coordinate": [
                16,
                29
              ],
              "uid": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "groupUId": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "size": [
                55,
                19
              ]
            },
            "BF743DF0-1730-4135-BFC1-652A13066B96": {
              "coordinate": [
                46,
                34
              ],
              "uid": "BF743DF0-1730-4135-BFC1-652A13066B96",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "5370F073-C8FA-4780-8020-F028EAB99F6B": {
              "coordinate": [
                20,
                34
              ],
              "uid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "364B215C-F322-4F82-90EE-C6944452499A": {
              "coordinate": [
                33,
                64
              ],
              "uid": "364B215C-F322-4F82-90EE-C6944452499A",
              "groupUId": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "68A92730-A034-4C35-B4DA-A92FFC3B7E23": {
              "coordinate": [
                74,
                29
              ],
              "uid": "68A92730-A034-4C35-B4DA-A92FFC3B7E23",
              "groupUId": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "size": [
                19,
                19
              ]
            },
            "D8AAA535-952D-471A-885E-3C0298B347EB": {
              "coordinate": [
                77,
                32
              ],
              "uid": "D8AAA535-952D-471A-885E-3C0298B347EB",
              "groupUId": "68A92730-A034-4C35-B4DA-A92FFC3B7E23"
            },
            "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5": {
              "coordinate": [
                74,
                59
              ],
              "uid": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "groupUId": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "size": [
                19,
                18
              ]
            },
            "71962761-6E11-48EB-9C72-5862B14D6274": {
              "coordinate": [
                33,
                34
              ],
              "uid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "655F3932-DD15-4842-818C-5E06BAC13E0E": {
              "coordinate": [
                77,
                62
              ],
              "uid": "655F3932-DD15-4842-818C-5E06BAC13E0E",
              "groupUId": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "type": "ExpandedAsg",
              "originalId": "D8AAA535-952D-471A-885E-3C0298B347EB"
            },
            "size": [
              240,
              240
            ]
          }
        }
        large: {
          component: {
            "6FF14346-1CEF-4F05-837A-5BE2BD143103": {
              "name": "RT-0",
              "description": "",
              "type": "AWS.VPC.RouteTable",
              "uid": "6FF14346-1CEF-4F05-837A-5BE2BD143103",
              "resource": {
                "PropagatingVgwSet": [],
                "RouteTableId": "",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "AssociationSet": [
                  {
                    "Main": "true",
                    "RouteTableAssociationId": "",
                    "SubnetId": ""
                  }
                ],
                "RouteSet": [
                  {
                    "Origin": "CreateRouteTable",
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "InstanceId": "",
                    "NetworkInterfaceId": "",
                    "GatewayId": "local"
                  },
                  {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "Origin": "",
                    "InstanceId": "",
                    "NetworkInterfaceId": "",
                    "GatewayId": "@{D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1.resource.InternetGatewayId}"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "614019C2-FE77-47FE-8688-E4BB1E362D54": {
              "type": "AWS.AutoScaling.LaunchConfiguration",
              "uid": "614019C2-FE77-47FE-8688-E4BB1E362D54",
              "name": "slave-lc-0",
              "description": "",
              "state": [
                {
                  "id": "slave-lc-0",
                  "module": "linux.mesos.slave",
                  "parameter": {
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "attributes": [
                      {
                        "key": "asg",
                        "value": "slave-asg"
                      }
                    ],
                    "slave_ip": "@{self.PrivateIpAddress}"
                  }
                }
              ],
              "resource": {
                "UserData": "",
                "LaunchConfigurationARN": "",
                "InstanceMonitoring": false,
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "SecurityGroups": [
                  "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                ],
                "LaunchConfigurationName": "slave-lc-0",
                "InstanceType": "c4.2xlarge",
                "AssociatePublicIpAddress": true
              }
            },
            "37C8D4D4-5FE0-41A9-8E83-47AA9FF87DF9": {
              "name": "DefaultACL",
              "type": "AWS.VPC.NetworkAcl",
              "uid": "37C8D4D4-5FE0-41A9-8E83-47AA9FF87DF9",
              "resource": {
                "AssociationSet": [
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{68A92730-A034-4C35-B4DA-A92FFC3B7E23.resource.SubnetId}"
                  },
                  {
                    "NetworkAclAssociationId": "",
                    "SubnetId": "@{DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5.resource.SubnetId}"
                  }
                ],
                "Default": true,
                "EntrySet": [
                  {
                    "Egress": true,
                    "Protocol": -1,
                    "RuleAction": "allow",
                    "RuleNumber": 100,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": false,
                    "Protocol": -1,
                    "RuleAction": "allow",
                    "RuleNumber": 100,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": true,
                    "Protocol": -1,
                    "RuleAction": "deny",
                    "RuleNumber": 32767,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  },
                  {
                    "Egress": false,
                    "Protocol": -1,
                    "RuleAction": "deny",
                    "RuleNumber": 32767,
                    "CidrBlock": "0.0.0.0/0",
                    "IcmpTypeCode": {
                      "Code": "",
                      "Type": ""
                    },
                    "PortRange": {
                      "From": "",
                      "To": ""
                    }
                  }
                ],
                "NetworkAclId": "",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "734547B2-25A5-41F3-A0E4-AA8A842A7173": {
              "name": "mesos",
              "description": "",
              "type": "AWS.VPC.VPC",
              "uid": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "resource": {
                "EnableDnsSupport": true,
                "InstanceTenancy": "default",
                "EnableDnsHostnames": false,
                "DhcpOptionsId": "",
                "VpcId": "",
                "CidrBlock": "10.0.0.0/16"
              }
            },
            "7CB6402A-2A9D-47D2-8C52-D82F40F779CF": {
              "uid": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "name": "us-east-1e",
              "type": "AWS.EC2.AvailabilityZone",
              "resource": {
                "ZoneName": "us-east-1e",
                "RegionName": "us-east-1"
              }
            },
            "B2185847-E9CE-49C6-9ECE-55CC53507558": {
              "name": "sched-b",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "resource": {
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.3.0/24"
              }
            },
            "A66EF8E5-CBCB-49B3-97B2-2B73BE541292": {
              "type": "AWS.EC2.Instance",
              "uid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "name": "master-2",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "serverGroupName": "master-2",
              "state": [
                {
                  "id": "state-master-2",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateLarge",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "4",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-2",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.2xlarge",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "E767D0C1-84E0-47E8-9B7C-39102F60C33B": {
              "index": 0,
              "uid": "E767D0C1-84E0-47E8-9B7C-39102F60C33B",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-2-eni0",
              "serverGroupUid": "E767D0C1-84E0-47E8-9B7C-39102F60C33B",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.3.4",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "73391D87-F983-4796-B787-932600747F7D": {
              "name": "DefaultKP",
              "type": "AWS.EC2.KeyPair",
              "uid": "73391D87-F983-4796-B787-932600747F7D",
              "resource": {
                "KeyFingerprint": "",
                "KeyName": ""
              }
            },
            "408ECAC2-5785-4179-AF16-2A8D28711314": {
              "uid": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "name": "us-east-1d",
              "type": "AWS.EC2.AvailabilityZone",
              "resource": {
                "ZoneName": "us-east-1d",
                "RegionName": "us-east-1"
              }
            },
            "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1": {
              "name": "Internet-gateway",
              "type": "AWS.VPC.InternetGateway",
              "uid": "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1",
              "resource": {
                "InternetGatewayId": "",
                "AttachmentSet": [
                  {
                    "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}"
                  }
                ]
              }
            },
            "84A5E8B7-37D6-45A2-8FC9-55CD7528024B": {
              "name": "sched-a",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "resource": {
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.2.0/24"
              }
            },
            "BF743DF0-1730-4135-BFC1-652A13066B96": {
              "type": "AWS.EC2.Instance",
              "uid": "BF743DF0-1730-4135-BFC1-652A13066B96",
              "name": "master-4",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "BF743DF0-1730-4135-BFC1-652A13066B96",
              "serverGroupName": "master-4",
              "state": [
                {
                  "id": "state-master-4",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateLarge",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "5",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-4",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.2xlarge",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "1C602A36-BB35-41A7-83CD-78ADD657FED2": {
              "index": 0,
              "uid": "1C602A36-BB35-41A7-83CD-78ADD657FED2",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-4-eni0",
              "serverGroupUid": "1C602A36-BB35-41A7-83CD-78ADD657FED2",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.6",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{BF743DF0-1730-4135-BFC1-652A13066B96.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "CDBBEFDF-513B-415C-A875-0C54E6C44963": {
              "name": "DefaultSG",
              "type": "AWS.EC2.SecurityGroup",
              "uid": "CDBBEFDF-513B-415C-A875-0C54E6C44963",
              "resource": {
                "Default": true,
                "GroupId": "",
                "GroupName": "DefaultSG",
                "GroupDescription": "default VPC security group",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "IpPermissions": [
                  {
                    "FromPort": "22",
                    "ToPort": "22",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "5050",
                    "ToPort": "5050",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}",
                    "IpProtocol": "-1"
                  }
                ],
                "IpPermissionsEgress": [
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "-1"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "true"
                  }
                ]
              }
            },
            "5370F073-C8FA-4780-8020-F028EAB99F6B": {
              "type": "AWS.EC2.Instance",
              "uid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "name": "master-0",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "serverGroupName": "master-0",
              "state": [
                {
                  "id": "state-master-0",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateLarge",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "2",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-0",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.2xlarge",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "DC92F67A-B503-4BCE-A88B-DC62315FC95E": {
              "index": 0,
              "uid": "DC92F67A-B503-4BCE-A88B-DC62315FC95E",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-0-eni0",
              "serverGroupUid": "DC92F67A-B503-4BCE-A88B-DC62315FC95E",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.4",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF": {
              "name": "MesosSG",
              "type": "AWS.EC2.SecurityGroup",
              "uid": "2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF",
              "resource": {
                "Default": false,
                "GroupId": "",
                "GroupName": "MesosSG",
                "GroupDescription": "Custom Security Group",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "IpPermissions": [
                  {
                    "FromPort": "5050",
                    "ToPort": "5050",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "8080",
                    "ToPort": "8080",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "tcp"
                  },
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "@{2FF8AA56-2F7E-4CA1-B967-8C2F8918D9EF.resource.GroupId}",
                    "IpProtocol": "-1"
                  }
                ],
                "IpPermissionsEgress": [
                  {
                    "FromPort": "0",
                    "ToPort": "65535",
                    "IpRanges": "0.0.0.0/0",
                    "IpProtocol": "-1"
                  }
                ],
                "Tags": [
                  {
                    "Key": "visops_default",
                    "Value": "false"
                  }
                ]
              }
            },
            "364B215C-F322-4F82-90EE-C6944452499A": {
              "type": "AWS.EC2.Instance",
              "uid": "364B215C-F322-4F82-90EE-C6944452499A",
              "name": "master-3",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "364B215C-F322-4F82-90EE-C6944452499A",
              "serverGroupName": "master-3",
              "state": [
                {
                  "id": "state-master-3",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateLarge",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "1",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-3",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.2xlarge",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "6B0F081E-1D97-40F1-AB36-3015AAEDB200": {
              "index": 0,
              "uid": "6B0F081E-1D97-40F1-AB36-3015AAEDB200",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-3-eni0",
              "serverGroupUid": "6B0F081E-1D97-40F1-AB36-3015AAEDB200",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{B2185847-E9CE-49C6-9ECE-55CC53507558.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.3.5",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{364B215C-F322-4F82-90EE-C6944452499A.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "68A92730-A034-4C35-B4DA-A92FFC3B7E23": {
              "name": "slave-a",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "68A92730-A034-4C35-B4DA-A92FFC3B7E23",
              "resource": {
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.0.0/24"
              }
            },
            "D8AAA535-952D-471A-885E-3C0298B347EB": {
              "uid": "D8AAA535-952D-471A-885E-3C0298B347EB",
              "name": "slave-asg",
              "description": "",
              "type": "AWS.AutoScaling.Group",
              "resource": {
                "AvailabilityZones": [
                  "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                  "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}"
                ],
                "VPCZoneIdentifier": "@{68A92730-A034-4C35-B4DA-A92FFC3B7E23.resource.SubnetId} , @{DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5.resource.SubnetId}",
                "LoadBalancerNames": [],
                "AutoScalingGroupARN": "",
                "DefaultCooldown": "300",
                "MinSize": "10",
                "MaxSize": "1000",
                "HealthCheckType": "EC2",
                "HealthCheckGracePeriod": "300",
                "TerminationPolicies": [
                  "Default"
                ],
                "AutoScalingGroupName": "asg0",
                "DesiredCapacity": "10",
                "LaunchConfigurationName": "@{614019C2-FE77-47FE-8688-E4BB1E362D54.resource.LaunchConfigurationName}"
              }
            },
            "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5": {
              "name": "slave-b",
              "description": "",
              "type": "AWS.VPC.Subnet",
              "uid": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "resource": {
                "AvailabilityZone": "@{7CB6402A-2A9D-47D2-8C52-D82F40F779CF.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "",
                "CidrBlock": "10.0.1.0/24"
              }
            },
            "71962761-6E11-48EB-9C72-5862B14D6274": {
              "type": "AWS.EC2.Instance",
              "uid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "name": "master-1",
              "description": "",
              "index": 0,
              "number": 1,
              "serverGroupUid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "serverGroupName": "master-1",
              "state": [
                {
                  "id": "state-master-1",
                  "module": "linux.mesos.master",
                  "parameter": {
                    "cluster_name": "MesosTemplateLarge",
                    "master_ip": "@{self.PrivateIpAddress}",
                    "server_id": "3",
                    "masters_addresses": [
                      {
                        "key": "@{364B215C-F322-4F82-90EE-C6944452499A.PrivateIpAddress}",
                        "value": "master-3"
                      },
                      {
                        "key": "@{5370F073-C8FA-4780-8020-F028EAB99F6B.PrivateIpAddress}",
                        "value": "master-0"
                      },
                      {
                        "key": "@{71962761-6E11-48EB-9C72-5862B14D6274.PrivateIpAddress}",
                        "value": "master-1"
                      },
                      {
                        "key": "@{A66EF8E5-CBCB-49B3-97B2-2B73BE541292.PrivateIpAddress}",
                        "value": "master-2"
                      },
                      {
                        "key": "@{BF743DF0-1730-4135-BFC1-652A13066B96.PrivateIpAddress}",
                        "value": "master-4"
                      }
                    ],
                    "hostname": "master-1",
                    "framework": [
                      "marathon"
                    ]
                  }
                }
              ],
              "resource": {
                "UserData": {
                  "Base64Encoded": false,
                  "Data": ""
                },
                "BlockDeviceMapping": [
                  {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                      "SnapshotId": "snap-00fc3bbc",
                      "VolumeSize": 8,
                      "VolumeType": "gp2"
                    }
                  }
                ],
                "Placement": {
                  "Tenancy": "",
                  "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}"
                },
                "InstanceId": "",
                "ImageId": "ami-9ef278f6",
                "KeyName": "@{73391D87-F983-4796-B787-932600747F7D.resource.KeyName}",
                "EbsOptimized": false,
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "Monitoring": "disabled",
                "NetworkInterface": [],
                "InstanceType": "m3.2xlarge",
                "DisableApiTermination": false,
                "ShutdownBehavior": "terminate",
                "SecurityGroup": [],
                "SecurityGroupId": []
              }
            },
            "37455AEF-A1C3-4820-9CB5-97E50F2678B0": {
              "index": 0,
              "uid": "37455AEF-A1C3-4820-9CB5-97E50F2678B0",
              "type": "AWS.VPC.NetworkInterface",
              "name": "master-1-eni0",
              "serverGroupUid": "37455AEF-A1C3-4820-9CB5-97E50F2678B0",
              "serverGroupName": "eni0",
              "number": 1,
              "resource": {
                "SourceDestCheck": true,
                "Description": "",
                "NetworkInterfaceId": "",
                "AvailabilityZone": "@{408ECAC2-5785-4179-AF16-2A8D28711314.resource.ZoneName}",
                "VpcId": "@{734547B2-25A5-41F3-A0E4-AA8A842A7173.resource.VpcId}",
                "SubnetId": "@{84A5E8B7-37D6-45A2-8FC9-55CD7528024B.resource.SubnetId}",
                "AssociatePublicIpAddress": true,
                "PrivateIpAddressSet": [
                  {
                    "PrivateIpAddress": "10.0.2.5",
                    "AutoAssign": true,
                    "Primary": true
                  }
                ],
                "GroupSet": [
                  {
                    "GroupName": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupName}",
                    "GroupId": "@{CDBBEFDF-513B-415C-A875-0C54E6C44963.resource.GroupId}"
                  }
                ],
                "Attachment": {
                  "InstanceId": "@{71962761-6E11-48EB-9C72-5862B14D6274.resource.InstanceId}",
                  "DeviceIndex": "0",
                  "AttachmentId": ""
                }
              }
            },
            "9A3AA57D-4014-4D3E-9C1E-3035A728ED43": {
              "name": "cpu-policy",
              "type": "AWS.AutoScaling.ScalingPolicy",
              "uid": "9A3AA57D-4014-4D3E-9C1E-3035A728ED43",
              "resource": {
                "ScalingAdjustment": "20",
                "PolicyName": "cpu-policy",
                "PolicyARN": "",
                "Cooldown": "300",
                "AutoScalingGroupName": "@{D8AAA535-952D-471A-885E-3C0298B347EB.resource.AutoScalingGroupName}",
                "AdjustmentType": "PercentChangeInCapacity",
                "MinAdjustmentStep": "2"
              }
            },
            "DFE4D869-C2D1-4F8C-883E-B2AAB31B4273": {
              "name": "cpu-policy-alarm",
              "type": "AWS.CloudWatch.CloudWatch",
              "uid": "DFE4D869-C2D1-4F8C-883E-B2AAB31B4273",
              "resource": {
                "AlarmArn": "",
                "AlarmName": "cpu-policy-alarm",
                "ComparisonOperator": ">=",
                "EvaluationPeriods": "2",
                "MetricName": "CPUUtilization",
                "Namespace": "AWS/AutoScaling",
                "Period": 300,
                "Statistic": "Average",
                "Threshold": "80",
                "Unit": "",
                "Dimensions": [
                  {
                    "name": "AutoScalingGroupName",
                    "value": "@{D8AAA535-952D-471A-885E-3C0298B347EB.resource.AutoScalingGroupName}"
                  }
                ],
                "AlarmActions": [
                  "@{9A3AA57D-4014-4D3E-9C1E-3035A728ED43.resource.PolicyARN}"
                ],
                "InsufficientDataActions": [],
                "OKAction": []
              }
            }
          },

          layout: {
            "6FF14346-1CEF-4F05-837A-5BE2BD143103": {
              "coordinate": [
                77,
                8
              ],
              "uid": "6FF14346-1CEF-4F05-837A-5BE2BD143103",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173"
            },
            "614019C2-FE77-47FE-8688-E4BB1E362D54": {
              "coordinate": [
                0,
                0
              ],
              "uid": "614019C2-FE77-47FE-8688-E4BB1E362D54",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "734547B2-25A5-41F3-A0E4-AA8A842A7173": {
              "coordinate": [
                8,
                7
              ],
              "uid": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                97,
                76
              ]
            },
            "7CB6402A-2A9D-47D2-8C52-D82F40F779CF": {
              "coordinate": [
                13,
                56
              ],
              "uid": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                84,
                24
              ]
            },
            "B2185847-E9CE-49C6-9ECE-55CC53507558": {
              "coordinate": [
                16,
                59
              ],
              "uid": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "groupUId": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "size": [
                55,
                18
              ]
            },
            "A66EF8E5-CBCB-49B3-97B2-2B73BE541292": {
              "coordinate": [
                20,
                64
              ],
              "uid": "A66EF8E5-CBCB-49B3-97B2-2B73BE541292",
              "groupUId": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "408ECAC2-5785-4179-AF16-2A8D28711314": {
              "coordinate": [
                13,
                26
              ],
              "uid": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173",
              "size": [
                84,
                25
              ]
            },
            "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1": {
              "coordinate": [
                4,
                8
              ],
              "uid": "D1A89FF8-EBA5-4B73-B9E3-871EFC3E5DF1",
              "groupUId": "734547B2-25A5-41F3-A0E4-AA8A842A7173"
            },
            "84A5E8B7-37D6-45A2-8FC9-55CD7528024B": {
              "coordinate": [
                16,
                29
              ],
              "uid": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "groupUId": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "size": [
                55,
                19
              ]
            },
            "BF743DF0-1730-4135-BFC1-652A13066B96": {
              "coordinate": [
                46,
                34
              ],
              "uid": "BF743DF0-1730-4135-BFC1-652A13066B96",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "5370F073-C8FA-4780-8020-F028EAB99F6B": {
              "coordinate": [
                20,
                34
              ],
              "uid": "5370F073-C8FA-4780-8020-F028EAB99F6B",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "364B215C-F322-4F82-90EE-C6944452499A": {
              "coordinate": [
                33,
                64
              ],
              "uid": "364B215C-F322-4F82-90EE-C6944452499A",
              "groupUId": "B2185847-E9CE-49C6-9ECE-55CC53507558",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "68A92730-A034-4C35-B4DA-A92FFC3B7E23": {
              "coordinate": [
                74,
                29
              ],
              "uid": "68A92730-A034-4C35-B4DA-A92FFC3B7E23",
              "groupUId": "408ECAC2-5785-4179-AF16-2A8D28711314",
              "size": [
                19,
                19
              ]
            },
            "D8AAA535-952D-471A-885E-3C0298B347EB": {
              "coordinate": [
                77,
                32
              ],
              "uid": "D8AAA535-952D-471A-885E-3C0298B347EB",
              "groupUId": "68A92730-A034-4C35-B4DA-A92FFC3B7E23"
            },
            "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5": {
              "coordinate": [
                74,
                59
              ],
              "uid": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "groupUId": "7CB6402A-2A9D-47D2-8C52-D82F40F779CF",
              "size": [
                19,
                18
              ]
            },
            "71962761-6E11-48EB-9C72-5862B14D6274": {
              "coordinate": [
                33,
                34
              ],
              "uid": "71962761-6E11-48EB-9C72-5862B14D6274",
              "groupUId": "84A5E8B7-37D6-45A2-8FC9-55CD7528024B",
              "osType": "ubuntu",
              "architecture": "x86_64",
              "rootDeviceType": "ebs"
            },
            "655F3932-DD15-4842-818C-5E06BAC13E0E": {
              "coordinate": [
                77,
                62
              ],
              "uid": "655F3932-DD15-4842-818C-5E06BAC13E0E",
              "groupUId": "DB9AB38A-4571-4F56-8FC5-1F2C4119C2A5",
              "type": "ExpandedAsg",
              "originalId": "D8AAA535-952D-471A-885E-3C0298B347EB"
            },
            "size": [
              240,
              240
            ]
          }
        }
      }

      defaultStack = simpleMesosMap[scale]

      json   = OpsModel.prototype.__defaultJson.call this

      amiForEachRegion = [
        {"region":"us-east-1","imageId":"ami-9ef278f6"}
        {"region":"us-west-1","imageId":"ami-353f2970"}
        {"region":"eu-west-1","imageId":"ami-1a92266d"}
        {"region":"us-west-2","imageId":"ami-fba3e8cb"}
        {"region":"eu-central-1","imageId":"ami-929caa8f"}
        {"region":"ap-southeast-2","imageId":"ami-5fe28d65"}
        {"region":"ap-northeast-1","imageId":"ami-9d7f479c"}
        {"region":"ap-southeast-1","imageId":"ami-a6a083f4"}
        {"region":"sa-east-1","imageId":"ami-c79e28da"}
      ]

      framework =  if @getStackFramework() then ["marathon"] else []
      imageId = @getAmiId() || (_.findWhere amiForEachRegion, {region: @get("region")}).imageId
      regionName = @get("region")

      component = defaultStack.component
      layout = defaultStack.layout

      componentKeys = _.keys component
      layoutKeys = _.keys layout

      keys = _.without (_.union componentKeys, layoutKeys), "size"

      layoutJson = JSON.stringify(layout)
      componentJson = JSON.stringify(component)

      # replace with random guid.
      _.each keys, (key)->
        guid = MC.guid()
        componentJson = componentJson.replace(new RegExp(key, "g"), guid)
        layoutJson = layoutJson.replace(new RegExp(key, "g"), guid)

      # replace region-id in subnet
      _.each _.pluck(amiForEachRegion, "region"), (region)->
        componentJson = componentJson.replace(new RegExp(region, "g"), regionName)

      # replace to dist imageId
      componentJson = componentJson.replace(/ami-\w{8}/g, imageId)

      component = JSON.parse(componentJson)
      layout = JSON.parse(layoutJson)

      # set framework option
      _.each component, (comp)->
        if comp.type in [constant.RESTYPE.INSTANCE, constant.RESTYPE.LC]
          _.each comp.state, (st)->
            if st.module is "linux.mesos.master"
              st.parameter.framework = framework

      json.component = component
      json.layout = layout

      console.log json
      json

  }, {
    supportedProviders : ["aws::global", "aws::china"]
  }

  AwsOpsModel
