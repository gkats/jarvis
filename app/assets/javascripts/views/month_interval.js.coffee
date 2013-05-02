class Jarvis.Views.MonthInterval extends Support.CompositeView
  template: JST['month_interval']

  events:
    'click #filter': 'monthChanged'

  render: ->
    @$el.html(@template())
    this

  monthChanged: (e) ->
    month = @.$('select').val()
    Jarvis.Services.EventAggregator.trigger('interval:changed', Jarvis.Models.Interval.fromMonth(month))
    false
