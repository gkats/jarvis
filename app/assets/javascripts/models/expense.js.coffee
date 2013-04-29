class Jarvis.Models.Expense extends Backbone.Model
  urlRoot: '/api/expenses'

  defaults:
    price: ''
    tag_list: ''
    date: new Date()
    description: ''

  byDate: (date) ->
    new Date(@get('date')).getTime() == date.getTime()

  byInterval: (interval) ->
    from = interval.from.getTime()
    to = interval.to.getTime()
    expenseDate = new Date(@get('date')).getTime()
    from <= expenseDate <= to