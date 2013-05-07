class Jarvis.Views.CustomInterval extends Support.CompositeView
  template: JST['custom_interval']

  render: ->
    @$el.html(@template())
    @$('.datepicker').datepicker(format: 'dd/mm/yyyy')
    this

  interval: ->
    from = @$('input[name=from]').data('datepicker').getDate()
    to = @$('input[name=to]').data('datepicker').getDate()
    if from && to
      new Jarvis.Models.Interval(from, to)
    else
      null