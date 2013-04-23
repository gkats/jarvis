class Jarvis.Views.CustomInterval extends Support.CompositeView
  template: JST['custom_interval']

  render: ->
    @$el.html(@template())
    this