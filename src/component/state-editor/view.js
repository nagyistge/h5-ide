(function() {
  var StateEditorView;

  StateEditorView = Backbone.View.extend({
    el: '#state-editor',
    model: new StateEditorModel(),
    editorHTML: $('#state-template-main').html(),
    paraListHTML: $('#state-template-para-list').html(),
    paraDictItemHTML: $('#state-template-para-dict-item').html(),
    paraArrayItemHTML: $('#state-template-para-array-item').html(),
    paraCompleteItemHTML: '<li data-value="${atwho-at}${name}">${name}</li>',
    events: {
      'keyup .parameter-item.dict .parameter-value': 'onDictInputChange',
      'blur .parameter-item.dict .parameter-value': 'onDictInputBlur',
      'keyup .parameter-item.array .parameter-value': 'onArrayInputChange',
      'blur .parameter-item.array .parameter-value': 'onArrayInputBlur',
      'focus .editable-area': 'onFocusInput'
    },
    initialize: function() {
      this.compileTpl();
      this.initData();
      return this.render();
    },
    render: function() {
      return this.refreshStateList();
    },
    compileTpl: function() {
      this.editorTpl = Handlebars.compile(this.editorHTML);
      Handlebars.registerPartial('state-template-para-list', this.paraListHTML);
      Handlebars.registerPartial('state-template-para-dict-item', this.paraDictItemHTML);
      Handlebars.registerPartial('state-template-para-array-item', this.paraArrayItemHTML);
      this.paraListTpl = Handlebars.compile(this.paraListHTML);
      this.paraDictListTpl = Handlebars.compile(this.paraDictItemHTML);
      return this.paraArrayListTpl = Handlebars.compile(this.paraArrayItemHTML);
    },
    refreshStateList: function() {
      var stateListObj, that;
      that = this;
      stateListObj = {
        state_list: [
          {
            state_id: 1,
            cmd_value: 'apt pkg',
            parameter_list: [
              {
                para_name: 'name',
                type_dict: true,
                required: true,
                para_value: [
                  {
                    key: 'name',
                    value: 'xxx'
                  }, {
                    key: 'abc',
                    value: 'xxx'
                  }
                ]
              }, {
                para_name: 'fromrepo',
                type_array: true,
                required: true,
                para_value: ['qqq', 'qqq', 'qqq']
              }, {
                para_name: 'verify_gpg',
                type_text: true,
                required: true,
                para_value: 'ssh apt@211.98.26.7/pot'
              }, {
                para_name: 'debconf',
                type_line: true,
                required: false,
                para_value: 'what'
              }
            ]
          }
        ]
      };
      that.$el.html(this.editorTpl(stateListObj));
      return that.bindStateListEvent();
    },
    initData: function() {
      var that;
      that = this;
      that.$stateEditor = that.$el;
      that.cmdParaMap = that.model.get('cmdParaMap');
      that.cmdParaObjMap = that.model.get('cmdParaObjMap');
      return that.refObjAry = [
        {
          name: '{host1.privateIP}',
          value: '{host1.privateIP}'
        }, {
          name: '{host1.keyName}',
          name: '{host1.keyName}'
        }, {
          name: '{host2.instanceId}',
          name: '{host1.instanceId}'
        }
      ];
    },
    bindStateListEvent: function() {
      var $stateItems, that;
      that = this;
      that.$stateEditor = that.$el;
      $stateItems = that.$stateEditor.find('.state-item');
      return _.each($stateItems, function(stateItem) {
        var $cmdValueItem, $paraListItem, $stateItem, currentCMD;
        $stateItem = $(stateItem);
        currentCMD = $stateItem.attr('data-command');
        $paraListItem = $stateItem.find('.parameter-list');
        $cmdValueItem = $stateItem.find('.command-value');
        that.bindCommandEvent($cmdValueItem);
        that.bindParaListEvent($paraListItem, currentCMD);
        return null;
      });
    },
    bindCommandEvent: function($cmdValueItem) {
      var cmdNameAry, that;
      that = this;
      cmdNameAry = _.keys(that.cmdParaMap);
      cmdNameAry = _.map(cmdNameAry, function(value, i) {
        return {
          'name': value
        };
      });
      return $cmdValueItem.atwho({
        at: '',
        tpl: that.paraCompleteItemHTML,
        data: cmdNameAry,
        onSelected: function(value) {
          var $paraListElem, $that;
          $that = $(this);
          $that.attr('data-value', value);
          $paraListElem = $that.parent('.state-item').find('.parameter-list');
          return that.refreshParaList($paraListElem, value);
        }
      });
    },
    bindParaListEvent: function($paraListElem, currentCMD) {
      var $paraItemList, currentParaMap, that;
      that = this;
      $paraItemList = $paraListElem.find('.parameter-item');
      currentParaMap = that.cmdParaObjMap[currentCMD];
      return _.each($paraItemList, function(paraItem) {
        var $paraItem, currentParaName, paraObj;
        $paraItem = $(paraItem);
        currentParaName = $paraItem.attr('data-para-name');
        paraObj = currentParaMap[currentParaName];
        that.bindParaItemEvent($paraItem, paraObj);
        return null;
      });
    },
    bindParaItemEvent: function($paraItem, paraObj) {
      var $inputElem, $keyInput, $valueInput, atwhoOption, paraOption, paraOptionAry, paraType, that;
      that = this;
      paraType = paraObj.type;
      paraOption = paraObj.option;
      paraOptionAry = null;
      if (paraOption) {
        if (_.isString(paraOption)) {
          paraOptionAry = [paraOption];
        } else if (_.isArray(paraOption)) {
          paraOptionAry = paraOption;
        }
        paraOptionAry = _.map(paraOptionAry, function(valueStr) {
          return {
            name: valueStr,
            value: valueStr
          };
        });
      }
      if (paraType === 'dict') {
        $keyInput = $paraItem.find('.key');
        $valueInput = $paraItem.find('.value');
        atwhoOption = {
          at: '@',
          tpl: that.paraCompleteItemHTML,
          data: that.refObjAry
        };
        $keyInput.atwho(atwhoOption);
        $valueInput.atwho(atwhoOption);
        if (paraOptionAry) {
          return $valueInput.atwho({
            at: '',
            tpl: that.paraCompleteItemHTML,
            data: paraOptionAry
          });
        }
      } else if (paraType === 'line' || paraType === 'text' || paraType === 'array') {
        $inputElem = $paraItem.find('.parameter-value');
        $inputElem.atwho({
          at: '@',
          tpl: that.paraCompleteItemHTML,
          data: that.refObjAry
        });
        if (paraOptionAry) {
          return $inputElem.atwho({
            at: '',
            tpl: that.paraCompleteItemHTML,
            data: paraOptionAry
          });
        }
      } else if (paraType === 'bool') {
        $inputElem = $paraItem.find('.parameter-value');
        return $inputElem.atwho({
          at: '',
          tpl: that.paraCompleteItemHTML,
          data: [
            {
              name: 'true',
              value: 'true'
            }, {
              name: 'false',
              value: 'false'
            }
          ]
        });
      }
    },
    refreshParaList: function($paraListElem, currentCMD) {
      var currentParaAry, currentParaMap, newParaAry, that;
      that = this;
      currentParaMap = that.cmdParaObjMap[currentCMD];
      currentParaAry = that.cmdParaMap[currentCMD];
      newParaAry = [];
      _.each(currentParaAry, function(paraObj) {
        var newParaObj, _ref;
        newParaObj = {
          para_name: paraObj.name,
          required: paraObj.required
        };
        newParaObj['type_' + paraObj.type] = true;
        if ((_ref = paraObj.type) === 'line' || _ref === 'text' || _ref === 'bool') {
          newParaObj.para_value = '';
        } else if (paraObj.type === 'dict') {
          newParaObj.para_value = [
            {
              key: '',
              value: ''
            }
          ];
        } else if (paraObj.type === 'array') {
          newParaObj.para_value = [''];
        }
        newParaAry.push(newParaObj);
        return null;
      });
      $paraListElem.html(that.paraListTpl({
        parameter_list: newParaAry
      }));
      return that.bindParaListEvent($paraListElem, currentCMD);
    },
    getParaObj: function($inputElem) {
      var $paraItem, $stateItem, currentCMD, currentParaMap, currentParaName, paraObj, that;
      that = this;
      $stateItem = $inputElem.parents('.state-item');
      $paraItem = $inputElem.parents('.parameter-item');
      currentCMD = $stateItem.attr('data-command');
      currentParaName = $paraItem.attr('data-para-name');
      currentParaMap = that.cmdParaObjMap[currentCMD];
      paraObj = currentParaMap[currentParaName];
      return paraObj;
    },
    onDictInputChange: function(event) {
      var $currentDictItemContainer, $currentDictItemElem, $currentInputElem, $keyInput, $valueInput, keyInputValue, newDictItemHTML, nextDictItemElemAry, paraObj, that, valueInputValue;
      that = this;
      $currentInputElem = $(event.currentTarget);
      paraObj = that.getParaObj($currentInputElem);
      $currentDictItemElem = $currentInputElem.parent('.parameter-dict-item');
      nextDictItemElemAry = $currentDictItemElem.next();
      if (!nextDictItemElemAry.length) {
        $currentDictItemContainer = $currentDictItemElem.parents('.parameter-container');
        $keyInput = $currentDictItemElem.find('.key');
        $valueInput = $currentDictItemElem.find('.value');
        keyInputValue = $keyInput.text();
        valueInputValue = $valueInput.text();
        if (keyInputValue) {
          newDictItemHTML = that.paraDictListTpl({
            para_value: [
              {
                key: '',
                value: ''
              }
            ]
          });
          $currentDictItemContainer.append(newDictItemHTML);
          return that.bindParaItemEvent($currentDictItemContainer, paraObj);
        }
      }
    },
    onDictInputBlur: function(event) {
      var $currentDictItemContainer, $currentInputElem, allInputElemAry;
      $currentInputElem = $(event.currentTarget);
      $currentDictItemContainer = $currentInputElem.parents('.parameter-container');
      allInputElemAry = $currentDictItemContainer.find('.parameter-dict-item');
      return _.each(allInputElemAry, function(itemElem, idx) {
        var inputElemAry, isAllInputEmpty;
        inputElemAry = $(itemElem).find('.parameter-value');
        isAllInputEmpty = true;
        _.each(inputElemAry, function(inputElem) {
          if ($(inputElem).text()) {
            isAllInputEmpty = false;
          }
          return null;
        });
        if (isAllInputEmpty && idx !== allInputElemAry.length - 1) {
          $(itemElem).remove();
        }
        return null;
      });
    },
    onArrayInputChange: function(event) {
      var $currentArrayInputContainer, $currentInputElem, currentInput, newArrayItemHTML, nextInputElemAry, paraObj, that;
      that = this;
      $currentInputElem = $(event.currentTarget);
      paraObj = that.getParaObj($currentInputElem);
      nextInputElemAry = $currentInputElem.next();
      if (!nextInputElemAry.length) {
        $currentArrayInputContainer = $currentInputElem.parents('.parameter-container');
        currentInput = $currentInputElem.text();
        if (currentInput) {
          newArrayItemHTML = that.paraArrayListTpl({
            para_value: ['']
          });
          $currentArrayInputContainer.append(newArrayItemHTML);
          return that.bindParaItemEvent($currentArrayInputContainer, paraObj);
        }
      }
    },
    onArrayInputBlur: function(event) {
      var $currentArrayItemContainer, $currentInputElem, allInputElemAry;
      $currentInputElem = $(event.currentTarget);
      $currentArrayItemContainer = $currentInputElem.parents('.parameter-container');
      allInputElemAry = $currentArrayItemContainer.find('.parameter-value');
      return _.each(allInputElemAry, function(itemElem, idx) {
        var inputValue;
        inputValue = $(itemElem).text();
        if (!inputValue && idx !== allInputElemAry.length - 1) {
          $(itemElem).remove();
        }
        return null;
      });
    },
    onFocusInput: function(event) {
      var $currentInput, currentValue, defaultValue, paraObj, that;
      that = this;
      $currentInput = $(event.currentTarget);
      if ($currentInput.hasClass('parameter-value')) {
        currentValue = $currentInput.text();
        paraObj = that.getParaObj($currentInput);
        if (paraObj && paraObj["default"] !== void 0) {
          defaultValue = String(paraObj["default"]);
          if (!currentValue && defaultValue && !$currentInput.hasClass('key')) {
            return $currentInput.html(defaultValue);
          }
        }
      }
    }
  });

  window.StateEditorView = StateEditorView;

}).call(this);
