describe 'Jarvis.Views.ExpenseForm', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.ExpenseForm()).toBeInstanceOf(Support.CompositeView)

  describe '#tagName', ->
    it 'is a form', ->
      expect(new Jarvis.Views.ExpenseForm().tagName).toEqual 'form'

  describe '#render', ->
    beforeEach ->
      @model = new Backbone.Model(price: 9.99, tag_list: 'tags', date: 'a date', description: 'model description')
      @view = new Jarvis.Views.ExpenseForm(model: @model)
      @view.render()
      @$el = $(@view.render().el)[0]

    it 'renders a form with id "expense_form"', ->
      expect(@$el.id).toEqual('expense_form')

    it 'renders an input for price', ->
      expect(@$el).toContain('input[name=price]')
      expect($(@$el).find('input[name=price]').val()).toEqual('9.99')

    it 'renders an input for tags', ->
      expect(@$el).toContain('input[name=tag_list]')
      expect($(@$el).find('input[name=tag_list]').val()).toEqual('tags')

    it 'renders an input for date', ->
      expect(@$el).toContain('input[name=date]')
      expect($(@$el).find('input[name=date]').val()).toEqual('a date')

    it 'renders a text area for description', ->
      expect(@$el).toContain('textarea[name=description]')
      expect($(@$el).find('textarea[name=description]').val()).toEqual('model description')

    it 'renders a submit button', ->
      expect(@$el).toContain('button[type=submit]')