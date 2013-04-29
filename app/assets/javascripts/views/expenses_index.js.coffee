class Jarvis.Views.ExpensesIndex extends Support.CompositeView
  template: JST['index']

  initialize: ->
    @bindTo(@collection, 'add', @renderExpenses)
    @bindTo(Jarvis.Services.EventAggregator, 'interval:changed', @intervalChanged)
    @bindTo(Jarvis.Services.EventAggregator, 'interval:reset', @intervalReset)

  render: ->
    @$el.html(@template())
    @renderExpenseForm()
    @renderExpenses()
    @renderPreferences()
    this

  renderExpenseForm: ->
    view = new Jarvis.Views.ExpenseForm(model: new Jarvis.Models.Expense(), collection: @collection)
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

  intervalChanged: (interval) ->
    filteredCollection = @collection.byInterval(interval)
    @renderExpenses(filteredCollection)

  intervalReset: ->
    @renderExpenses()