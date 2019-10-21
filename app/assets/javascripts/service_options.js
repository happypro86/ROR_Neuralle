$('.service-options').on('click', '.service-option-header *', function(){
  var tag = $(this).prop('tagName');
  if(tag != 'INPUT' && tag != 'LABEL'){
    $(this)
      .parent('.service-option-header')
      .siblings('.service-option-description')
      .slideToggle(400);
    $(this)
      .parent('.service-option-header')
      .find('.expand-icon')
      .toggleClass('fa-plus')
      .toggleClass('fa-minus');
  }
});
