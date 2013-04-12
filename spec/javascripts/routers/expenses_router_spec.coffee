describe 'Jarvis.Routers.ExpensesRouter', ->
  it 'is a swapping router', ->
    expect(new Jarvis.Routers.ExpensesRouter({})).toBeInstanceOf(Support.SwappingRouter)

  describe '#initialize', ->
    it 'stores the collection provided', ->
      data = { collection: 'collection' }
      router = new Jarvis.Routers.ExpensesRouter(data)
      expect(router.collection).toEqual 'collection'

    it 'sets its element to the #main div', ->
      router = new Jarvis.Routers.ExpensesRouter({})
      expect(router.el).toEqual '#main'

  describe '#index', ->
    it 'initializes an expenses index view', ->
      spyOn(Jarvis.Views, 'ExpensesIndex')
      router = new Jarvis.Routers.ExpensesRouter(collection: 'collection')
      spyOn(router, 'swap')
      router.index()
      expect(Jarvis.Views.ExpensesIndex).toHaveBeenCalledWith(collection: 'collection')

    it 'calls the view\'s render method', ->
      view = new Backbone.View()
      spyOn(view, 'render').andReturn { el: 'el' }
      spyOn(Jarvis.Views, 'ExpensesIndex').andReturn view
      router = new Jarvis.Routers.ExpensesRouter(collection: 'collection')
      router.index()
      expect(view.render).toHaveBeenCalled()
