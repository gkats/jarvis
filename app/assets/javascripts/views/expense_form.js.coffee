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
      date: createDateFromInput(@$('input[name=date]').val())
      description: @$('textarea[name=description]').val()
    )

  saved = ->
    @collection.add @model
    @model = new Jarvis.Models.Expense()
    @render()

  modelInputDate: ->
    modelDate = @model.escape('date')
    return '' unless modelDate && modelDate.length
    date = new Date(modelDate)
    "#{date.getDate()}/#{date.getMonth() + 1}/#{date.getFullYear()}"

  createDateFromInput = (dateString) ->
    date = ''
    day = dateString.match(/^\d{1,2}/)
    month = dateString.match(/\/\d{1,2}\//)
    year = dateString.match(/\d{4}$/)
    if day && month && year
      date = new Date(year[0], month[0].replace(/\//g, '') - 1, day[0])
    date