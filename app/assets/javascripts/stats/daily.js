$(document).ready(function(){
  daily_chart = new Highcharts.Chart({
    chart: {
      type: 'line',
      renderTo: 'daily_chart'
    },
    title: {
      text: 'Average count of jobs posted in each day of the week'
    },
    yAxis: {
      title: {
        text: null
      },
      min: 0
    },
    xAxis: {
      categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }
  });
  $.get('/stats/daily_stats');
});