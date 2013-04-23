describe 'Jarvis.Views.CustomInterval', ->
  beforeEach ->
    @view = new Jarvis.Views.CustomInterval()
    @view.render()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders 2 inputs', ->
      expect(@view.$('input[type=text]').size()).toEqual(2)

    it 'renders a filter button', ->
      expect(@view.$el).toContain('button')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)