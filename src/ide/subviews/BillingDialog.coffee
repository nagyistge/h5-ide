#############################
#  View(UI logic) for dialog
#############################

define [ "./BillingDialogTpl", 'i18n!/nls/lang.js', "ApiRequest", "UI.modalplus" ,"backbone" ], ( BillingDialogTpl, lang, ApiRequest, Modal ) ->

    BillingDialog = Backbone.View.extend {

      events :
        "click #PaymentNav span"              : "switchTab"
        'click #PaymentBody a.payment-receipt': "viewPaymentReceipt"
        "click .btn.btn-xlarge"               : "_bindPaymentEvent"

      initialize : ()->
        that = @
        paymentState = App.user.get("paymentState")
        @modal = new Modal
          title: lang.ide.PAYMENT_SETTING_TITLE
          width: "650px"
          template: MC.template.loadingSpiner
          confirm: hide: true
          delay: 1
        if  paymentState is "unpay"
          App.user.getPaymentInfo().then (result)=>
            @modal.setContent BillingDialogTpl.noPaymentCard result
          , ()->
            notification 'error', "Error while getting user payment info, please try again later."
        else
          Q.all([App.user.getPaymentUpdate(),App.user.getPaymentStatement(), App.user.getPaymentUsage()]).spread (paymentUpdate, paymentHistory, paymentUsage)->
            that.modal.find(".modal-body").css 'padding', "0"
            hasPaymentHistory = (_.keys paymentHistory).length
            _.each paymentHistory, (e)->
              e.ending_balance = e.ending_balance_in_cents/100
              e
            that.paymentHistory = _.clone paymentHistory
            that.modal.setContent BillingDialogTpl.billingTemplate {paymentUpdate, paymentHistory, paymentUsage, hasPaymentHistory}
          , ()->
            notification 'error', "Error while getting user payment info, please try again later."
        @setElement @modal.tpl
      switchTab: (event)->
        target = $(event.currentTarget)
        console.log "Switching Tabs"
        @modal.find("#PaymentNav").find("span").removeClass("selected")
        @modal.find(".tabContent > section").addClass("hide")
        $("#"+ target.addClass("selected").data('target')).removeClass("hide")

      viewPaymentReceipt: (event)->
        $target = $(event.currentTarget)
        id = $target.parent().parent().data("id")
        console.log id
        paymentHistory = @paymentHistory[id]
        console.log paymentHistory
        makeNewWindow = ()->
          newWindow = window.open("", "")
          newWindow.focus()
          content = paymentHistory.html
          newWindow.document.write(content)
          newWindow.document.close()
        makeNewWindow()

      _bindPaymentEvent: (modal)->
        that = @
        @modal.setTitle lang.ide.PAYMENT_LOADING_BILLING
        @modal.setContent MC.template.loadingSpiner()
        App.WS.once 'userStateChange', (idx, dag)->
          paymentState = dag.payment_state
          App.user.set('paymentState', paymentState)
          console.log paymentState
          if paymentState is 'active'
            that.modal.close()
            window.setTimeout ()->
              that._renderBillingDialog()
            , 2

      _renderBillingDialog: ->
        new BillingDialog()
  }


    BillingDialog
