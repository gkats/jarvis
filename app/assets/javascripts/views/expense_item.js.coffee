class Jarvis.Views.ExpenseItem extends Support.CompositeView
  template: JST['item']

  tagName: 'tr'

  render: ->
    @$el.html(@template(expense: @model))
    this

  modelDisplayPrice: ->
    modelPrice = @model.escape('price')
    if modelPrice && modelPrice.length
      parseFloat(modelPrice).toFixed(2)
    else
      ''