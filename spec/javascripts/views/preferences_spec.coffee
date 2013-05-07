describe 'Jarvis.Views.Preferences', ->
  beforeEach ->
    @view = new Jarvis.Views.Preferences()
    @view.render()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders a select', ->
      expect(@view.$el).toContain('select')

    it 'has options to show all time, month or interval', ->
      options = @view.$('select option')
      expect(options.size()).toEqual(3)
      expect(o.text).toMatch(/time|month|interval/) for o in options

    it 'renders an empty interval span div', ->
      expect(@view.$el.html()).toContain('interval_span')
      expect(@view.$('#interval_span').html()).toEqual('')

    it 'renders an input', ->
      expect(@view.$el.html()).toContain('input')

    it 'renders a filter button', ->
      expect(@view.$el).toContain('button')

    it 'renders a reset link', ->
      expect(@view.$el).toContain('a')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#intervalChange', ->
    beforeEach ->
      @intervalSelect = @view.$el.find('#interval')

    describe 'when all time is selected', ->
      beforeEach ->
        @intervalSelect.val('1')
        @spy = spyOn(Jarvis.Services.EventAggregator, 'trigger')

      it 'renders an empty view', ->
        @view.intervalChange()
        expect(@view.$('#interval_span').html()).toEqual('<div></div>')

    describe 'when pick a month is selected', ->
      beforeEach ->
        @intervalSelect.val('2')

      it 'renders a month view', ->
        spy = spyOn(Jarvis.Views, 'MonthInterval').andReturn(render: -> true)
        @view.intervalChange()
        expect(spy).toHaveBeenCalled()

    describe 'when custom interval is selected', ->
      beforeEach ->
        @intervalSelect.val('3')

      it 'renders a custom interval view', ->
        spy = spyOn(Jarvis.Views, 'CustomInterval').andReturn(render: -> true)
        @view.intervalChange()
        expect(spy).toHaveBeenCalled()

  describe 'when filter button is clicked', ->
    it 'filters expenses', ->
      spy = spyOn(@view, 'filter').andReturn(true)
      @view.$('button').click()
      expect(spy).toHaveBeenCalled()

  describe '#filter', ->
    it 'triggers a preferences:filter event', ->
      spy = spyOn(Jarvis.Services.EventAggregator, 'trigger').andReturn(true)
      interval = 'interval'
      tags = 'tags'
      @view.filter()
      expect(spy).toHaveBeenCalledWith('preferences:filter', { interval: interval, tags: tags })

  describe 'when reset button is clicked', ->
    it 'resets all filters', ->
      expect('pending').toEqual('completed')