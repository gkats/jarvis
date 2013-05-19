class Jarvis.Routers.ReportsRouter extends Support.SwappingRouter
  routes:
    'reports': 'reports'

  initialize: (options) ->
    @collection = options.collection
    @el = '#main'

  reports: ->
    view = new Jarvis.Views.Reports(collection: @collection)
    @swap(view)