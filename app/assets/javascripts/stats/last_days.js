$(document).ready(function(){

  function get_days_ago(n){
    var date = new Date();
    date.setDate(date.getDate() - n);
    day = ('0' + date.getDate()).slice(-2)
    month = ('0' + (date.getMonth()+1)).slice(-2) 
    return day + '.' + month;
  }

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
      categories: [
        get_days_ago(7),
        get_days_ago(6),
        get_days_ago(5),
        get_days_ago(4),
        get_days_ago(3),
        get_days_ago(2),
        get_days_ago(1)
      ]
    }
  });
  $.get('/stats/last_days_stats');
});