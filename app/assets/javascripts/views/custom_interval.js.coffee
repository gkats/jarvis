class Jarvis.Views.CustomInterval extends Support.CompositeView
  template: JST['custom_interval']

  events:
    'click #filter': 'intervalChanged'

  render: ->
    @$el.html(@template())
    @$('.datepicker').datepicker(format: 'dd/mm/yyyy')
    this

  intervalChanged: (e) ->
    from = @$('input[name=from]').data('datepicker').getDate()
    to = @$('input[name=to]').data('datepicker').getDate()
    if from && to
      Jarvis.Services.EventAggregator.trigger('interval:changed',
        new Jarvis.Models.Interval(from, to))
    false
