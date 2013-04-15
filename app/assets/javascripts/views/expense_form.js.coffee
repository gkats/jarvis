class Jarvis.Views.ExpenseForm extends Support.CompositeView
  template: JST['form']

  tagName: 'form'

  attributes:
    'id': 'expense_form'

  events:
    'submit': 'saveExpense'

  initialize: ->

  render: ->
    @$el.html(@template(expense: @model))
    this

  saveExpense: (e) ->
    e.preventDefault()
    if setModelAttributes.call(this)
      @model.save({}, {
        wait: true
        success: => saved.call(this)
        error: ->
      })
    false

  setModelAttributes = ->
    @model.set(
      price: @$('input[name=price]').val()
      tag_list: @$('input[name=tag_list]').val()
      date: @$('input[name=date]').val()
      description: @$('textarea[name=description]').val()
    )

  saved = ->
    @collection.add @model
    @model = new Jarvis.Models.Expense()
    @render()
