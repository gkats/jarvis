class Jarvis.Routers.ExpensesRouter extends Support.SwappingRouter
  initialize: (options) ->
    @collection = options.collection
    @el = '#main'