describe 'Jarvis.Views.MonthInterval', ->
  beforeEach ->
    @view = new Jarvis.Views.MonthInterval()
    @view.render()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders a select', ->
      expect(@view.$el).toContain('select')

    it 'renders all months as options', ->
      expect(@view.$('select option').size()).toEqual(12)

    it 'renders a filter button', ->
      expect(@view.$el).toContain('button')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)