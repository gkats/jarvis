class Jarvis.Views.ExpenseForm extends Support.CompositeView
  template: JST['form']

  tagName: 'form'

  attributes:
    'id': 'expense_form'
    'class': 'form well'

  events:
    'submit': 'saveExpense'

  render: ->
    @$el.html(@template(expense: @model))
    @$('input[name=date]').datepicker(format: 'dd/mm/yyyy')
    this

  saveExpense: (e) ->
    e.preventDefault()
    if setModelAttributes.call(this)
      newRecord = @model.isNew()
      @model.save({}, {
        wait: true
        success: => saved.call(this, newRecord)
        error: -> false
      })
    false

  setModelAttributes = ->
    @model.set(
      price: @$('input[name=price]').val()
      tag_list: @$('input[name=tag_list]').val()
      date: @$('input[name=date]').data('datepicker').getDate()
      description: @$('textarea[name=description]').val()
    )

  saved = (newRecord) ->
    @collection.add @model if newRecord
    @model = new Jarvis.Models.Expense()
    @render()

  modelInputDate: ->
    modelDate = @model.escape('date')
    return '' unless modelDate && modelDate.length
    date = new Date(modelDate)
    day = date.getDate()
    month = date.getMonth() + 1
    "#{if day.length > 1 then '' else 0}#{day}/#{if month.length > 1 then '' else 0}#{month}/#{date.getFullYear()}"

  submitText: ->
    if @model.isNew() then 'Add' else 'Save'
