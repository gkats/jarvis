class Jarvis.Models.Expense extends Backbone.Model
  urlRoot: '/api/expenses'

  defaults:
    price: ''
    tag_list: ''
    date: new Date()
    description: ''