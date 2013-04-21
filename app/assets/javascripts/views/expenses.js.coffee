class Jarvis.Views.Expenses extends Support.CompositeView
  render: ->
    @renderDailyExpenses()
    this

  renderDailyExpenses: ->
    for day in uniqueDays.call(this)
      @appendDailyExpenses(@collection.byDate(day))

  appendDailyExpenses: (dailyCollection) =>
    view = new Jarvis.Views.DailyExpenses(collection: dailyCollection)
    @$el.append(view.render().el)

  uniqueDays = ->
    _.uniq(sortedDays.call(this), true, (day) ->
      day.setHours(0,0,0,0)
      day.getTime()
    )

  sortedDays = ->
    collectionDates = @collection.map((expense) -> new Date(expense.get('date')))
    _.sortBy(collectionDates, (date) -> date).reverse()
