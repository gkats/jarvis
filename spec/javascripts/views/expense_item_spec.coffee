describe 'Jarvis.Views.ExpenseItem', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.ExpenseItem()).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    beforeEach ->
      model = new Backbone.Model(price: 9.99, tag_list: 'tags', date: 'a date')
      @view = new Jarvis.Views.ExpenseItem(model: model)
      @view.render()
      @$el = $(@view.$el)

    it 'renders a table row', ->
      expect(@$el[0].tagName).toEqual('TR')

    it 'renders table columns', ->
      expect(@$el).toContain('td')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)

    it 'renders the expense price', ->
      expect(@$el.text()).toMatch('9.99')

    it 'renders the expense tag list', ->
      expect(@$el.text()).toContain 'tags'

    it 'renders the expense date', ->
      expect(@$el.text()).toContain 'date'

