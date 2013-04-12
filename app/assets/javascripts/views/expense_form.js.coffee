class Jarvis.Views.ExpenseForm extends Support.CompositeView
  template: JST['form']

  tagName: 'form'

  attributes:
    'id': 'expense_form'

  initialize: ->

  render: ->
    @$el.html(@template(expense: @model))
    this