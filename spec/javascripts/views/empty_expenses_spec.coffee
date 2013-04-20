describe 'Jarvis.Views.EmptyExpenses', ->
  beforeEach ->
    @view = new Jarvis.Views.EmptyExpenses()

  it 'is a composite view', ->
    expect(@view).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders a paragraph with class "expenses-empty"', ->
      @view.render()
      expect(@view.$el[0].tagName).toEqual('P')
      expect(@view.$el[0].className).toEqual('expenses-empty')

    it 'returns self', ->
      expect(@view.render()).toEqual(@view)