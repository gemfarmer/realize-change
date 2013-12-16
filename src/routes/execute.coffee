module.exports = (req, res) ->
  paymentId = req.session.paymentId
  payerId = req.param('PayerID')
 
  details = { "payer_id": payerId }
  paypal.payment.execute(paymentId, details, (error, payment) ->
    if (error)
      console.log(error)
    else
      res.send("Success")