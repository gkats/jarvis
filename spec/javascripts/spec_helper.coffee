beforeEach ->
  @addMatchers(
    toBeInstanceOf: (expected) ->
      actual = @actual
      notText = if @isNot then ' not' else ''
      @message = ->
        "Expected #{actual}#{notText} to be an instance of #{expected}"
      actual instanceof expected
  )