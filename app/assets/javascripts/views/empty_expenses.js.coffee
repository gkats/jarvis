class Jarvis.Views.EmptyExpenses extends Support.CompositeView
  template: JST['empty']

  tagName: 'p'

  attributes:
    class: 'expenses-empty'

  render: ->
    @$el.html(@template())
    this