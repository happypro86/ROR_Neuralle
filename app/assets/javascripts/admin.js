// Use this to customise the visual editor boot process
// Just mirror the options specified in your visual editor's config with the new
// options here.  This will completely override anything specified in your visual
// editor's boot process for that key, e.g. skin: 'something_else'

if (typeof(custom_visual_editor_boot_options) == "undefined") { custom_visual_editor_boot_options = {

  classesItems: [
    {name: 'text-align', rules:[{name: 'left', title: '{Left}'}, {name: 'center', title: '{Center}'}, {name: 'right', title: '{Right}'}, {name: 'justify', title: '{Justify}'}], join: '-', title: '{Text_Align}'}
    , {name: 'image-align', rules:[{name: 'left', title: '{Left}'}, {name: 'right', title: '{Right}'}], join: '-', title: '{Image_Align}'}
    , {name: 'font-size', rules:[{name: 'small', title: '{Small}'}, {name: 'normal', title: '{Normal}'}, {name: 'large', title: '{Large}'}], join: '-', title: '{Font_Size}'}
    , {name: 'text-quote', rules:[{name: 'quote', title: 'Quote'}], join: '-', title: 'Quote Text'}
  ],
  toolsItems: [
   {'name': 'Bold', 'title': 'Bold', 'css': 'wym_tools_strong'},
   {'name': 'Italic', 'title': 'Emphasis', 'css': 'wym_tools_emphasis'},
   {'name': 'InsertUnorderedList', 'title': 'Unordered_List', 'css': 'wym_tools_unordered_list'},
   {'name': 'InsertOrderedList', 'title': 'Ordered_List', 'css': 'wym_tools_ordered_list'},
   {'name': 'CreateLink', 'title': 'Link', 'css': 'wym_tools_link'},
   {'name': 'Unlink', 'title': 'Unlink', 'css': 'wym_tools_unlink'},
   {'name': 'InsertImage', 'title': 'Image', 'css': 'wym_tools_image'},
   {'name': 'InsertTable', 'title': 'Table', 'css': 'wym_tools_table'},
   {'name': 'ToggleHtml', 'title': 'HTML', 'css': 'wym_tools_html'},
   {'name': 'InsertMailChimp', 'title': 'MailChimp', 'css': 'wym_tools_mailchimp'}
  ],
  postInit: function(wym) {
    $(wym._box).find('li.wym_tools_mailchimp a').click(function(){
      getMailChimpList();
    });
   }
}; }

function getMailChimpList() {
  $.ajax({
    url : '/mailchimp_list.json',
    type : 'GET',
    success : function(data) {
      openDialog(data);
    },
    error : function(request, error) {
      alert(error)
    }
  });
}

function insertMailChimpForm(id){
  var html = '<div class="mailchimp-signup">' +
      '<form class="mc-embedded-subscribe-form" action="https://neuralle.us10.list-manage.com/subscribe/post?u=c7a21948a398f006f046c5731&amp;id=' + id + '" method="post" name="mc-embedded-subscribe-form" target="_blank">' +
          '<div class="subscribe-form">' +
              '<link href="//cdn-images.mailchimp.com/embedcode/classic-10_7.css" rel="stylesheet" type="text/css"></link>' +
              '<span class="asterisk">*</span>' +
              'indicates required' +
            '<div class="mc-field-group">' +
              '<label for="mce-FNAME">' +
                'First Name' +
                '<span class="asterisk">*</span>' +
              '</label>' +
              '<input class="required" id="mce-FNAME" name="FNAME" type="text"></input>' +
            '</div>' +

            '<div class="mc-field-group">' +
              '<label for="mce-LNAME">' +
                'Last Name' +
              '</label>' +
              '<input id="mce-LNAME" name="LNAME" type="text"></input>' +
            '</div>' +

            '<div class="mc-field-group">' +
              '<label for="mce-EMAIL">' +
                'Email' +
                '<span class="asterisk">*</span>' +
              '</label>' +
              '<input class="required email" id="mce-EMAIL" name="EMAIL" type="email"></input>' +
            '</div>' +

            '<div class="clear">' +
              '<input class="btn primary bold" id="mc-embedded-subscribe" name="subscribe" type="submit" value="Subscribe"></input>' +
            '</div>' +
          '</div>' +
      '</form>' +
  '</div>';

  WYMeditor.INSTANCES[0].insert(html);
}

function openDialog(data) {
  var htmlList = ''
  $.each(data, function(i, e){
    htmlList += "<div class='mailchimp-lists'><input type='radio' class='form-list-selection' value='" + e.id + "'>" + e.name +"</input></div>"
  })
  if ($('#dialog').length) {
    $('#dialog').html(htmlList);
  } else {
    $(document.body).append('<div id="dialog">'+ htmlList + '</div>');
  }

  $( "#dialog" ).dialog({
    title: 'Lists',
    autoOpen: false,
    show: "blind",
    hide: "explode"
  }).dialog("open");
}

$(document).ready(function(){
  $(document).on('click', '.mailchimp-lists .form-list-selection', function(){
    insertMailChimpForm($(this).val());
    $( "#dialog" ).dialog('close');
  })
})