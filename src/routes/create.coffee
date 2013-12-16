paypal.payment.create(payment, (error, payment) ->
  if (error)
    console.log(error)
  else
    if(payment.payer.payment_method is 'paypal')
      req.session.paymentId = payment.id;
      redirectUrl;
      i = 0
      while i < payment.links.length
        i++
        link = payment.links[i];
        if (link.method is 'REDIRECT')
          redirectUrl = link.href
      res.redirect(redirectUrl)


module.exports = (req, res) ->
  payment = ...
  paypal.payment.create(payment, (error, payment) ->
    if (error)
      console.log(error)
    else
      ...
