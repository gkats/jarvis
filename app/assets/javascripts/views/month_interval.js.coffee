class Jarvis.Views.MonthInterval extends Support.CompositeView
  template: JST['month_interval']

  render: ->
    @$el.html(@template())
    this

  interval: ->
    Jarvis.Models.Interval.fromMonth(@$('select').val())