class Jarvis.Models.Expense extends Backbone.Model
  urlRoot: '/api/expenses'

  defaults:
    price: ''
    tag_list: ''
    date: new Date()
    description: ''

  byDate: (date) ->
    new Date(@get('date')).getTime() == date.getTime()