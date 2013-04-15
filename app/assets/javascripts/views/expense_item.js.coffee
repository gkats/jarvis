class Jarvis.Views.ExpenseItem extends Support.CompositeView
  template: JST['item']

  tagName: 'tr'

  render: ->
    @$el.html(@template(expense: @model))
    this