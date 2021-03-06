define ['constant'], (constant) ->

    DiffTree = (option) ->

        option = {} if not option

        if not option.filterAttrMap

            option.filterAttrMap = {
                '*.type': true
                '*.uid': true
                # '*.name': true
                '*.index': true
                '*.number': true
                '*.serverGroupUid': true
                '*.serverGroupName': true
                # '*.state': true
                '*.resource.UserData': true
                '*.resource.PrivateIpAddressSet.n.AutoAssign': true,
                '*.resource.AssociatePublicIpAddress': true,
                '*.resource.KeyName': true,
                '*.resource.AssociationSet.n.RouteTableAssociationId': true
                '*.resource.AssociationSet.n.NetworkAclAssociationId': true
                '*.resource.BlockDeviceMapping': true
                '*.resource.VolumeSize': true
                '*.resource.GroupDescription': true
                '*.resource.ListenerDescriptions.n.Listener.SSLCertificateId' : true
                '*.resource.Attachment.AttachmentId': true
                # DBINSTANCE
                # 'DBINSTANCE.resource.Iops': true
                # 'DBINSTANCE.resource.MasterUserPassword': true
                'DBINSTANCE.resource.DBName': true
                'DBINSTANCE.resource.AvailabilityZone': true
                'DBINSTANCE.resource.Endpoint.Address': true
                'DBINSTANCE.resource.ApplyImmediately': true
                'DBINSTANCE.resource.Endpoint': true
                'DBINSTANCE.resource.SourceDBInstanceIdentifierForPoint': true
                'DBINSTANCE.resource.UseLatestRestorableTime': true
                'ASG.resource.AutoScalingGroupARN': true
                'ASG.resource.PolicyARN': true
                # 'VOL.resource.AttachmentSet.Device': true

                '*.resource.Tags': true #SG,ACL,RT

                # For openstack
                '*.resource.adminPass': true
                '*.resource.key_name': true
                '*.resource.bootable': true

                # For asg tag
                "TAG.resource.n.PropagateAtLaunch": true
            }

        if not option.noDiffArrayAttrMap

            option.noDiffArrayAttrMap = {
                '*.state': true,
                '*.resource.TerminationPolicies': true
                # '*.resource.RouteSet': true
            }

        option.filterResMap = {}

        isArray = (value) ->

            return value and typeof value is 'object' and value.constructor is Array

        typeofReal = (value) ->

            if isArray(value) then 'array' else (if value is null then 'null' else typeof(value))

        getType = (value) ->

            if (typeA is 'object' or typeA is 'array') then '' else String(a) + ' '

        _diffAry = (a, b) ->

            for v, i in ([0...a.length])
                for v, j in ([0...b.length])
                    if not _compare.call(this, a, b, a[i], b[j], '', null, [])
                        tmp = b[i]
                        b[i] = b[j]
                        b[j] = tmp

        _compare = (pA, pB, a, b, key, path, resultJSON) ->

            # hack for ASG key VPCZoneIdentifier
            if key is 'VPCZoneIdentifier'

                aAry = a.split(',')
                bAry = b.split(',')
                aAry = _.map aAry, (ref) ->
                    return $.trim(ref)
                bAry = _.map bAry, (ref) ->
                    return $.trim(ref)

                a = aAry
                b = bAry

            attrPathStr = ''

            if path

                path = path.concat([key]) if key

                # ignore resource of specified type
                path[1] = a.type if path.length is 2 and a and a.type

                # ignore resource of specified in filterAttrMap
                if path.length > 2

                    attrPathAry = path.slice(2)
                    attrPathAry = _.map attrPathAry, (path) ->
                        num = Number(path)
                        return 'n' if num >= 0
                        return path

                    resType = path[1]
                    resShortType = this.resTypeShortMap[resType]

                    attrPathStr = attrPathAry.join('.')
                    attrPath1 = resShortType + '.' + attrPathStr
                    attrPath2 = '*.' + attrPathStr

                    return if (option.filterAttrMap[attrPath1] or option.filterAttrMap[attrPath2])

                    # ignore for visualops tag
                    if attrPath1 is "TAG.resource.n.Value" or
                        attrPath1 is "ASGTAG.resource.n.Value" or
                        attrPath2 is "TAG.resource.n.Value" or
                        attrPath2 is "ASGTAG.resource.n.Value"
                            return if (pA and pA.Key is 'visualops') and (pB and pB.Key is 'visualops')

            if not a and not b
                return

            haveDiff = false

            typeA = typeofReal(a)
            typeB = typeofReal(b)

            aString = if (typeA is 'object' or typeA is 'array') then '' else String(a) + ''
            bString = if (typeB is 'object' or typeB is 'array') then '' else String(b) + ''

            aString = '' if not aString
            bString = '' if not bString

            changeType = value1 = value2 = ''

            if a is undefined
                changeType = 'added'
                value2 = bString

            else if b is undefined
                changeType = 'removed'
                value1 = aString

            else if (typeA isnt typeB or (typeA isnt 'object' and typeA isnt 'array' and a isnt b))
                changeType = 'changed'
                value1 = aString
                value2 = bString

            else
                value1 = aString

            resultJSON[key] = {}

            if typeA is 'object' or typeA is 'array' or typeB is 'object' or typeB is 'array'

                # process array diff
                if typeA is 'array' and typeB is 'array'

                    # ignore array diff of specified in noDiffArrayAttrMap
                    if (not attrPath2 or (attrPath2 and not option.noDiffArrayAttrMap[attrPath2]))

                        diffAryResult = {}

                        if a.length < b.length
                            _diffAry.call(this, a, b)
                        else
                            _diffAry.call(this, b, a)

                keys = []
                for v of a
                    keys.push(v)
                for v of b
                    keys.push(v)
                keys.sort()

                isEqual = true

                for v, i in keys

                    if (keys[i] is keys[i - 1])
                        continue

                    hasDiff = _compare.call(this, a, b, a and a[keys[i]], b and b[keys[i]], keys[i], path, resultJSON[key])

                    if hasDiff
                        isEqual = false

                haveDiff = not isEqual
                if isEqual
                    delete resultJSON[key]

            else

                path.length = 0 if path

                # ignore number type diff

                if typeofReal(a) is 'number'
                    a = String(a)

                if typeofReal(b) is 'number'
                    b = String(b)

                if typeofReal(a) is 'boolean'
                    a = String(a)

                if typeofReal(b) is 'boolean'
                    b = String(b)

                if a isnt b
                    haveDiff = true
                    resultJSON[key] = {
                        type: changeType
                        __old__: a,
                        __new__: b
                    }
                else
                    delete resultJSON[key]

            return haveDiff

        this.compare = (json1, json2) ->

            resultJSON = {}
            _compare.call(this, json1, json2, json1, json2, 'result', [], resultJSON)
            return resultJSON.result

        null

    DiffTree.prototype.resTypeShortMap = _.invert(constant.RESTYPE)

    return DiffTree
