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

  describe 'events', ->
    it 'calls monthChanged when filtering by month', ->
      spy = spyOn(@view, 'monthChanged').andReturn(false)
      @view.$('select').val('5')
      @view.$('#filter').trigger('click')
      expect(spy).toHaveBeenCalled()

  describe '#monthChanged', ->
    it 'triggers an interval change event', ->
      spy = spyOn(Jarvis.Services.EventAggregator, 'trigger').andReturn(true)
      @view.$('select').val('0')
      @view.monthChanged({})
      interval = new Jarvis.Models.Interval(new Date(2013, 0, 1), new Date(2013, 0, 31))
      expect(spy).toHaveBeenCalledWith('interval:changed', interval)