root = exports ? this

root.Jarvis =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Services: {}

  initialize: (data) ->
    expenses = new Jarvis.Collections.Expenses(data.expenses)
    new Jarvis.Routers.ExpensesRouter(collection: expenses)
    Jarvis.Services.EventAggregator = _.extend({}, Backbone.Events)
    unless Backbone.history.started
      Backbone.history.start(pushState: true)
      Backbone.history.started = true