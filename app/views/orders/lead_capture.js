$('#lead-capture-modal .form').slideUp(400)
$('#lead-capture-modal .thankyou').slideDown(400)

function hideModal(){
  $('#lead-capture-modal').modal('hide');
}

setTimeout(hideModal, 3000)
