describe 'Jarvis.Views.ExpensesIndex', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.ExpensesIndex()).toBeInstanceOf(Support.CompositeView)

  describe '#render', ->
    it 'renders an expense form', ->
      view = new Jarvis.Views.ExpensesIndex()
      spyOn(view, 'renderExpenseForm')
      view.render()
      expect(view.renderExpenseForm).toHaveBeenCalled()

    it 'returns self', ->
      view = new Jarvis.Views.ExpensesIndex()
      expect(view.render()).toEqual(view)

  describe '#renderExpenseForm', ->
    it 'renders a form', ->
      view = new Jarvis.Views.ExpensesIndex()
      spyOn(Jarvis.Views, 'ExpenseForm').andReturn({})
      spyOn(view, 'renderChildInto')
      view.renderExpenseForm()
      expect(Jarvis.Views.ExpenseForm).toHaveBeenCalled()
      expect(view.renderChildInto).toHaveBeenCalledWith({}, jasmine.any(Object))
