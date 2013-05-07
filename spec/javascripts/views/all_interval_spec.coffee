describe 'Jarvis.Views.AllInterval', ->
  beforeEach ->
    @view = new Jarvis.Views.AllInterval()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders nothing', ->
      @view.render()
      expect(@view.$el.html()).toEqual('')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#interval', ->
    it 'returns null', ->
      expect(@view.interval()).toBeNull()