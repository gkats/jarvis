class Jarvis.Views.Preferences extends Support.CompositeView
  template: JST['preferences']

  TIME_FILTERS =
    all: '1'
    month: '2'
    custom: '3'

  initialize: ->
    @bindTo(Jarvis.Services.EventAggregator, 'expenses:changed', @filter)

  events:
    'change #interval': 'intervalChange'
    'click #filter': 'filter'
    'form submit': 'filter'
    'click #filter_reset': 'filterReset'

  render: ->
    @$el.html(@template())
    populateSelectOptions.call(this)
    @renderTagsFilter()
    showCurrentMonth.call(this)
    this

  populateSelectOptions = ->
    options = [$('<option>', value: 1, text: 'All time'),
    $('<option>', value: 2, text: 'Pick a month'),
    $('<option>', value: 3, text: 'Pick interval')]
    @$('select[name=interval]').append(options)

  intervalChange: ->
    value = @$('#interval').val()
    if value == TIME_FILTERS.all
      @intervalView = new Jarvis.Views.AllInterval()
    else if value == TIME_FILTERS.month
      @intervalView = new Jarvis.Views.MonthInterval()
    else if value == TIME_FILTERS.custom
      @intervalView = new Jarvis.Views.CustomInterval()
    @renderChildInto(@intervalView, @$('#interval_span'))

  renderTagsFilter: ->
    @tagsView = new Jarvis.Views.TagsFilter()
    @renderChildInto(@tagsView, @$('#tags_filter_container'))

  filter: ->
    Jarvis.Services.EventAggregator.trigger('preferences:filter',
      { interval: @intervalView.interval(), tags: @tagsView.tags() })
    false

  showCurrentMonth = ->
    @$('#interval').val(TIME_FILTERS.month)
    @intervalChange()
    @filter()

  filterReset: ->
    @$('#interval').val(TIME_FILTERS.all)
    @intervalChange()
    @renderTagsFilter()
    @filter()
