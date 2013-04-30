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

  describe 'events', ->
    it 'calls intervalChanged when filtering', ->
      spy = spyOn(@view, 'intervalChanged').andReturn(false)
      @view.$('input[name=from]').val('01/01/2013')
      @view.$('input[name=to]').val('01/02/2013')
      @view.$('#filter').trigger('click')
      expect(spy).toHaveBeenCalled()

  describe '#intervalChanged', ->
    it 'triggers an interval change event', ->
      spy = spyOn(Jarvis.Services.EventAggregator, 'trigger').andReturn(true)
      @view.$('input[name=from]').data('datepicker').setDate(new Date(2013, 0, 1))
      @view.$('input[name=to]').data('datepicker').setDate(new Date(2013, 1, 1))
      @view.intervalChanged({})
      interval = new Jarvis.Models.Interval(new Date(2013, 0, 1), new Date(2013, 1, 1))
      expect(spy).toHaveBeenCalledWith('interval:changed', interval)
