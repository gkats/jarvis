describe 'Jarvis.Views.Expenses', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.Expenses()).toBeInstanceOf(Support.CompositeView)

  describe '#tagName', ->
    it 'is a table', ->
      view = new Jarvis.Views.Expenses()
      expect(view.tagName).toEqual('table')

  describe '#attributes', ->
    it 'has a class of table', ->
      view = new Jarvis.Views.Expenses()
      expect(view.attributes.class).toMatch('table')

  describe '#render', ->
    beforeEach ->
      expenses = [new Backbone.Model(), new Backbone.Model()]
      @collection = new Backbone.Collection(expenses)
      @view = new Jarvis.Views.Expenses(collection: @collection)
      spyOn(@view, 'appendExpense')
      @view.render()
      @$el = $(@view.render().el)

    it 'renders a table', ->
      expect(@$el[0].tagName).toEqual('TABLE')
      expect(@$el).toContain('tbody')

    it 'appends each expense from the collection', ->
      view = new Jarvis.Views.Expenses(collection: @collection)
      spyOn(view, 'appendExpense')
      view.render()
      expect(view.appendExpense.callCount).toEqual(2)

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#appendExpense', ->
    it 'appends an expense view into the table', ->
      view = new Jarvis.Views.Expenses()
      item =
        render: -> { el: '<tr>expense</tr>' }
      spyOn(Jarvis.Views, 'ExpenseItem').andReturn(item)
      view.$el.append('<tbody></tbody>')
      view.appendExpense({})
      expect(Jarvis.Views.ExpenseItem).toHaveBeenCalled()
      expect(view.$el).toContain('tr')