class Jarvis.Models.Interval
  constructor: (from, to) ->
    @from = from
    @to = to

  @fromMonth: (month) ->
    year = calculateYear(month - 1)
    new this new Date(year, month - 1), new Date(year, month, 0)

  calculateYear = (month) ->
    current = new Date().getFullYear()
    if new Date().getMonth() >= month then current else current - 1