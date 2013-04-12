describe 'Jarvis.Models.Expense', ->
  it 'is a backbone model', ->
    expect(new Jarvis.Models.Expense()).toBeInstanceOf(Backbone.Model)