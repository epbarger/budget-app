$(document).ready(function(){
  $('tr.click-to-expand').on('click', function(){
    $('div.detail-row-div').slideUp(200);
    $detailRow = $(this).next('tr').find('div.detail-row-div')
    $detailRow.slideToggle(200);
  })
})
