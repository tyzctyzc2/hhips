$(document).ready(function() {
    var chart = {
       plotBackgroundColor: null,
       plotBorderWidth: null,
       plotShadow: false
    };
    var title = {
      text: 'paper status (total: ' + problemTotal + ')'
    };
    var tooltip = {
      pointFormat: '{series.name}: <b>{point.y}</b>'
    };
    var plotOptions = {
      pie: {
         allowPointSelect: true,
         cursor: 'pointer',
         dataLabels: {
            enabled: true,
            format: '<b>{point.name}%</b>: {point.percentage:.1f} %',
            style: {
               color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
            }
         }
      }
    };
    Highcharts.setOptions({
     colors: ['#008000', '#FFFF00', '#FF0000', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
    });
    var series= [{
      type: 'pie',
      name: 'total',
      data: [{
                name: 'Done',
                y: problemDone,
                color: Highcharts.getOptions().colors[0]
            }, {
                name: 'Never Touch',
                y: problemNotStart,
                color: Highcharts.getOptions().colors[1] // John's color
            }, {
                name: 'Not Pass',
                y: problemNotPass,
                color: Highcharts.getOptions().colors[2] // John's color
            }]
    }];

    var json = {};
    json.chart = chart;
    json.title = title;
    json.tooltip = tooltip;
    json.series = series;
    json.plotOptions = plotOptions;
    $('#container').highcharts(json);
    });