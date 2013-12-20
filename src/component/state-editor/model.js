(function() {
  var StateEditorModel;

  StateEditorModel = Backbone.Model.extend({
    defaults: {
      cmdParaMap: null,
      lookupDataAry: null
    },
    initialize: function() {
      var cmdAry, cmdParaMap, cmdParaObjMap, lookupDataAry;
      cmdAry = [];
      cmdParaMap = {};
      cmdParaObjMap = {};
      _.each(data.linux, function(cmdObj, cmdName) {
        var cmdAllParaAry, paraAryObj;
        cmdAry.push(cmdName);
        paraAryObj = cmdObj.parameter;
        cmdParaMap[cmdName] = [];
        cmdParaObjMap[cmdName] = {};
        _.each(paraAryObj, function(paraObj, paraName) {
          var paraBuildObj;
          paraBuildObj = _.extend(paraObj, {});
          paraBuildObj.name = paraName;
          paraBuildObj['type_' + paraBuildObj.type] = true;
          cmdParaMap[cmdName].push(paraBuildObj);
          cmdParaObjMap[cmdName][paraName] = paraBuildObj;
          return null;
        });
        cmdAllParaAry = cmdParaMap[cmdName];
        cmdParaMap[cmdName] = cmdAllParaAry.sort(function(paraObj1, paraObj2) {
          if (paraObj1.required && !paraObj2.required) {
            return false;
          }
          if (paraObj1.required === paraObj2.required) {
            if (paraObj1.name > paraObj1.name) {
              return false;
            }
          }
          return true;
        });
        return null;
      });
      cmdAry = cmdAry.sort(function(val1, val2) {
        return val1 < val2;
      });
      cmdAry = cmdAry.reverse();
      console.log(cmdAry);
      console.log(cmdParaMap);
      lookupDataAry = _.map(cmdAry, function(elem, idx) {
        return {
          value: elem,
          data: elem
        };
      });
      this.set('cmdParaMap', cmdParaMap);
      this.set('cmdParaObjMap', cmdParaObjMap);
      return this.set('lookupDataAry', lookupDataAry);
    }
  });

  window.StateEditorModel = StateEditorModel;

}).call(this);
