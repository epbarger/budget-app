$(document).ready(function(){
  $('tr.click-to-expand').on('click', function(){
    $detailRow = $(this).next('tr').find('div.detail-row-div')
    $('div.detail-row-div').not($detailRow).slideUp(200);
    $detailRow.slideToggle(200);
  })

  $('.notice, .alert').on('click', function(){
    $(this).fadeOut(300)
  })

  if ($('form#new_user').length > 0) {
    $('#user_timezone').val(jstz.determine().name())
  }
})
