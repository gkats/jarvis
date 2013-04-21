class Jarvis.Views.ExpenseItem extends Support.CompositeView
  template: JST['item']

  tagName: 'tr'

  render: ->
    @$el.html(@template(expense: @model))
    this

  modelDisplayDate: ->
    modelDate = @model.escape('date')
    return '' unless modelDate && modelDate.length
    date = new Date(modelDate)
    "#{dayNames[date.getDay()]}, #{date.getDate()} #{monthNames[date.getMonth()]} #{date.getFullYear()}"

  monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  dayNames = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat']