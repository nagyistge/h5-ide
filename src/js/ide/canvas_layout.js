
// [ Warning!!!! ] DEAD CODE
// This source code is dead. listen() / ready() / connect() seems like doing nothing.
// But it pollutes the window object. Which makes it un-removable !!!!
// Dom Ready
var listen = function ()
{
	var canvas_state = MC.canvas.getState(),
		canvas_container = $('#canvas_container');

	MC.paper = Canvon('#svg_canvas');

	canvas_container
		.off('.CANVAS_EVENT')
		.removeClass('canvas_state_app canvas_state_appedit canvas_state_stack');

	if (canvas_state === 'app')
	{
		canvas_container
			.addClass('canvas_state_' + canvas_state)
			.on('mousedown.CANVAS_EVENT', '.instance-volume, .instanceList-item-volume', MC.canvas.volume.show)
			.on('click.CANVAS_EVENT', '.line', MC.canvas.event.selectLine)
			.on('mousedown.CANVAS_EVENT', MC.canvas.event.clearSelected)
			.on('mousedown.CANVAS_EVENT', '#svg_canvas', MC.canvas.event.clickBlank)
			.on('mouseenter.CANVAS_EVENT mouseleave', '.node', MC.canvas.event.nodeHover)
			.on('selectstart.CANVAS_EVENT', returnFalse)
			.on('mousedown.CANVAS_EVENT', '.node-launchconfiguration-label', MC.canvas.asgList.show)
			.on('mousedown.CANVAS_EVENT', '.AWS-EC2-Instance', MC.canvas.instanceList.show)
			.on('mousedown.CANVAS_EVENT', '.AWS-VPC-NetworkInterface', MC.canvas.eniList.show)
			.on('mousedown.CANVAS_EVENT', '.dragable', MC.canvas.event.selectNode)
			.on('mousedown.CANVAS_EVENT', MC.canvas.event.ctrlMove.mousedown);
	}

	if (canvas_state === 'appedit')
	{
		canvas_container
			.addClass('canvas_state_' + canvas_state)
			.on('mousedown.CANVAS_EVENT', '.instance-volume, .instanceList-item-volume', MC.canvas.volume.show)
			//.on('mousedown.CANVAS_EVENT', '.dragable', MC.canvas.event.appMove)
			.on('mousedown.CANVAS_EVENT', '.dragable', MC.canvas.event.dragable.mousedown)
			
			.on('mousedown.CANVAS_EVENT', '.group-resizer', MC.canvas.event.groupResize.mousedown)
			.on('click.CANVAS_EVENT', '.line', MC.canvas.event.selectLine)
			.on('mousedown.CANVAS_EVENT', MC.canvas.event.clearSelected)
			.on('mousedown.CANVAS_EVENT', '#svg_canvas', MC.canvas.event.clickBlank)
			.on('mouseenter.CANVAS_EVENT mouseleave', '.node', MC.canvas.event.nodeHover)
			.on('selectstart.CANVAS_EVENT', returnFalse)
			// .on('mousedown.CANVAS_EVENT', '.node-launchconfiguration-label', MC.canvas.asgList.show)
			// .on('mousedown.CANVAS_EVENT', '.AWS-EC2-Instance', MC.canvas.instanceList.show)
			// .on('mousedown.CANVAS_EVENT', '.AWS-VPC-NetworkInterface', MC.canvas.eniList.show)
			.on('mousedown.CANVAS_EVENT', MC.canvas.event.ctrlMove.mousedown);
	}

	if (canvas_state === 'stack')
	{
		canvas_container
			.addClass('canvas_state_' + canvas_state)
			.on('mousedown.CANVAS_EVENT', '.port', MC.canvas.event.drawConnection.mousedown)
			.on('mousedown.CANVAS_EVENT', '.dragable', MC.canvas.event.dragable.mousedown)
			.on('mousedown.CANVAS_EVENT', '.group-resizer', MC.canvas.event.groupResize.mousedown)
			.on('mouseenter.CANVAS_EVENT mouseleave', '.node', MC.canvas.event.nodeHover)
			.on('click.CANVAS_EVENT', '.line', MC.canvas.event.selectLine)
			.on('mousedown.CANVAS_EVENT', MC.canvas.event.clearSelected)
			.on('mousedown.CANVAS_EVENT', '#svg_canvas', MC.canvas.event.clickBlank)
			.on('selectstart.CANVAS_EVENT', returnFalse)
			.on('mousedown.CANVAS_EVENT', MC.canvas.event.ctrlMove.mousedown);
	}

	$('#tab-content-design').on('click', '#canvas-panel, #resource-panel', MC.canvas.volume.close);
};

// Dom Ready
var canvas_initialize = function ()
{
	$(document).on('keydown', MC.canvas.event.keyEvent);

	$('#header, #navigation, #tab-bar').on('click', MC.canvas.volume.close);

	$('#tab-content-design').on('mousedown', '.resource-item', MC.canvas.event.siderbarDrag.mousedown);

	$(document.body)
		.on('mousedown', '#instance_volume_list a', MC.canvas.volume.mousedown);

};

// Dom Ready
var connect = function ()
{

};

define( ['jquery'], function() {
	return {
		'listen'     : listen,
		'canvas_initialize' : canvas_initialize,
		'connect'    : connect
	};
});
