alignImage = ->
  if $(window).width() < 992 && $(window).width() > 767
    textHeight = $('#about-us #brief .text').outerHeight()
    $('#about-us #brief .image').css('height', textHeight)
  else
    $('#about-us #brief .image').css('height', 'auto')

alignImage()

$(window).resize ->
  alignImage()
