/*
#**********************************************************
#* Filename: UI.tabbar
#* Creator: Angel
#* Description: UI.tabbar
#* Date: 20131022
# **********************************************************
# (c) Copyright 2013 Madeiracloud  All Rights Reserved
# **********************************************************
*/
var Tabbar = {
	// Default
	current: 'dashboard',

	mousedown: function (event)
	{
		if (event.which === 1)
		{
			if ($(event.target).hasClass('icon-close'))
			{
				return false;
			}

			if (this.id === 'tab-bar-dashboard')
			{
				Tabbar.open('dashboard');

				return false;
			}

			var target = $(this),
				position = target.position(),
				tab_list = $('#tab-bar li'),
				dragging_tab = target.clone();

			dragging_tab.css({
				'position': 'absolute',
				'left': position.left
			});

			$('#tab-bar ul').append(dragging_tab);
			target.css('visibility', 'hidden');

			$(document.body).append('<div id="overlayer"></div>');

			$(document)
				.on('mousemove', {
					'target': target,
					'dragging_tab': dragging_tab,
					'offset_left': event.pageX - target.offset().left,
					'tab_list': tab_list,
					'tab_width': tab_list.width(),
					'tabbar_offsetLeft': $('#tab-bar').offset().left
				}, Tabbar.mousemove)
				.on('mouseup', {
					'target': target,
					'dragging_tab': dragging_tab
				}, Tabbar.mouseup);

			MC.canvas.volume.close();
			MC.canvas.event.clearList();
		}

		return false;
	},

	mousemove: function (event)
	{
		var left = event.pageX - event.data.offset_left,
			tabbar_offsetLeft = event.data.tabbar_offsetLeft,
			index = Math.round((left - tabbar_offsetLeft) / event.data.tab_width),
			length = event.data.tab_list.length;

		left = left > tabbar_offsetLeft ? left : tabbar_offsetLeft;

		event.data.dragging_tab.css('left', left);

		if (index > 0)
		{
			if (index >= length)
			{
				event.data.tab_list.eq(length - 1).after(event.data.target);
			}
			else
			{
				event.data.tab_list.eq(index).before(event.data.target);
			}
		}

		return false;
	},

	mouseup: function (event)
	{
		event.data.dragging_tab.remove();
		event.data.target.css('visibility', 'visible');

		$('#overlayer').remove();

		$(document).off({
			'mousemove': Tabbar.mousemove,
			'mouseup': Tabbar.mouseup
		});
		//modify by kenshin
		Tabbar.open(event.data.target.attr('id').replace('tab-bar-', ''), event.target.title, event);

		return false;
	},

	add: function (tab_id, tab_name)
	{
		$('#tab-bar ul').append(
			MC.template.tab.item({
				'tab_id': tab_id,
				'tab_name': tab_name
			})
		);

		Tabbar.open(tab_id, tab_name);
		Tabbar.resize($('#tab-bar').width());
		$('#tab-bar').trigger('NEW_TAB', tab_id);

		return tab_id;
	},

	open: function (tab_id, tab_name, event)
	{
		var tab_bar = $('#tab-bar'),
			tab_item = $('#tab-bar-' + tab_id),
			original_tab = $('#tab-bar .active')[0],
			original_tab_id = null;

		//add by kenshin
		if (!original_tab && event)
		{
			tab_bar.find( 'ul' ).append( event.data.target );
			original_tab = $('#tab-bar .active' )[0];
			//tab_item = $('#tab-bar-' + tab_id);
		}

		if (!tab_item[0])
		{
			Tabbar.add(tab_id, tab_name);

			return false;
		}

		if (original_tab)
		{
			original_tab_id = original_tab.id.replace('tab-bar-', '');
		}

		$('#tab-bar li').removeClass('active');
		tab_item.addClass('active');

		tab_bar.trigger('OPEN_TAB', [original_tab_id, tab_id]);

		if (tab_id === 'dashboard')
		{
			scrollbar.scrollTo($('#global-region-wrap'), {'top': 1});

			Tabbar.current = 'dashboard';
		}
		else
		{
			Tabbar.current = tab_id.match(/([A-Za-z0-9])*/ig)[0];
		}

		return tab_id;
	},

	closeTabRestriction : function(event) {
		var target = $(this).parent(),
			tab_name = target.find('a').attr('title').replace(' - stack', ''),
			tab_id = target.attr('id').replace('tab-bar-', '');

		$('#tab-bar').trigger('CLOSE_TAB_RESTRICTION', [ target, tab_name, tab_id ]);
	},

	close: function (event)
	{
		event.stopImmediatePropagation();

		if (event.which === 1 || $(event.currentTarget).hasClass('auto-close') )
		{
			var target = $(this).parent(),
				tab_id = target.attr('id').replace('tab-bar-', '');

			target.remove();
			Tabbar.open($('#tab-bar li:last').attr('id').replace('tab-bar-', ''));

			$('#tab-bar').trigger('CLOSE_TAB', tab_id);
		}

		return false;
	},

	resize: function (tabbar_width)
	{
		var tabs = $('#tab-bar li'),
			tabs_link = $('#tab-bar li a.tab-bar-truncate'),
			tab_item_width = (tabbar_width - (tabs.length * 5)) / tabs.length;

		tab_item_width = tab_item_width > 180 ? 180 : tab_item_width;
		tabs.css('width', tab_item_width);
		tabs_link.css('width', tab_item_width - 20);

		return true;
	}
};

$(document).ready(function ()
{
	$('#tab-bar')
		.on('mousedown', '.close-restriction', Tabbar.closeTabRestriction)
		.on('mousedown', 'li', Tabbar.mousedown)
		.on('click', '.close-tab', Tabbar.close);

	$(window).resize(function ()
	{
		Tabbar.resize($('#tab-bar').width());
	});
});