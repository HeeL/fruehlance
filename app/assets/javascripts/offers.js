$(document).ready(function(){

  //scroll per item
  $(document).on('click', '.scroll-arrow', function(e){
    next_item = $('.search-result-item[data-num=' + (parseInt($(e.target).parent().data('num')) + 1) + ']');
    scrollTo(0, next_item.offset().top);
    e.preventDefault();
  });

  // Infinite Loading
  var page_num = 1

  if($('#search_results').length > 0) {
    $(window).on('scroll', function(){
      if(loading_hidden() && near_bottom()) {
        $('#items_loading').css('top', $(document).height() - 100);
        $('#items_loading').css('left', $(document).width() / 2);
        if(page_num > 0) {
          $('#items_loading').show();
          load_new_items();
        }
      }
    });
  }

  function load_new_items(){
    $.get(window.location.href + '&page=' + (++page_num), function(data, e) {
      if(data.length < 5) {
        page_num = 0;
        return false;
      }
      $('#search_results').append(data);
    }).complete(function() {
      $('#items_loading').hide();
    });
  }

  function loading_hidden(){
    return $('#items_loading:visible').length == 0;
  }

  function near_bottom(){
    return $(window).scrollTop() > $(document).height() - $(window).height() - 50;
  }

});