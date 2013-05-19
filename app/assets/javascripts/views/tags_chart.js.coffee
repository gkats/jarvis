class Jarvis.Views.TagsChart extends Support.CompositeView
  attributes:
    id: 'tags_chart'

  render: ->
    @renderChart()
    this

  renderChart: ->
    @$el.highcharts(chartOptions.call(this))

  chartSeries = ->
    _.map(@collection.uniqueTags(), (tag) =>
      [tag, @collection.byExactTags(tag).totalPrice()]
    )

  chartOptions = ->
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title:
      text: 'Total spent per tag'
    tooltip:
      hideDelay: 10
      formatter: ->
        "#{@point.name}<br/><b>#{@point.y.toFixed(2)} of #{@point.total.toFixed(2)} \u20AC (#{@point.percentage.toFixed(2)} %)</b>"
    plotOptions:
      pie:
        allowPointSelect: true
        cursor: 'pointer'
        dataLabels:
          enabled: true
          color: '#000'
          connectorColor: '#000'
          formatter: ->
            "<b>#{@point.name}</b>: #{@point.y.toFixed(2)} \u20AC"
        tooltip:
          followPointer: false
    series:[
      type: 'pie'
      name: 'Tag totals'
      data: chartSeries.call(this)
    ]
    colors: ['#dd4814', '#5f193e', '#F5F5F5', '#c3325f']
    credits:
      enabled: false