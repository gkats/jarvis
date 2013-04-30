class Jarvis.Views.ExpenseItem extends Support.CompositeView
  template: JST['item']

  tagName: 'tr'

  attributes:
    class: 'expense'

  events:
    'click': 'editExpense'

  render: ->
    @$el.html(@template(expense: @model))
    this

  modelDisplayPrice: ->
    modelPrice = @model.escape('price')
    if modelPrice && modelPrice.length
      parseFloat(modelPrice).toFixed(2)
    else
      ''

  editExpense: (e) ->
    Jarvis.Services.EventAggregator.trigger('expense:edit', @model)
    false