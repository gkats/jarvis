describe 'Jarvis.Collections.Expenses', ->
  it 'is a filterable collection', ->
    expect(new Jarvis.Collections.Expenses()).toBeInstanceOf(Jarvis.Collections.FilterableCollection)

  describe '#model', ->
    it 'is the app\'s expense model', ->
      collection = new Jarvis.Collections.Expenses()
      expect(collection.model).toEqual(Jarvis.Models.Expense)

  describe '#url', ->
    it 'is "/api/expenses"', ->
      collection = new Jarvis.Collections.Expenses()
      expect(collection.url).toEqual('/api/expenses')

  describe '#byDate', ->
    it 'filters expenses by a certain date', ->
      date1 = new Date(2013, 0, 1)
      model1 = { date: date1 }
      model2 = { date: new Date(2012, 0, 1) }
      collection = new Jarvis.Collections.Expenses([model1, model2])
      expect(collection.byDate(date1).size()).toEqual(1)