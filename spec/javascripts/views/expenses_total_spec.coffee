describe 'Jarvis.Views.ExpensesTotal', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.ExpensesTotal()).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    beforeEach ->
      @view = new Jarvis.Views.ExpensesTotal()
      spyOn(@view, 'total').andReturn('18.00')
      @view.render()

    it 'renders the total price of the collection', ->
      expect(@view.$el.text()).toContain('18.00')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

  describe '#total', ->
    describe 'when the collection has two models with prices', ->
      beforeEach ->
        collection = new Backbone.Collection([{ price: 9 }, { price: 9 }])
        @view = new Jarvis.Views.ExpensesTotal(collection: collection)

      it 'returns the price total', ->
        expect(@view.total()).toEqual('18.00')

    describe 'when the collection is empty', ->
      beforeEach ->
        collection = new Backbone.Collection()
        @view = new Jarvis.Views.ExpensesTotal(collection: collection)

      it 'returns \'-\'', ->
        expect(@view.total()).toEqual('-')

    describe 'when the collection models have no price', ->
      beforeEach ->
        collection = new Backbone.Collection([{}, {}])
        @view = new Jarvis.Views.ExpensesTotal(collection: collection)

      it 'returns \'-\'', ->
        expect(@view.total()).toEqual('-')
