/* begin mask */
var maskFields = {
  'input[name="cpf"]': '999.999.999-99',
  'input[name="birth_date"],input[name="foundation_date"]': '99/99/9999',
  'input[name="cnpj"]': '99.999.999/9999-99'
};
/* end mask */
  var main = function() {
  /* begin typePerson */
  var analysisPersonType = function() {
    var typeValue = $('input[name="type"]:checked').val();
    if(typeValue === 'F') {
      $('.type-j').stop().fadeOut(function() {
        $('.type-f').stop().fadeIn();
      });
      $inputText = $('.type-j').find('input[type="text"]');
      $inputText.each(function() {
        $(this).val('');
      });
    }
    else if(typeValue === 'J') {
      $('.type-f').stop().fadeOut(function() {
        $('.type-j').stop().fadeIn();
      });
      $inputText = $('.type-f').find('input[type="text"]');
      $inputText.each(function() {
        $(this).val('');
      });
    }
  };
  analysisPersonType();
  $('input[name="type"]').on('ifChanged', function() {
    analysisPersonType();
  });
  /* end typePerson */
}
$(document).ready(main);