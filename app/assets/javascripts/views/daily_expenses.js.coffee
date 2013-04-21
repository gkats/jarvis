class Jarvis.Views.DailyExpenses extends Support.CompositeView
  template: JST['expenses']

  tagName: 'table'

  attributes:
    class: 'table table-hover'

  render: ->
    @$el.html(@template())
    @collection.each(@appendExpense) if @collection.length
    this

  appendExpense: (expense) =>
    view = new Jarvis.Views.ExpenseItem(model: expense)
    @$('tbody').append(view.render().el)
