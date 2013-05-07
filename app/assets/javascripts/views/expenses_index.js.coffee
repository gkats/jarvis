class Jarvis.Views.ExpensesIndex extends Support.CompositeView
  template: JST['index']

  initialize: ->
    @bindTo(@collection, 'add', @renderExpenses)
    @bindTo(@collection, 'change', @collectionChanged)
    @bindTo(Jarvis.Services.EventAggregator, 'preferences:filter', @filterExpenses)
    @bindTo(Jarvis.Services.EventAggregator, 'expense:edit', @expenseEdit)

  render: ->
    @$el.html(@template())
    @renderExpenseForm()
    @renderExpenses()
    @renderPreferences()
    this

  renderExpenseForm: (model) ->
    model ||= new Jarvis.Models.Expense()
    view = new Jarvis.Views.ExpenseForm(model: model, collection: @collection)
    @renderChildInto(view, @$('.expense-form'))

  renderExpenses: (expenses = @collection) ->
    # when adding, the model is passed here
    expenses = expenses.collection if expenses.collection

    if expenses.size()
      view = new Jarvis.Views.Expenses(collection: expenses)
    else
      view = new Jarvis.Views.EmptyExpenses()
    @renderChildInto(view, @$('.expenses'))

  renderPreferences: ->
    view = new Jarvis.Views.Preferences()
    @renderChildInto(view, @$('.preferences'))

  filterExpenses: (filters) ->
    filtered = @collection
    filtered = filtered.byInterval(filters.interval) if filters.interval
    filtered = filtered.byTags(filters.tags) if filters.tags
    @renderExpenses(filtered)

  expenseEdit: (expense) ->
    @renderExpenseForm(expense)

  collectionChanged: ->
    @renderExpenses()
    @renderPreferences()