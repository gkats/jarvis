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

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#intervalChange', ->
    beforeEach ->
      @intervalSelect = @view.$el.find('#interval')

    describe 'when all time is selected', ->
      beforeEach ->
        @intervalSelect.val('1')

      it 'renders an empty view', ->
        @view.intervalChange()
        expect(@view.$('#interval_span').html()).toEqual('')

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