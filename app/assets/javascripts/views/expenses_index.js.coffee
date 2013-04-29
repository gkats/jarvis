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
    if expenses.size()
      view = new Jarvis.Views.Expenses(collection: expenses)
    else
      view = new Jarvis.Views.EmptyExpenses()
    @renderChildInto(view, @$('.expenses'))

  renderPreferences: ->
    view = new Jarvis.Views.Preferences()
    @$el.append(view.render().el)

  intervalChanged: (interval) ->
    filteredCollection = @collection.byInterval(interval)
    @renderExpenses(filteredCollection)

  intervalReset: ->
    @renderExpenses()