$ ->

  toggleNav = (nav, toggle) ->
    if toggle.is(event.target) || (!nav.is(event.target) && nav.hasClass('active'))
      nav.toggleClass('active')
      toggle.toggleClass('hidden')
      $('#page-overlay').toggleClass('show')
      $('#site_bar').toggleClass('nav-toggled')

  $(document).click ->
    toggleNav($('#main-nav'), $('#main-nav-toggle .fa'))
    toggleNav($('#social-nav'), $('#social-nav-toggle .fa'))
