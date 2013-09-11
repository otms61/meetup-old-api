class Scheduler
  webSocketPath: 'localhost:3000/websocket'


  constructor: (eventContent, eventDates) ->
    @event = new MeetupApi.Event eventContent
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @event.setEventDates @eventDates
    @schedulerView = new MeetupApi.SchedulerView({ collection: @eventDates })
    @heatMapView = new MeetupApi.HeatMapView()

    @initWSConnection()
    @initView()

  initView: () ->
    $('#title > h1').text @event.get('name')

  initWSConnection: () ->
    @dispatcher = new WebSocketRails(@webSocketPath)
    @channel = @dispatcher.subscribe("event-#{@event.get 'id'}");
    @channel.bind 'update', @heatMapView.handleUpdate


new Scheduler App.eventContent, App.eventDates
