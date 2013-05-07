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

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#interval', ->
    it 'returns the month interval', ->
      @view.$('select').val('0')
      interval = new Jarvis.Models.Interval(new Date(2013, 0, 1), new Date(2013, 0, 31))
      expect(@view.interval()).toEqual(interval)
