class Jarvis.Collections.Expenses extends Jarvis.Collections.FilterableCollection
  model: Jarvis.Models.Expense
  url: '/api/expenses'

  byDate: (date) ->
    @filtered((expense) -> expense.byDate(date))