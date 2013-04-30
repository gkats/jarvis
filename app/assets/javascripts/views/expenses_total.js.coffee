class Jarvis.Views.ExpensesTotal extends Support.CompositeView
  template: JST['total']

  attributes:
    class: 'well total'

  render: ->
    @$el.html(@template())
    this

  total: ->
    prices = collectionPrices.call(this)
    res = '-'
    if prices && prices.length
      tot = prices.reduce (sum, price) -> sum + price
      res = tot.toFixed(2) unless isNaN(tot)
    res

  collectionPrices = ->
    _.map(@collection.models, (expense) -> parseFloat(expense.get('price')))