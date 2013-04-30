describe 'Jarvis.Views.ExpenseItem', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.ExpenseItem()).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    beforeEach ->
      @date = new Date(2013, 0, 1)
      model = new Backbone.Model(price: 9.0, tag_list: 'tags', date: @date)
      @view = new Jarvis.Views.ExpenseItem(model: model)
      @view.render()
      @$el = $(@view.$el)

    it 'renders a table row', ->
      expect(@$el[0].tagName).toEqual('TR')

    it 'renders table columns', ->
      expect(@$el).toContain('td')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

    it 'renders the expense price with 2 decimal digits', ->
      expect(@$el.text()).toMatch('9.00')

    it 'renders the expense tag list', ->
      expect(@$el.text()).toContain 'tags'

  describe 'events', ->
    it 'edits expense when clicked', ->
      view = new Jarvis.Views.ExpenseItem(model: new Backbone.Model())
      spyOn(view, 'editExpense')
      view.render()
      view.$el.trigger 'click'
      expect(view.editExpense).toHaveBeenCalled()

  describe '#modelDisplayPrice', ->
    it 'returns the model price with two decimal digits', ->
      model = new Backbone.Model(price: 9)
      view = new Jarvis.Views.ExpenseItem(model: model)
      expect(view.modelDisplayPrice()).toEqual('9.00')

  describe '#editExpense', ->
    it 'triggers an expense edit event', ->
      model = new Backbone.Model(price: 9)
      view = new Jarvis.Views.ExpenseItem(model: model)
      spy = spyOn(Jarvis.Services.EventAggregator, 'trigger')
      view.editExpense({})
      expect(spy).toHaveBeenCalledWith('expense:edit', model)