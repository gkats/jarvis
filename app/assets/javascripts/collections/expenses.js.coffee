class Jarvis.Collections.Expenses extends Jarvis.Collections.FilterableCollection
  model: Jarvis.Models.Expense
  url: '/api/expenses'

  byDate: (date) ->
    @filtered((expense) -> expense.byDate(date))

  byInterval: (interval) ->
    @filtered((expense) -> expense.byInterval(interval))

  byTags: (tags) ->
    @filtered((expense) -> expense.byTags(tags))

  byMonth: (month) ->
    @filtered((expense) -> expense.byMonth(month))

  uniqueTags: ->
    _.uniq @pluck('tag_list')

  uniqueTagsForMonth: (month) ->
    # TODO 'band,rehearsal' and 'rehearsal,band' are not unique tags
    @byMonth(month).uniqueTags()

  totalPrice: ->
    @pluck('price').reduce(((sum, price) -> sum + parseFloat(price)), 0)