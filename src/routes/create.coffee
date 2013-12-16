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
  paypal.payment.create payment, (error, payment) ->
    if (error)
      console.log(error)
    else
      ...

# exports.create = function (req, res) {
#   var method = req.param('method');
 
#   var payment = {
#     "intent": "sale",
#     "payer": {
#     },
#     "transactions": [{
#       "amount": {
#         "currency": req.param('currency'),
#         "total": req.param('amount')
#       },
#       "description": req.param('description')
#     }]
#   };
 
#   if (method === 'paypal') {
#     payment.payer.payment_method = 'paypal';
#     payment.redirect_urls = {
#       "return_url": "http://yoururl.com/execute",
#       "cancel_url": "http://yoururl.com/cancel"
#     };
#   } else if (method === 'credit_card') {
#     var funding_instruments = [
#       {
#         "credit_card": {
#           "type": req.param('type').toLowerCase(),
#           "number": req.param('number'),
#           "expire_month": req.param('expire_month'),
#           "expire_year": req.param('expire_year'),
#           "first_name": req.param('first_name'),
#           "last_name": req.param('last_name')
#         }
#       }
#     ];
#     payment.payer.payment_method = 'credit_card';
#     payment.payer.funding_instruments = funding_instruments;
#   }
 
#   paypal.payment.create(payment, function (error, payment) {
#     if (error) {
#       console.log(error);
#       res.render('error', { 'error': error });
#     } else {
#       req.session.paymentId = payment.id;
#       res.render('create', { 'payment': payment });
#     }
#   });
# };