define(['UI.selectize'], function() {
  var initSelection, listenSelectionInserted;
  initSelection = function($valueDom, selectTpl, validationInstance) {
    var create, maxItems, mutil, validHandle, validHandleName;
    if (!$valueDom || !$valueDom.length) {
      return;
    }
    if (!$valueDom.hasClass('selectized')) {
      mutil = false;
      maxItems = void 0;
      if ($valueDom.hasClass('dropdown')) {
        return false;
      }
      if ($valueDom.hasClass('mutil')) {
        mutil = true;
        maxItems = null;
      }
      if ($valueDom.hasClass('bool')) {
        $valueDom.selectize({
          multi: mutil,
          maxItems: maxItems,
          persist: true,
          valueField: 'value',
          labelField: 'text',
          searchField: ['text'],
          create: false,
          openOnFocus: false,
          plugins: ['custom_selection'],
          onInitialize: function() {
            var value;
            value = this.$input.attr('value');
            if (value) {
              this.setValue(value.split(','), true);
            }
            return $valueDom.trigger('selectized', this);
          },
          options: [
            {
              text: 'True',
              value: 'true'
            }, {
              text: 'False',
              value: 'false'
            }
          ],
          render: {
            option: function(item) {
              return '<div>' + item.text + '</div>';
            },
            item: function(item) {
              return '<div>' + item.text + '</div>';
            }
          }
        });
      }
      if ($valueDom.hasClass('option')) {
        create = false;
        validHandleName = $valueDom.data('valid-handle');
        if (validHandleName && selectTpl && selectTpl[validHandleName]) {
          validHandle = selectTpl[validHandleName];
          if (validHandle) {
            create = true;
          }
        }
        $valueDom.selectize({
          multi: mutil,
          maxItems: maxItems,
          persist: true,
          create: create,
          createOnBlur: create,
          openOnFocus: false,
          plugins: ['custom_selection'],
          onInitialize: function() {
            var dataTarget, value;
            value = this.$input.attr('value');
            if (value) {
              this.setValue(value.split(','), true);
            }
            dataTarget = this.$input.attr('data-target');
            if (validationInstance && dataTarget) {
              this.$control_input.attr('data-selection-id', MC.guid());
              this.$control_input.attr('data-target', dataTarget);
              this.$control_input.selectionValid(validationInstance);
            }
            return $valueDom.trigger('selectized', this);
          },
          validHandle: validHandle,
          render: {
            option: function(item) {
              var tplName;
              tplName = this.$input.data('option-tpl');
              if (tplName && selectTpl && selectTpl[tplName]) {
                return selectTpl[tplName].call(this.$input, item);
              } else {
                return '<div>' + item.text + '</div>';
              }
            },
            item: function(item) {
              var tplName;
              tplName = this.$input.data('item-tpl');
              if (tplName && selectTpl && selectTpl[tplName]) {
                return selectTpl[tplName].call(this.$input, item);
              } else {
                return '<div>' + item.text + '</div>';
              }
            },
            button: function() {
              var tplName;
              tplName = this.$input.data('button-tpl');
              if (tplName && selectTpl && selectTpl[tplName]) {
                return selectTpl[tplName].call(this.$input);
              } else {
                return null;
              }
            }
          },
          createFilter: function(value) {
            if (validHandle) {
              return validHandle.call(this.$input, value);
            }
            return false;
          }
        });
      }
      if (validationInstance && $valueDom.is('input, textarea')) {
        $valueDom.attr('data-selection-id', MC.guid());
        return $valueDom.selectionValid(validationInstance);
      }
    }
  };
  listenSelectionInserted = function($parent, selectTpl, validationInstance) {
    return $parent.off('DOMNodeInserted').on('DOMNodeInserted', function(event) {
      var $target;
      $target = $(event.target);
      $target.find('select.selection, input').each(function() {
        return initSelection($(this), selectTpl, validationInstance);
      });
      if (($target[0].nodeName === 'SELECT' || $target[0].nodeName === 'INPUT') && $target.hasClass('.selection')) {
        return initSelection($target, selectTpl, validationInstance);
      }
    });
  };
  listenSelectionInserted.unbind = function($parent, selectTpl) {
    return $parent.unbindSelection();
  };
  return listenSelectionInserted;
});
