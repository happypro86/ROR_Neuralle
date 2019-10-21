$(document).ready ->

  $('.testimonials-carousel').owlCarousel({
    items: 1,
    loop: true,
    autoplay: true,
    autoplayHoverPause: true
  })

  $('.media-carousel').owlCarousel({
    items: 1,
    loop: true,
    autoplay: true,
    autoplayHoverPause: true
  })

  $('.instagram-media-carousel').owlCarousel({
    items: 3,
    loop: false,
    autoplay: true,
    autoplayHoverPause: true,
    dots: true
    responsive:{
      0:{
        items: 1
        dots: true,
      },
      400:{
        items: 2
        dots: true,
      },
      768:{
        items: 3,
        dots: true
      }
      992:{
        items: 3,
        dots: true
      }
    }
  })

  $('.media-what-carousel').owlCarousel({
    items: 3,
    loop: false,
    nav: true,
    navText: ["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"]
    center: true,
    dots: false,
    responsiveClass: true,
    responsiveRefreshRate: true,
    responsive:{
      0:{
        items: 1
        loop: true,
        nav: false,
        dots: true,
        autoplay: true
      },
      576:{
        items: 1
        loop: true,
        nav: false,
        dots: true,
        autoplay: true
      },
      768:{
        items: 1
      },
      992:{
        items: 3
      }
    }
  })

  $('.media-carousel .item').removeClass('hide')
  $('.media-what-carousel .item').removeClass('hide')
  $('.instagram-media-carousel .item').removeClass('hide')
