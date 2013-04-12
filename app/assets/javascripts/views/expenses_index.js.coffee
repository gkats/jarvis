class Jarvis.Views.ExpensesIndex extends Support.CompositeView
  template: JST['index']

  initialize: ->

  render: ->
    @$el.html(@template())
    @renderExpenseForm()
    this

  renderExpenseForm: ->
    view = new Jarvis.Views.ExpenseForm(model: new Jarvis.Models.Expense())
    @renderChildInto(view, $('#expense_form'))