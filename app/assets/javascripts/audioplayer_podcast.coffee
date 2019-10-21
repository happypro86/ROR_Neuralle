$(document).ready ->
  playerid = 'ag-podcast'
  bar_len = 250
  reflection_size = 0.3

  settings_ap =
    disable_volume: 'off'
    disable_scrub: 'default'
    design_skin: 'skin-wave'
    skinwave_dynamicwaves: 'off'
    skinwave_enableSpectrum: 'off'
    settings_backup_type: 'full'
    skinwave_enableReflect: 'on'
    skinwave_comments_enable: 'off'
    skinwave_timer_static: 'off'
    disable_player_navigation: 'off'
    skinwave_mode: 'normal'
    default_volume: 'last'
    skinwave_comments_retrievefromajax: 'on'
    skinwave_wave_mode: 'canvas'
    skinwave_wave_mode_canvas_waves_number: bar_len
    skinwave_wave_mode_canvas_reflection_size: reflection_size
    settings_extrahtml: '
      <a class="subscribe-btn apple" href="https://itunes.apple.com/au/podcast/uncommon-by-neuralle-intelligence-performance-tech/id1207699448" target="_blank"></a>
      <a class="subscribe-btn stitcher" href="https://www.stitcher.com/podcast/neuralle/uncommon-by-neuralle" target="_blank"></a>
    '
  dzsag_init '#' + playerid,
    'transition': 'fade'
    'cueFirstMedia': 'on'
    'autoplay': 'off'
    'autoplayNext': 'on'
    design_menu_position: 'bottom'
    'settings_ap': settings_ap
    embedded: 'off'
    enable_easing: 'on'
    design_menu_height: 270
    design_menu_state: 'open'
    design_menu_show_player_state_button: 'off'
  return