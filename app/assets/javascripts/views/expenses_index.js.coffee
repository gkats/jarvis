class Jarvis.Views.ExpensesIndex extends Support.CompositeView
  template: JST['index']

  initialize: ->
    @bindTo(@collection, 'add', @renderExpenses)

  render: ->
    @$el.html(@template())
    @renderExpenseForm()
    @renderExpenses()
    this

  renderExpenseForm: ->
    view = new Jarvis.Views.ExpenseForm(model: new Jarvis.Models.Expense(), collection: @collection)
    @renderChildInto(view, @$('.expense-form'))

  renderExpenses: ->
    if @collection.size()
      view = new Jarvis.Views.Expenses(collection: @collection)
    else
      view = new Jarvis.Views.EmptyExpenses()
    @renderChildInto(view, @$('.expenses'))
