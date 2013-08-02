define [ 'MC' ], ( MC ) ->

	#private
	init = (uid) ->

		elbComp = MC.canvas_data.component[uid]

		# init
		newELBName = MC.aws.elb.getNewName()
		MC.canvas_data.component[uid].resource.LoadBalancerName = newELBName
		MC.canvas_data.component[uid].name = newELBName
		MC.canvas.update uid, 'text', 'elb_name', newELBName

		allComp = MC.canvas_data.component
		haveVPC = elbComp.resource.VpcId
		if !haveVPC
			MC.canvas_data.component[uid].resource.Scheme = ''

		# have igw ?
		igwCompAry = _.filter allComp, (obj) ->
			obj.type is 'AWS.VPC.InternetGateway'
		if igwCompAry.length isnt 0
			MC.canvas_data.component[uid].resource.Scheme = 'internet-facing'

		# create elb default sg
		sgComp = $.extend(true, {}, MC.canvas.SG_JSON.data)
		sgComp.uid = MC.guid()
		sgComp.name = newELBName + '-sg'
		sgComp.resource.GroupName = sgComp.name
		MC.canvas_data.component[sgComp.uid] = sgComp

		sgRef = '@' + sgComp.uid + '.resource.GroupId'
		MC.canvas_data.component[uid].resource.SecurityGroups.push(sgRef)

		# add rule to default sg
		MC.aws.elb.addRuleToElbSG uid

		null

	getNewName = () ->
		maxNum = 0
		namePrefix = 'load-balancer-'
		_.each MC.canvas_data.component, (compObj) ->
			compType = compObj.type
			if compType is 'AWS.ELB'
				elbName = compObj.name
				if elbName.slice(0, namePrefix.length) is namePrefix
					currentNum = Number(elbName.slice(namePrefix.length))
					if currentNum > maxNum
						maxNum = currentNum
			null
		maxNum++
		return namePrefix + maxNum

	addInstanceAndAZToELB = (elbUID, instanceUID) ->
		elbComp = MC.canvas_data.component[elbUID]
		instanceComp = MC.canvas_data.component[instanceUID]

		currentInstanceAZ = instanceComp.resource.Placement.AvailabilityZone

		instanceUID = instanceComp.uid
		instanceRef = '@' + instanceUID + '.resource.InstanceId'

		elbInstanceAry = elbComp.resource.Instances
		elbInstanceAryLength = elbInstanceAry.length

		elbAZAry = elbComp.resource.AvailabilityZones
		elbAZAryLength = elbAZAry.length

		addInstanceToElb = true
		_.each elbInstanceAry, (elem, index) ->
			if elem.InstanceId is instanceRef
				addInstanceToElb = false
				null

		if addInstanceToElb
			MC.canvas_data.component[elbUID].resource.Instances.push({
				InstanceId: instanceRef
			})

		addAZToElb = true
		_.each elbAZAry, (elem, index) ->
			if elem is currentInstanceAZ
				addAZToElb = false
				null

		if addAZToElb
			MC.canvas_data.component[elbUID].resource.AvailabilityZones.push(currentInstanceAZ)

		# If current AZ has no subnet connects to the elb. connect the subnet to elb
		subnet_uid = "@" + subnet_uid + ".resource.SubnetId"

		for subnet, i in elbComp.resource.Subnets
			linkedSubnetID = MC.extractID( subnet )
			linkedSubnet   = MC.canvas_data.component[ linkedSubnetID ]

			if linkedSubnet.resource.AvailabilityZone == currentInstanceAZ
				alreadyLinkedSubnet = true
				break

		if !alreadyLinkedSubnet && instanceComp.resource.SubnetId
			elbComp.resource.Subnets.push instanceComp.resource.SubnetId
			return MC.extractID( instanceComp.resource.SubnetId )

		null

	removeInstanceFromELB = (elbUID, instanceUID) ->
		elbComp = MC.canvas_data.component[elbUID]
		instanceComp = MC.canvas_data.component[instanceUID]

		instanceUID = instanceComp.uid
		instanceRef = '@' + instanceUID + '.resource.InstanceId'

		elbInstanceAry = elbComp.resource.Instances
		elbInstanceAryLength = elbInstanceAry.length

		instanceAry = MC.canvas_data.component[elbUID].resource.Instances

		newInstanceAry = _.filter instanceAry, (value) ->
			if value.InstanceId is instanceRef
				false
			else
				true

		MC.canvas_data.component[elbUID].resource.Instances = newInstanceAry

		null

	setAllELBSchemeAsInternal = () ->
		_.each MC.canvas_data.component, (value, key) ->
			if value.type is 'AWS.ELB'
				MC.canvas_data.component[key].resource.Scheme = 'internal'
				MC.canvas.update key, 'image', 'elb_scheme', MC.canvas.IMAGE.ELB_INTERNAL_CANVAS
			null
		null

	addSubnetToELB = ( elb_uid, subnet_uid ) ->
		elb = MC.canvas_data.component[ elb_uid ]

		az_subnet_map = {}

		newSubnetAZ   = MC.canvas_data.component[ subnet_uid ].resource.AvailabilityZone

		subnet_uid = "@" + subnet_uid + ".resource.SubnetId"

		for subnet, i in elb.resource.Subnets
			linkedSubnetID = MC.extractID( subnet )
			linkedSubnet   = MC.canvas_data.component[ linkedSubnetID ]

			if linkedSubnet.resource.AvailabilityZone == newSubnetAZ
				replacedSubnet = linkedSubnetID
				elb.resource.Subnets[i] = subnet_uid

		if not replacedSubnet
			elb.resource.Subnets.push subnet_uid

		replacedSubnet

	removeSubnetFromELB = ( elb_uid, subnet_uid ) ->
		elb = MC.canvas_data.component[ elb_uid ]

		for subnet, i in elb.resource.Subnets
			if subnet.indexOf( subnet_uid ) != -1
				elb.resource.Subnets.splice i, 1
				break

		null

	addRuleToElbSG = (elbUID) ->

		elbComp = MC.canvas_data.component[elbUID]

		elbListenerAry = elbComp.resource.ListenerDescriptions

		listenerAry = []
		_.each elbListenerAry, (listenerObj) ->
			protocol = listenerObj.Listener.Protocol.toLowerCase()
			port = listenerObj.Listener.LoadBalancerPort
			listenerAry.push {
				protocol: protocol,
				port: port
			}
			null
		listenerAry = _.uniq listenerAry

		elbDefaultSG = MC.aws.elb.getElbDefaultSG elbUID
		elbDefaultSGUID = elbDefaultSG.uid
		elbDefaultSGInboundRuleAry = elbDefaultSG.resource.IpPermissions

		_.each listenerAry, (listenerObj) ->
			addListenerToRule = true
			_.each elbDefaultSGInboundRuleAry, (ruleObj) ->
				protocol = ruleObj.IpProtocol
				port = ruleObj.FromPort
				if listenerObj.protocol is protocol and listenerObj.port is port
					addListenerToRule = false
					return
				null

			if addListenerToRule
				elbDefaultSGInboundRuleAry.push {
					FromPort: listenerObj.port,
					ToPort: listenerObj.port,
					IpProtocol: listenerObj.protocol,
					IpRanges: '0.0.0.0/0',
					Groups: [{
						GroupId: '',
						GroupName: '',
						UserId: ''
					}]
				}

			null

		MC.canvas_data.component[elbDefaultSGUID].resource.IpPermissions = elbDefaultSGInboundRuleAry

	getElbDefaultSG = (elbUID) ->

		elbComp = MC.canvas_data.component[elbUID]
		elbName = elbComp.resource.LoadBalancerName
		elbSGName = elbName + '-sg'

		elbSGUID = ''
		allComp = MC.canvas_data.component
		_.each allComp, (compObj) ->
			if compObj.name is elbSGName
				elbSGUID = compObj.uid
				return

		return MC.canvas_data.component[elbSGUID]

	#public
	init                      : init
	addInstanceAndAZToELB     : addInstanceAndAZToELB
	removeInstanceFromELB     : removeInstanceFromELB
	setAllELBSchemeAsInternal : setAllELBSchemeAsInternal
	addSubnetToELB            : addSubnetToELB
	removeSubnetFromELB       : removeSubnetFromELB
	getNewName                : getNewName
	getElbDefaultSG           : getElbDefaultSG
	addRuleToElbSG            : addRuleToElbSG
