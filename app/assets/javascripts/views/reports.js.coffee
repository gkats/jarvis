class Jarvis.Views.Reports extends Support.CompositeView
  template: JST['reports']

  initialize: ->
    @bindTo(Jarvis.Services.EventAggregator, 'preferences:filter', @filterCollection)

  render: ->
    @$el.html(@template())
    @renderPreferences()
    this

  renderPreferences: ->
    view = new Jarvis.Views.Preferences()
    @renderChildInto view, @$('.preferences')

  filterCollection: (filters) ->
    filtered = @collection
    filtered = filtered.byInterval(filters.interval) if filters.interval
    filtered = filtered.byTags(filters.tags) if filters.tags
    @renderCharts(filtered)

  renderCharts: (collection) ->
    view = new Jarvis.Views.Charts(collection: collection)
    @renderChildInto view, @$('.charts')