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

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe 'submitting', ->
    beforeEach ->
      @model = new Backbone.Model()
      @model.url = '/foo'
      @collection = new Backbone.Collection()
      @view = new Jarvis.Views.ExpenseForm(model: @model, collection: @collection)
      @view.render()

    it 'saves an expense', ->
      spyOn(@view.model, 'save')
      @view.$el.submit()
      expect(@view.model.save).toHaveBeenCalled()

    it 'maps model attributes', ->
      fillInFormData.call(this)
      spyOn(@view.model, 'save')
      @view.$el.submit()
      expect(@view.model.get('price')).toEqual '9.99'
      expect(@view.model.get('tag_list')).toEqual 'tags'
      expect(@view.model.get('description')).toEqual 'an expense'
      expect(@view.model.get('date')).not.toBeNull()

    fillInFormData = ->
      @view.$('input[name=price]').val('9.99')
      @view.$('input[name=tag_list]').val('tags')
      @view.$('textarea[name=description]').val('an expense')

    describe 'with invalid data', ->
      it 'does not add the expense to the collection', ->
        @server = sinon.fakeServer.create()
        createErrorResponse.call(this)
        @view.$el.submit()
        @server.respond()
        expect(@view.collection.length).toEqual(0)

    describe 'with valid data', ->
      beforeEach ->
        @server = sinon.fakeServer.create()
        createSuccessResponse.call(this)

      it 'creates a new model', ->
        spyOn(Jarvis.Models, 'Expense')
        @view.$el.submit()
        @server.respond()
        expect(Jarvis.Models.Expense).toHaveBeenCalled()

      it 'resets the form', ->
        fillInFormData.call(this)
        @view.$el.submit()
        @server.respond()
        expect(@view.$('input[name=price]').val()).toEqual('')

      it 'adds the expense to the collection', ->
        expect(@view.collection.length).toEqual(0)
        @view.$el.submit()
        @server.respond()
        expect(@view.collection.length).toEqual(1)

    createSuccessResponse = ->
      @server.respondWith([201,
        { 'Content-Type': 'application/json', 'Content-Length': 2 }, '{"text": "ok"}'
      ])

    createErrorResponse = ->
      @server.respondWith([500,
      { 'Content-Type': 'application/json', 'Content-Length': 5 }, '{"text": "error"}'
      ])