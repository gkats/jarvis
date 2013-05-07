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
        spy = spyOn(view, 'filterExpenses').andReturn(-> true)
        Jarvis.Services.EventAggregator.trigger('preferences:filter', '1')
        expect(spy).toHaveBeenCalled()

    describe 'when an expense is selected for editing', ->
      it 'edits the expense', ->
        collection = new Jarvis.Collections.Expenses()
        view = new Jarvis.Views.ExpensesIndex(collection: collection)
        view.render()
        spy = spyOn(view, 'expenseEdit').andReturn(-> false)
        Jarvis.Services.EventAggregator.trigger('interval:reset')
        expect(spy).toHaveBeenCalled()

  describe '#filterExpenses', ->
    describe 'when there are two expenses in different months with different tags', ->
      beforeEach ->
        expenses = [
          new Jarvis.Models.Expense(date: new Date(2013, 1, 1), tag_list: 'food'),
          new Jarvis.Models.Expense(date: new Date(2013, 8, 1), tag_list: 'gas')
        ]
        @collection = new Jarvis.Collections.Expenses(expenses)
        @view = new Jarvis.Views.ExpensesIndex(collection: @collection)
        @view.render()
        expect(@view.$('tbody tr').size()).toEqual(2)

    describe 'when an interval is present', ->
      beforeEach ->
        @filters = { interval: new Jarvis.Models.Interval(new Date(2013, 0), new Date(2013, 2, 1, 0)) }

      it 'filters expenses by date', ->
        @view.filterExpenses(@filters)
        expect(@view.$('tbody tr').size()).toEqual(1)

    describe 'when no interval is present', ->
      beforeEach ->
        @filters = {}

      it 'renders all expenses', ->
        @view.filterExpenses(@filters)
        expect(@view.$('tbody tr').size()).toEqual(2)

    describe 'when tags are present', ->
      beforeEach ->
        @filters = { tags: 'food' }

      it 'filters expenses by tag', ->
        @view.filterExpenses(@filters)
        expect(@view.$('tbody tr').size()).toEqual(1)

    describe 'when interval and tags are present', ->
      beforeEach ->
        @filters =
          interval: new Jarvis.Models.Interval(new Date(2013, 0), new Date(2013, 2, 1, 0))
          tags: 'food'

      it 'filters expenses by interval and tags', ->
        @view.filterExpenses(@filters)
        expect(@view.$('tbody tr').size()).toEqual(1)

  describe '#expenseEdit', ->
    it 'populates the form with the expense for editing', ->
      expenses = [
        new Jarvis.Models.Expense(price: '9.99', date: new Date(), tag_list: '', description: ''),
        new Jarvis.Models.Expense(price: '2.00')
      ]
      @collection = new Jarvis.Collections.Expenses(expenses)
      @view = new Jarvis.Views.ExpensesIndex(collection: @collection)
      @view.render()
      @view.expenseEdit(expenses[0])
      expect(@view.$('input[name=price]').val()).toEqual('9.99')

  describe '#collectionChanged', ->
    it 'renders expenses', ->
      spy = spyOn(@view, 'renderExpenses').andReturn(true)
      @view.collectionChanged()
      expect(spy).toHaveBeenCalled()

    it 'renders preferences', ->
      spyOn(@view, 'renderExpenses').andReturn(true)
      spy = spyOn(@view, 'renderPreferences').andReturn(true)
      expect(spy).toHaveBeenCalled()