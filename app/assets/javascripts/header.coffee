$ ->

  shrinkNavbar = ->
    if $(@).scrollTop() > 0
      $('#header').addClass('shrinked')
      if $('#site_bar').length
        $('header#header').addClass('site-bar-scrolled')
    else
      $('#header').removeClass('shrinked')
      if $('#site_bar').length
        $('header#header').removeClass('site-bar-scrolled')

  shrinkNavbar()

  $(window).scroll ->
    shrinkNavbar()
