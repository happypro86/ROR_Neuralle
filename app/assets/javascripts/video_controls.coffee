if $('.video-container').length

  $('.video-container video').on 'click', ->
    video = $(@)[0]
    playButton = $(@).closest('.video-container').find('.play-button')
    toggleFullscreen = $(@).closest('.video-container').find('.toggle-fullscreen')

    if video.paused
      video.play()
      playButton.hide()
      toggleFullscreen.show()
    else
      video.pause()
      playButton.show()
      toggleFullscreen.hide()


  $('.video-container .aspect-ratio').on 'mouseenter', ->
    video = $(@).closest('.video-container').find('video')[0]
    toggleFullscreen = $(@).closest('.video-container').find('.toggle-fullscreen')

    if !video.paused
      toggleFullscreen.show()


  $('.video-container .aspect-ratio').on 'mouseleave', ->
    toggleFullscreen = $(@).closest('.video-container').find('.toggle-fullscreen')
    toggleFullscreen.hide()


  $('.video-container .toggle-fullscreen').on 'click', ->
    video = $(@).closest('.video-container').find('video')[0]
    if video.requestFullscreen
      video.requestFullscreen()
    else if video.mozRequestFullScreen
      video.mozRequestFullScreen()
    else if video.webkitRequestFullscreen
      video.webkitRequestFullscreen()

  $('.video-container video').on 'ended', ->
    playButton = $(@).closest('.video-container').find('.play-button')
    playButton.show()
