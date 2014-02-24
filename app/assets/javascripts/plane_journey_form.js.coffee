$ ->
  $('#new_plane_journey')

    # When an arrival airport is changed, update the
    # next flight's departure airport to be that airport
    # (unless it's already set to something else).
    .on 'change', '.js-to-airport', (evt) ->
      this_input = $ this
      this_flight = this_input.closest '.flight'
      next_flight = this_flight.next '.flight'
      next_departure_airport_input = next_flight.find '.js-from-airport'
      return if next_departure_airport_input.val()
      next_departure_airport_input.val this_input.val()

    # When a new flight is added, set the departure
    # airport to be the arrival airport that's currently
    # selected on the last existing flight.
    .on 'cocoon:after-insert', (event, insertion) ->
      this_flight = $(insertion).closest '.flight'
      prev_flight = this_flight.prev '.flight'
      prev_arrival_airport_input = prev_flight.find '.js-to-airport'
      this_departure_airport_input = this_flight.find '.js-from-airport'
      this_departure_airport_input.val prev_arrival_airport_input.val()
