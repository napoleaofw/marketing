/* begin tag <a> */
$('body').on('click', 'a', function(event) {
  if($(this).attr('href') === '#') {
    event.preventDefault();
  }
});
/* end tag <a> */
/* begin iCheck */
var initiCheck = function() {
  $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
    checkboxClass: 'icheckbox_minimal-blue',
    radioClass: 'iradio_minimal-blue'
  });
};
/* begin user preference */
$('form#menu').on('click', '.sidebar-toggle', function() {
  $.ajax({
    type: 'post',
    url: '/website/user/preference',
    data: { 
      _token: $('form#menu input[name="_token"]').val(),
      preference_name: 'sidebar-collapse',
      preference_value: ($('body').hasClass('sidebar-collapse') ? 'N' : 'Y')
    },
    dataType: 'json',
    success: function(data) {},
    error: function(data) {}
  });
});
/* end user preference */
var main = function() {
};
$(document).ready(main);