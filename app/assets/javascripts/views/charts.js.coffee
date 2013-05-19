class Jarvis.Views.Charts extends Support.CompositeView
  template: JST['charts']

  render: ->
    @$el.html(@template())
    if @collection.size()
      @renderMonthsChart()
      @renderTagsChart()
    else
      @renderEmptyExpenses()
    this

  renderMonthsChart: ->
    view = new Jarvis.Views.MonthsChart(collection: @collection)
    @renderChildInto view, @$('.months-chart')

  renderTagsChart: ->
    view = new Jarvis.Views.TagsChart(collection: @collection)
    @renderChildInto view, @$('.tags-chart')

  renderEmptyExpenses: ->
    view = new Jarvis.Views.EmptyExpenses()
    @$el.prepend(view.render().el)
