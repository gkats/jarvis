describe 'Jarvis.Views.ExpenseForm', ->
  it 'is a composite view', ->
    expect(new Jarvis.Views.ExpenseForm()).toBeInstanceOf(Support.CompositeView)

  it '', ->
    expect('pending').toEqual('completed')