describe 'Jarvis.Views.TagsFilter', ->
  beforeEach ->
    @view = new Jarvis.Views.TagsFilter()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders an input', ->
      @view.render()
      expect(@view.$el).toContain('input')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#tags', ->
    it 'returns the value of the tags input', ->
      @view.render()
      @view.$('#tags_filter').val('tags')
      expect(@view.tags()).toEqual('tags')
