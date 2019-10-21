$('#blog-sidebar').affix
  offset: {
    top: 15,
    bottom: 200 }

$(window).scroll ->
  if $(@).scrollTop() > 600
    $('#blog-sidebar #posts').slideDown(500)
