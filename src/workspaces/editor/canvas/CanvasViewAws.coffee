
define [ "./CanvasBundle", "constant", "i18n!/nls/lang.js" ], ( CanvasView, constant, lang )->

  AwsCanvasView = CanvasView.extend {
    recreateStructure : ()->
      @svg.clear().add([
        @svg.group().classes("layer_vpc")
        @svg.group().classes("layer_az")
        @svg.group().classes("layer_line")
        @svg.group().classes("layer_subnet")
        @svg.group().classes("layer_asg")
        @svg.group().classes("layer_sgline")
        @svg.group().classes("layer_node")
      ])
      return

    appendVpc    : ( svgEl )-> @__appendSvg(svgEl, ".layer_vpc")
    appendAz     : ( svgEl )-> @__appendSvg(svgEl, ".layer_az")
    appendSubnet : ( svgEl )-> @__appendSvg(svgEl, ".layer_subnet")
    appendAsg    : ( svgEl )-> @__appendSvg(svgEl, ".layer_asg")
    appendSgline : ( svgEl )-> @__appendSvg(svgEl, ".layer_sgline")

    fixConnection : ( coord, initiator, target )->
      if target.type is constant.RESTYPE.ELB and ( initiator.type is constant.RESTYPE.INSTANCE or initiator.type is constant.RESTYPE.LC )
        if coord.x < target.pos().x + target.size().width / 2
          toPort = "elb-sg-out"
        else
          toPort = "elb-sg-in"

      else if target.type is constant.RESTYPE.ASG or target.type is "ExpandedAsg"
        target = target.getLc()
        if target then target = @getItem( target.id )

      {
        toPort : toPort
        target : target
      }

    errorMessageForDrop : ( type )->
      switch type
        when constant.RESTYPE.VOL       then return lang.ide.CVS_MSG_WARN_NOTMATCH_VOLUME
        when constant.RESTYPE.SUBNET    then return lang.ide.CVS_MSG_WARN_NOTMATCH_SUBNET
        when constant.RESTYPE.INSTANCE  then return lang.ide.CVS_MSG_WARN_NOTMATCH_INSTANCE_SUBNET
        when constant.RESTYPE.ENI       then return lang.ide.CVS_MSG_WARN_NOTMATCH_ENI
        when constant.RESTYPE.RT        then return lang.ide.CVS_MSG_WARN_NOTMATCH_RTB
        when constant.RESTYPE.ELB       then return lang.ide.CVS_MSG_WARN_NOTMATCH_ELB
        when constant.RESTYPE.CGW       then return lang.ide.CVS_MSG_WARN_NOTMATCH_CGW
        when constant.RESTYPE.ASG       then return lang.ide.CVS_MSG_WARN_NOTMATCH_ASG
  }

  AwsCanvasView
