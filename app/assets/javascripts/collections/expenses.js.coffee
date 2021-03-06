class Jarvis.Collections.Expenses extends Jarvis.Collections.FilterableCollection
  model: Jarvis.Models.Expense
  url: '/api/expenses'

  byDate: (date) ->
    @filtered((expense) -> expense.byDate(date))

  byInterval: (interval) ->
    @filtered((expense) -> expense.byInterval(interval))

  byTags: (tags) ->
    @filtered((expense) -> expense.byTags(tags))

  byExactTags: (tags) ->
    @filtered((expense) -> expense.byExactTags(tags))

  byMonth: (month) ->
    @filtered((expense) -> expense.byMonth(month))

  uniqueTags: ->
    _.uniq @pluck('tag_list')

  uniqueTagsForMonth: (month) ->
    @byMonth(month).uniqueTags()

  totalPrice: ->
    @pluck('price').reduce(((sum, price) -> sum + parseFloat(price)), 0)