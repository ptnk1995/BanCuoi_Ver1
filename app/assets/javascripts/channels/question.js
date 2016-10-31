function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id));
}
function remove_fields(link) {
  $(link).prev('input[type=hidden]').value = '1';
  $(link).closest('.form-group').remove();
}
function morethan(cbox) {
  if (cbox.checked) {
    $('input:checkbox').removeAttr('checked');
    $('input[type=checkbox]').change(function(e){
      $(this).prop('checked', true)
    })
  }
}
function lessthan(cbox) {
  if (cbox.checked) {
    $('input:checkbox').removeAttr('checked');
    $('input[type=checkbox]').change(function(e){
    if ($('input[type=checkbox]:checked').length > 1) {
      $(this).prop('checked', false)
       }
    })
  }
}
$(document).ready(function(){
  $("#myBtn").click(function(){
    $("#myModal").modal();
  });
});
