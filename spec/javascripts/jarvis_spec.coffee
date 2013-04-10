describe 'Jarvis App', ->
  it 'has a namespace for Models', ->
    expect(Jarvis.Models).toBeTruthy()

  it 'has a namespace for Collections', ->
    expect(Jarvis.Collections).toBeTruthy()

  it 'has a namespace for Views', ->
    expect(Jarvis.Views).toBeTruthy()

  it 'has a namespace for Routers', ->
    expect(Jarvis.Routers).toBeTruthy()

  describe '#initialize', ->
    it 'instantiates a collection out of received data', ->
      data = { expenses: [{ price: 9.99 }, { price: 8.99 }] }
      spyOn(Jarvis.Collections, 'Expenses')
      Jarvis.initialize(data)
      expect(Jarvis.Collections.Expenses).toHaveBeenCalledWith(data.expenses)

    it 'instantiates an expenses router', ->
      spyOn(Jarvis.Routers, 'ExpensesRouter')
      Jarvis.initialize({})
      expect(Jarvis.Routers.ExpensesRouter).toHaveBeenCalled()

    it 'starts Backbone.history', ->
      Backbone.history.started = null
      Backbone.history.stop()
      spyOn(Backbone.history, 'start')
      Jarvis.initialize({})
      expect(Backbone.history.start).toHaveBeenCalled()