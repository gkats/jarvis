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