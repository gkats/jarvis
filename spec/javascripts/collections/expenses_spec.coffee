describe 'Jarvis.Collections.Expenses', ->
  it 'is a Backbone collection', ->
    expect(new Jarvis.Collections.Expenses()).toBeInstanceOf(Backbone.Collection)

  describe '#model', ->
    it 'is the app\'s expense model', ->
      collection = new Jarvis.Collections.Expenses()
      expect(collection.model).toEqual(Jarvis.Models.Expense)

  describe '#url', ->
    it 'is "/api/expenses"', ->
      collection = new Jarvis.Collections.Expenses()
      expect(collection.url).toEqual('/api/expenses')
