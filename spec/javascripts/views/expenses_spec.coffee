describe 'Jarvis.Views.Expenses', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.Expenses()).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    beforeEach ->
      model1 = { date: new Date(2013, 0, 1) }
      model2 = { date: new Date(2012, 0, 1) }
      collection = new Jarvis.Collections.Expenses([model1, model2])
      @view = new Jarvis.Views.Expenses(collection: collection)
      @view.render()

    it 'renders daily expense views', ->
      expect(@view.$('table').length).toEqual(2)

    it 'renders a total view', ->
      spy = spyOn(Jarvis.Views, 'ExpensesTotal').andReturn(render: -> true)
      @view.render()
      expect(spy).toHaveBeenCalled()

    it 'renders preferences', ->
      spy = spyOn(Jarvis.Views, 'Preferences').andReturn(render: -> true)
      @view.render()
      expect(spy).toHaveBeenCalled()

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#appendDailyExpenses', ->
    it 'renders a daily expense view', ->
      collection = new Jarvis.Collections.Expenses()
      view = new Jarvis.Views.Expenses(collection: collection)
      spyOn(Jarvis.Views, 'DailyExpenses').andReturn({ render: -> true })
      view.appendDailyExpenses(view.collection)
      expect(Jarvis.Views.DailyExpenses).toHaveBeenCalled()