class Jarvis.Views.TagsFilter extends Support.CompositeView
  template: JST['tags_filter']

  render: ->
    @$el.html(@template())
    this

  tags: ->
    @$('#tags_filter').val()