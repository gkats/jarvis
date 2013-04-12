class Jarvis.Routers.ExpensesRouter extends Support.SwappingRouter
  routes:
    '': 'index'

  initialize: (options) ->
    @collection = options.collection
    @el = '#main'

  index: ->
    view = new Jarvis.Views.ExpensesIndex(collection: @collection)
    @swap(view)