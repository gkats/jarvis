class Jarvis.Views.ExpensesIndex extends Support.CompositeView
  initialize: ->

  render: ->
    @renderExpenseForm()
    this

  renderExpenseForm: ->
    view = new Jarvis.Views.ExpenseForm()
    @renderChildInto(view, @$('#expense_form'))