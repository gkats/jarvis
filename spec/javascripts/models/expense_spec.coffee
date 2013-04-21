describe 'Jarvis.Models.Expense', ->
  it 'is a backbone model', ->
    expect(new Jarvis.Models.Expense()).toBeInstanceOf(Backbone.Model)

  describe '#urlRoot', ->
    it 'points to the api for the collection', ->
      model = new Jarvis.Models.Expense()
      expect(model.urlRoot).toEqual('/api/expenses')

  describe '#defaults', ->
    beforeEach ->
      @expense = new Jarvis.Models.Expense()

    it 'has a blank price', ->
      expect(@expense.get('price')).toEqual('')

    it 'has a blank tag list', ->
      expect(@expense.get('tag_list')).toEqual('')

    it 'sets the current date', ->
      date = new Date()
      expect(@expense.get('date')).toMatch(date.getFullYear())
      expect(@expense.get('date')).toMatch(date.getMonth())
      expect(@expense.get('date')).toMatch(date.getDate())

    it 'has a blank description', ->
      expect(@expense.get('description')).toEqual('')

  describe '#byDate', ->
    describe 'when the expense date equals the given date', ->
      beforeEach ->
        @date = new Date()
        @expense = new Jarvis.Models.Expense(date: @date)

      it 'returns true', ->
        expect(@expense.byDate(@date)).toEqual(true)

    describe 'when the expense date does not equal the given date', ->
      beforeEach ->
        @date = new Date()
        @expense = new Jarvis.Models.Expense(date: new Date(2012, 0, 1))

      it 'returns false', ->
        expect(@expense.byDate(@date)).toEqual(false)