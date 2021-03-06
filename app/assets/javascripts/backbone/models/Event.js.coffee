class MeetupApi.Event extends Backbone.RelationalModel
  initialize: (attributes, options) ->
    _.bindAll this, 'updatePossibleDates'

  setEventDates: (eventDates) ->
    @set 'eventDates', eventDates
    eventDates.on 'needsSavePossibleDates', @savePossibleDates, this

  updatePossibleDates: (data) ->
    @set 'participants_number', data.participants_number
    newPossibleDates = data.saved_dates
    _.each newPossibleDates, (possibleDateObj) =>
      eventDate = @get('eventDates').get possibleDateObj.event_date_id
      possibleDates = eventDate.get 'possible_dates'
      possibleDate = possibleDates.get possibleDateObj.id
      if possibleDate?
        possibleDate.set possibleDateObj
      else
        possibleDate = new MeetupApi.PossibleDate(possibleDate)
      possibleDates.set possibleDate, remove: false

  savePossibleDates: (options) ->
    new MeetupApi.BasicSaver(
      keyName: 'possible_dates'
      value: @get('eventDates').getPossibleDates()
      url: "/events/" + @get('id') + "/update_possible_dates"
    ).save options

  toJSON: ->
    attributes = super
    # FIXME: use real data
    attributes.totalHours = 3
    attributes

