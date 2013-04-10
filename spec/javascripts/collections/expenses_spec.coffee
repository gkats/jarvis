describe 'Jarvis.Collections.Expenses', ->
  it 'is a Backbone collection', ->
    expect(new Jarvis.Collections.Expenses()).toBeInstanceOf(Backbone.Collection)

  describe '#initialize', ->
    it '', ->
      expect('pending').toEqual('completed')
