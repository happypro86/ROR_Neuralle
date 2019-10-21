$(document).ready ->

  ### GENERAL ###

  # Set active tiles and icons
  setActiveTilesAndIcons = ->
    $('#pricing radio:checked').closest('.package-tile').addClass('active')
    $('#pricing input:checked').closest('label').addClass('active')
  setActiveTilesAndIcons()

  # Send subscription type form on click and update button
  $('#frequency-selector form').on 'change', ->
    $(@).submit()

  $('#frequency-selector .frequency-tile').on 'click', ->
    $(@).closest("#frequency-selector").find(".frequency-tile").removeClass("active")
    $(@).addClass("active")

  # Update prices and stages and re-enable forms on package and subscription change
  $(document).ajaxSuccess (event, xhr, settings) ->
    if settings.url.includes('orders') || settings.url.includes('reset_order') || settings.url.includes('brief_request')
      enableSliders()
      setActiveTilesAndIcons()
      updateSliderHandles()


  ### SLIDERS ###

  # Enable sliders
  enableSliders = ->
    $('#pricing .product-slider').slider()
  enableSliders()

  # Update slider handles quantity on load
  updateSliderHandles = ->
    $("#pricing .slider-handle").each (i, handle) ->
      quantity = $(@).closest('form').find('input.product-slider').attr('data-slider-value')
      money = $(@).closest('form').find('input.product-slider').attr("data-money")
      mins = $(@).closest('form').find('input.product-slider').attr("data-mins")
      if money == "true"
        $(@).html("<p>A$" + quantity + "</p>")
      else if mins == "true"
        $(@).html("<p>" + quantity + " min</p>")
      else
        $(@).html("<p>" + quantity + "</p>")
  updateSliderHandles()

  # Update slider handles quantity on slide
  $(document).on 'slideStop slide', '#pricing .product-slider', (e) ->
    price = parseFloat($(@).attr("data-price"));
    money = $(@).attr("data-money")
    mins = $(@).attr("data-mins")
    total_price = Math.ceil(e.value * price)
    $(@).closest(".slider-wrapper").find(".slider-total").text("A$" + total_price)
    if money == "true"
      $(@).closest(".slider-wrapper").find(".slider-handle").html("<p>A$" + e.value + "</p>")
    else if mins == "true"
      $(@).closest(".slider-wrapper").find(".slider-handle").html("<p>" + e.value + " min</p>")
    else
      $(@).closest(".slider-wrapper").find(".slider-handle").html("<p>" + e.value + "</p>")

  # Send sliders forms on slide release
  sliders = '#podcast-production .product-slider, #video-production .product-slider, #visual-production .product-slider'
  $(document).on 'slideStop release', sliders, ->
    $(@).closest('form').submit()


  ### DISCOUNT CODE ###

  oldValue = ""
  newValue = ""

  $(document).on 'focus', '#discount-code', ->
    oldValue = $(@).val()

  $(document).on 'blur', '#discount-code', ->
    newValue = $(@).val()
    if oldValue != newValue
      $(@).closest('form').submit()


  ### STAGES ###

  toggleStages = ->
    if $('#stages-wrapper').length
      stagesOffsetTop = $('#stages-wrapper').offset().top
      stagesHeight = $('#stages-wrapper').outerHeight()
      totalOffset = stagesOffsetTop + stagesHeight / 3 - 5
      if $(window).scrollTop() > totalOffset && $(window).width() > 767
        $('#stages').addClass('fixed')
        $('#stages-wrapper').addClass('fixed')
      else
        $('#stages').removeClass('fixed')
        $('#stages-wrapper').removeClass('fixed')

  toggleStages()
  $(window).on 'scroll', ->
    toggleStages()
  $(window).resize ->
    toggleStages()


  ### CUSTOMER SPECIFICS ###

  $(document).on 'change', '#customer-specifics input', ->
    $(@).closest(".question").find("label").removeClass("active")
    $(@).addClass("active")
    $(@).closest('form').submit()


  ### PODCAST, VIDEO, IMAGE CONTENT ###

  $(document).on 'click', '#order-wizard .product-offer .btn', ->
    $(@).closest('.hidden-product').find('.product-offer').addClass('hidden')
    $(@).closest('.hidden-product').find('.product-select').addClass('active')

  $(document).on 'change', '#order-wizard .social-distribution label, #order-wizard .question label', ->
    $(@).closest('form').submit()
    $(@).closest('label').toggleClass("active")


  ### PRICING PAGE LAYOUT ###

  updateSectionsHeight = ->
    viewPortHeight = $(window).height()
    footerHeight = $('footer').outerHeight()
    desiredHeight = viewPortHeight - footerHeight

    page = $(".orders_page.edit_action").find("#page")

    if page.length
      if ($(window).width() > 767)
        page.css("min-height", "#{desiredHeight}px")
      else
        page.css("min-height", "auto")

  updateSectionsHeight()

  $(window).resize ->
    updateSectionsHeight()


  ### PRICING WIZARD GENERAL ###

  customerSpecificsValid = ->
    if ($('#customer-specifics input:checked').length == 4) && ($('#customer-specifics #order_email').val().length > 0) && ($('#customer-specifics #order_name').val().length > 0) && ($('#customer-specifics #order_phone_number').val().length > 0)
      true

  validateOnNext = (index) ->
    if index == 2
      unless customerSpecificsValid()
        $('#errors').html("<span>Please fill the required fields and answer all the questions above</span>")
        false
      else
        $('#errors').html("")
    else if index == 5
      unless parseInt($('#total-price .inner b').html().slice(2)) > 0
        $('#errors').html("<span>Please add at least one product at Podcast, Video or Graphic tab</span>")
        false
      else
        $('#errors').html("")

  validateOnNav = (clickedIndex) ->
    if !(customerSpecificsValid()) && (clickedIndex > 1)
      $('#errors').html("<span>Please fill the required fields and answer all the questions above</span>")
      false
    else if !(parseInt($('#total-price .inner b').html().slice(2)) > 0) && (clickedIndex > 4)
      $('#errors').html("<span>Please add at least one product at Podcast, Video or Graphic tab</span>")
      false
    else
      $('#errors').html("")

  cookieLatestTab = document.cookie.replace(/(?:(?:^|.*;\s*)latest_tab\s*\=\s*([^;]*).*$)|^.*$/, "$1")

  if $('#order-wizard').length
    $('#order-wizard').bootstrapWizard(
      {'previousSelector': '.wizard-prev-custom',
      'nextSelector': '.wizard-next, .wizard-start',

      onNext: (tab, navigation, index) ->
        validateOnNext(index)

      onTabClick: (tab, navigation, currentIndex, clickedIndex) ->
        validateOnNav(clickedIndex)

      onTabShow: (tab, navigation, index) ->
        $total = navigation.find('li').length
        $current = index + 1
        $percent = $current / $total * 100
        $('#order-wizard .progress-bar').css width: $percent + '%'

        document.cookie = "latest_tab=#{index}" if (index > cookieLatestTab)

        if index == 0
          $(".wizard-start").removeClass('hidden')
          $(".wizard-next, .pager.wizard .wizard-prev-custom").addClass('hidden')
          $(".wizard-finish-arrow").addClass('hidden')
          $("#total-price").addClass('hidden')
        else if index == 5
          $(".wizard-start").addClass('hidden')
          $(".wizard-next, wizard-next-arrow .wizard-prev-custom").addClass('hidden')
          $(".wizard-finish-arrow").removeClass('hidden')
          $("#total-price").removeClass('hidden')
        else
          $(".wizard-start").addClass('hidden')
          $(".wizard-next, .pager.wizard .wizard-prev-custom").removeClass('hidden')
          $(".wizard-finish-arrow").addClass('hidden')
          $("#total-price").removeClass('hidden')
      })

    $('#order-wizard').bootstrapWizard('show', cookieLatestTab);


  ### CUSTOMER INFO FORM ###

  $(document).on 'click, blur', '#customer-info-form input, #customer-info-form select', ->
    $(@).closest('form').submit()
