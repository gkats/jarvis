describe 'Jarvis.Views.DailyExpenses', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.DailyExpenses()).toBeInstanceOf(Support.CompositeView)

  describe '#tagName', ->
    it 'is a table', ->
      view = new Jarvis.Views.DailyExpenses()
      expect(view.tagName).toEqual('table')

  describe '#attributes', ->
    it 'has a class of table', ->
      view = new Jarvis.Views.DailyExpenses()
      expect(view.attributes.class).toMatch('table')

  describe '#render', ->
    beforeEach ->
      expenses = [new Backbone.Model(date: new Date(2013, 0, 1), price: 9), new Backbone.Model(date: new Date(2013, 0, 1), price: 9)]
      @collection = new Backbone.Collection(expenses)
      @view = new Jarvis.Views.DailyExpenses(collection: @collection)
      spyOn(@view, 'appendExpense')
      @view.render()
      @$el = $(@view.render().el)

    it 'renders a table', ->
      expect(@$el[0].tagName).toEqual('TABLE')
      expect(@$el).toContain('tbody')

    it 'appends each expense from the collection', ->
      view = new Jarvis.Views.DailyExpenses(collection: @collection)
      spyOn(view, 'appendExpense')
      view.render()
      expect(view.appendExpense.callCount).toEqual(2)

    it 'renders the day in the table header', ->
      expect(@view.$('thead td').text()).toMatch('2013')

    it 'renders the day in the format ddd, dd mmm yyyy', ->
      expect(@$el.text()).toContain 'Tue, 1 Jan 2013'

    it 'renders the total price in the table header', ->
      expect(@view.$('thead td').text()).toMatch('18.00')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#appendExpense', ->
    it 'appends an expense view into the table', ->
      view = new Jarvis.Views.DailyExpenses()
      item =
        render: -> { el: '<tr>expense</tr>' }
      spyOn(Jarvis.Views, 'ExpenseItem').andReturn(item)
      view.$el.append('<tbody></tbody>')
      view.appendExpense({})
      expect(Jarvis.Views.ExpenseItem).toHaveBeenCalled()
      expect(view.$el).toContain('tr')

  describe '#day', ->
    it 'returns the model date in the format ddd, dd mmm yyyy', ->
      date = new Date(2013, 0, 1)
      model = new Backbone.Model(date: date)
      view = new Jarvis.Views.DailyExpenses(collection: new Backbone.Collection(model))
      expect(view.day()).toEqual('Tue, 1 Jan 2013')