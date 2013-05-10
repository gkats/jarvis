class Jarvis.Views.MonthInterval extends Support.CompositeView
  template: JST['month_interval']

  render: ->
    @$el.html(@template())
    selectCurrentMonth.call(this)
    this

  interval: ->
    Jarvis.Models.Interval.fromMonth(@$('select').val())

  selectCurrentMonth = ->
    @$('select').val(new Date().getMonth() + 1)
