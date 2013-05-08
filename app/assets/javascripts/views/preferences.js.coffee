class Jarvis.Views.Preferences extends Support.CompositeView
  template: JST['preferences']

  initialize: ->
    @bindTo(Jarvis.Services.EventAggregator, 'expenses:changed', @filter)

  events:
    'change #interval': 'intervalChange'
    'click #filter': 'filter'
    'form submit': 'filter'

  render: ->
    @$el.html(@template())
    populateSelectOptions.call(this)
    @renderTagsFilter()
    this

  populateSelectOptions = ->
    options = [$('<option>', value: 1, text: 'All time'),
    $('<option>', value: 2, text: 'Pick a month'),
    $('<option>', value: 3, text: 'Pick interval')]
    @$('select[name=interval]').append(options)

  intervalChange: ->
    value = @.$('#interval').val()
    if value == '1'
      @intervalView = new Jarvis.Views.AllInterval()
    else if value == '2'
      @intervalView = new Jarvis.Views.MonthInterval()
    else if value == '3'
      @intervalView = new Jarvis.Views.CustomInterval()
    @renderChildInto(@intervalView, @$('#interval_span'))

  renderTagsFilter: ->
    @tagsView = new Jarvis.Views.TagsFilter()
    @renderChildInto(@tagsView, @$('#tags_filter_container'))

  filter: ->
    Jarvis.Services.EventAggregator.trigger('preferences:filter',
      { interval: @intervalView.interval(), tags: @tagsView.tags() })
    false
