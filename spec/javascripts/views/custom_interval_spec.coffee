describe 'Jarvis.Views.CustomInterval', ->
  beforeEach ->
    @view = new Jarvis.Views.CustomInterval()
    @view.render()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders 2 inputs', ->
      expect(@view.$('input[type=text]').size()).toEqual(2)

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#interval', ->
    describe 'when both dates are selected', ->
      beforeEach ->
        @view.$('input[name=from]').data('datepicker').setDate(new Date(2013, 0, 1))
        @view.$('input[name=to]').data('datepicker').setDate(new Date(2013, 1, 1))

      it 'returns an interval from those values', ->
        interval = new Jarvis.Models.Interval(new Date(2013, 0, 1), new Date(2013, 1, 1))
        expect(@view.interval()).toEqual(interval)
