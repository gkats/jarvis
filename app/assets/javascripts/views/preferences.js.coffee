class Jarvis.Views.Preferences extends Support.CompositeView
  template: JST['preferences']

  events:
    'change #interval': 'intervalChange'

  render: ->
    @$el.html(@template())
    populateSelectOptions.call(this)
    this

  populateSelectOptions = ->
    options = [$('<option>', value: 1, text: 'All time'),
    $('<option>', value: 2, text: 'Pick a month'),
    $('<option>', value: 3, text: 'Pick interval')]
    @$el.find('select[name=interval]').append(options)

  intervalChange: ->
    value = @.$('#interval').val()
    if value == '1'
      @renderChildInto({render: -> ''}, @.$('#interval_span'))
    else
      if value == '2'
        view = new Jarvis.Views.MonthInterval()
      else if value == '3'
        view = new Jarvis.Views.CustomInterval()
      @renderChildInto(view, @.$('#interval_span'))