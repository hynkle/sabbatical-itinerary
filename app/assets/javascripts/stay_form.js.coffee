# When checkin is changed, update checkout to be one
# day later than checkin (unless it is already later).
$ ->
  moment = window.moment

  checkin_input = $ '#stay_checkin'
  checkout_input = $ '#stay_checkout'

  checkin_input.change (evt) ->
    checkin = moment checkin_input.val()
    checkout = moment checkout_input.val()

    if !checkout.isValid() or checkout <= checkin
      new_checkout = checkin.clone()
      new_checkout.add('days', 1)
      checkout_input.val new_checkout.format('YYYY-MM-DD')
