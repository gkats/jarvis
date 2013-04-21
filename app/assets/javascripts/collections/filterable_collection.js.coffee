class Jarvis.Collections.FilterableCollection extends Backbone.Collection
  filtered: (criteriaFunction) ->
    sourceCollection = @
    filteredCollection = new @constructor

    applyFilter = ->
      filteredCollection.reset(sourceCollection.select(criteriaFunction))

    @bind('change', applyFilter)
    @bind('add', applyFilter)
    @bind('remove', applyFilter)

    applyFilter()

    filteredCollection