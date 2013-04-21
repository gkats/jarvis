class Jarvis.Views.Expenses extends Support.CompositeView
  render: ->
    collectionDates = @collection.map((expense) -> new Date(expense.get('date')))
    days = _.sortBy(collectionDates, (date) -> date)
    for day in _.uniq(days, true, (day) -> day.getTime()).reverse()
      @appendDailyExpenses(@collection.byDate(day))
    this

  appendDailyExpenses: (dailyCollection) =>
    view = new Jarvis.Views.DailyExpenses(collection: dailyCollection)
    @$el.append(view.render().el)