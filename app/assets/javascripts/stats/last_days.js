$(document).ready(function(){
  last_days_chart = new Highcharts.Chart({
    chart: {
      type: 'column',
      renderTo: 'last_days_chart'
    },
    title: {
      text: 'Count of jobs posted in the last days'
    },
    yAxis: {
      title: {
        text: null
      },
      min: 0
    },
    xAxis: {
      categories: [1,2,3,4,5,6,7]
    }
  });
  $.get('/stats/last_days_stats');
});