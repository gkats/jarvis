class Jarvis.Views.DailyExpenses extends Support.CompositeView
  template: JST['daily']

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

  day: ->
    modelDisplayDate @collection.models[0]

  total: ->
    sum = _.reduce(@collection.models, ((sum, expense) -> sum + parseFloat(expense.get('price'))), 0)
    sum.toFixed(2)

  modelDisplayDate = (model) ->
    modelDate = model.escape('date')
    return '' unless modelDate && modelDate.length
    date = new Date(modelDate)
    "#{dayNames[date.getDay()]}, #{date.getDate()} #{monthNames[date.getMonth()]} #{date.getFullYear()}"

  monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  dayNames = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat']