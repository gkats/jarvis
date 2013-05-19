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

  byTags: (tags) ->
    own_tags = @get('tag_list').split(', ')
    own_tags.length != _.difference(own_tags, tags.split(', ')).length

  byExactTags: (tags) ->
    @get('tag_list') == tags

  byMonth: (month) ->
    month == new Date(@get('date')).getMonth()