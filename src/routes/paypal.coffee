paypal = require('paypal-rest-sdk')
configPaypal = {}

exports.init = (c) ->
  configPaypal = c
  paypal.configure(c.api)
