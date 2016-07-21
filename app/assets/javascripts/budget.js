$(document).ready(function(){
  $('tr.click-to-expand').on('click', function(){
    $detailRow = $(this).next('tr').find('div.detail-row-div')
    $('div.detail-row-div').not($detailRow).slideUp(200);
    $detailRow.slideToggle(200);
  })
})
