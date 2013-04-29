describe 'Jarvis.Views.ExpensesIndex', ->
  beforeEach ->
    @collection = new Backbone.Collection()
    @view = new Jarvis.Views.ExpensesIndex(collection: @collection)

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders a section with class "expense-form"', ->
      @view.render()
      expect(@view.$el).toContain('.expense-form')

    it 'renders an expense form', ->
      spyOn(@view, 'renderExpenseForm')
      @view.render()
      expect(@view.renderExpenseForm).toHaveBeenCalled()

    it 'renders a section with class "expenses"', ->
      @view.render()
      expect(@view.$el).toContain('.expenses')

    it 'renders the expenses', ->
      spyOn(@view, 'renderExpenses')
      @view.render()
      expect(@view.renderExpenses).toHaveBeenCalled()

    it 'renders preferences', ->
      spy = spyOn(Jarvis.Views, 'Preferences').andReturn(render: -> true)
      @view.render()
      expect(spy).toHaveBeenCalled()

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#renderExpenseForm', ->
    it 'renders the expense form view', ->
      spyOn(Jarvis.Views, 'ExpenseForm').andReturn({})
      spyOn(@view, 'renderChildInto')
      @view.renderExpenseForm()
      expect(Jarvis.Views.ExpenseForm).toHaveBeenCalled()
      expect(@view.renderChildInto).toHaveBeenCalledWith({}, jasmine.any(Object))

  describe '#renderExpenses', ->
    describe 'when there are expenses', ->
      beforeEach ->
        @collection = new Backbone.Collection(new Backbone.Model())
        @view = new Jarvis.Views.ExpensesIndex(collection: @collection)

      it 'renders the expenses view', ->
        spyOn(Jarvis.Views, 'Expenses').andReturn({})
        spyOn(@view, 'renderChildInto')
        @view.renderExpenses()
        expect(Jarvis.Views.Expenses).toHaveBeenCalled()
        expect(@view.renderChildInto).toHaveBeenCalledWith({}, jasmine.any(Object))

    describe 'when there are no expenses', ->
      beforeEach ->
        @collection = new Backbone.Collection()
        @view = new Jarvis.Views.ExpensesIndex(collection: @collection)

      it 'renders the empty expenses view', ->
        spyOn(Jarvis.Views, 'EmptyExpenses').andReturn({})
        spyOn(@view, 'renderChildInto')
        @view.renderExpenses()
        expect(Jarvis.Views.EmptyExpenses).toHaveBeenCalled()
        expect(@view.renderChildInto).toHaveBeenCalledWith({}, jasmine.any(Object))

  describe 'events', ->
    describe 'when a model is added to the collection', ->
      it 're-renders expenses', ->
        collection = new Backbone.Collection()
        view = new Jarvis.Views.ExpensesIndex(collection: collection)
        spy = spyOn(view, 'renderExpenses').andReturn(true)
        collection.add(new Backbone.Model())
        expect(spy).toHaveBeenCalled()

    describe 'when the period interval is changed', ->
      it 'filters expenses', ->
        collection = new Jarvis.Collections.Expenses([])
        view = new Jarvis.Views.ExpensesIndex(collection: collection)
        view.render()
        spy = spyOn(view, 'intervalChanged').andReturn(-> true)
        Jarvis.Services.EventAggregator.trigger('interval:changed', '1')
        expect(spy).toHaveBeenCalled()

    describe 'when the period interval is reset', ->
      it 'resets expenses', ->
        collection = new Jarvis.Collections.Expenses()
        view = new Jarvis.Views.ExpensesIndex(collection: collection)
        view.render()
        spy = spyOn(view, 'intervalReset').andReturn(false)
        Jarvis.Services.EventAggregator.trigger('interval:reset')
        expect(spy).toHaveBeenCalled()

  describe '#intervalChanged', ->
    describe 'when there are 2 expenses in different months', ->
      beforeEach ->
        expenses = [
          new Jarvis.Models.Expense(date: new Date(2013, 1, 1)),
          new Jarvis.Models.Expense(date: new Date(2013, 8, 1))
        ]
        @collection = new Jarvis.Collections.Expenses(expenses)
        @view = new Jarvis.Views.ExpensesIndex(collection: @collection)
        @view.render()
        expect(@view.$('tbody tr').size()).toEqual(2)

      it 'filters expenses', ->
        @view.intervalChanged(from: new Date(2013, 0), to: new Date(2013, 2, 1, 0))
        expect(@view.$('tbody tr').size()).toEqual(1)

  describe '#intervalReset', ->
    beforeEach ->
      expenses = [
        new Jarvis.Models.Expense(date: new Date(2013, 1, 1)),
        new Jarvis.Models.Expense(date: new Date(2013, 8, 1))
      ]
      @collection = new Jarvis.Collections.Expenses(expenses)
      @view = new Jarvis.Views.ExpensesIndex(collection: @collection)
      @view.render()
      @view.intervalChanged(from: new Date(2013, 0), to: new Date(2013, 2, 1, 0))
      expect(@view.$('tbody tr').size()).toEqual(1)

    it 'shows all expenses', ->
      @view.intervalReset()
      expect(@view.$('tbody tr').size()).toEqual(2)