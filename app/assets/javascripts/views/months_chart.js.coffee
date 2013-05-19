class Jarvis.Views.MonthsChart extends Support.CompositeView
  render: ->
    @renderChart()
    this

  chartColor: '#dd4814'
  chartName: 'Expenses by month'
  monthLabels = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

  renderChart: ->
    self = this
    @chart = @$el.highcharts(
      chart:
        type: 'column'
        inverted: true
      colors: [@chartColor]
      credits:
        enabled: false
      legend:
        enabled: false
      title:
        text: 'Total spent per month'
      subtitle:
        text: 'Click the columns to view statistics for a specific month. Click again to view all months.'
      xAxis:
        categories: labels.call(this)
      yAxis:
        title:
          text: 'Total spent'
      plotOptions:
        column:
          cursor: 'pointer'
          point:
            events:
              click: ->
                if @drilldown
                  setChart.call(self, @drilldown.name, @drilldown.categories, @drilldown.data, @drilldown.color)
                else
                  setChart.call(self, self.chartName, self.labels, self.totalsPerMonth)
      tooltip:
        formatter: ->
          s = "#{@x}: <b>#{@y.toFixed(2)} \u20AC</b><br/>"
          if @point.drilldown then s += 'Click to view analysis per tag' else s += 'Click to return to all months'
          s
      series:[{
        name: @chartName
        data: totalsPerMonth.call(this)
      }]
    ).highcharts()

  setChart = (name, categories, data, color) ->
    @chart.xAxis[0].setCategories(categories, false)
    @chart.series[0].remove(false)
    @chart.addSeries({
      name: name
      data: data
      color: color || @chartColor
    },
    false)
    @chart.redraw()

  categories = ->
    unless @monthCategories && @monthCategories.length
      keys = _.uniq(_.map(@collection.pluck('date'), (date) ->
        d = new Date(date)
        "y#{d.getFullYear()}m#{d.getMonth()}"
      )).sort()
      @monthCategories = _.map(keys, (key) ->
        month = key.match(/m(\d+)$/)[1]
        year = key.match(/^y(\d+)m/)[1]
        { month: month, label: "#{monthLabels[month]} #{year}" }
      )
      @monthCategories = @monthCategories.splice(@monthCategories.length - 12) if @monthCategories.length > 12  # Show back one year only
    @monthCategories

  labels = ->
    @labels = _.map(categories.call(this), (month) -> month['label'])

  months = ->
    _.map(categories.call(this), (month) -> month['month'])

  totalsPerMonth = ->
    @totalsPerMonth = _.map(months.call(this), (month) =>
      { y: totalForMonth.call(this, month), drilldown: drilldownForMonth.call(this, month) }
    )

  totalForMonth = (month) ->
    @collection.byMonth(parseInt(month)).totalPrice()

  drilldownForMonth = (month) ->
    tagCategories = @collection.uniqueTagsForMonth(parseInt(month))
    {
      name: "Expenses by tag for #{month}"
      categories: tagCategories
      data: _.map(tagCategories, (tag) =>
        @collection.byMonth(parseInt(month)).byTags(tag).totalPrice()
      )
      color: @chartColor
    }
