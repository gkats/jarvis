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

  describe '#byInterval', ->
    it 'filters expenses by an interval', ->
      interval = { from: new Date(2013, 0, 1), to: new Date(2013, 0, 2) }
      model1 = { date: new Date(2013, 0, 1, 12) }
      model2 = { date: new Date(2013, 0, 3) }
      collection = new Jarvis.Collections.Expenses([model1, model2])
      expect(collection.byInterval(interval).size()).toEqual(1)

  describe '#byTags', ->
    it 'filters expenses by tags', ->
      tags = 'gas, food'
      model1 = { tag_list: 'food' }
      model2 = { tag_list: 'drinks' }
      collection = new Jarvis.Collections.Expenses([model1, model2])
      expect(collection.byTags(tags).size()).toEqual(1)