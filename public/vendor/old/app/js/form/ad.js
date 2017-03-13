/* begin mask */
var maskFields = {
  'input[name="postcode"]': '99999-999',
  'form_record': {
    'input[name*="business_hour"][name*="[hour_start]"],input[name*="business_hour"][name*="[hour_end]"]': '99:99',
    'input[name*="business_hour"][name*="[sequence]"],input[name*="phone"][name*="[sequence]"],input[name*="email"][name*="[sequence]"],input[name*="social_network"][name*="[sequence]"],input[name*="website"][name*="[sequence]"]': {
      'mask': '9',
      'repeat': 3,
      'greedy': false
    },
    'input[name*="phone"][name*="[phone]"]': '(99) 9999-9999',
    'input[name*="email"][name*="[email]"]': {
      mask: '*{1,20}[.*{1,20}][.*{1,20}][.*{1,20}]@*{1,20}[.*{2,6}][.*{1,2}]',
      greedy: false,
      onBeforePaste: function (pastedValue, opts) {
        pastedValue = pastedValue.toLowerCase();
        return pastedValue.replace('mailto:', '');
      },
      definitions: {
        '*': {
          validator: "[0-9A-Za-z!#$%&'*+/=?^_`{|}~\-]",
          cardinality: 1,
          casing: 'lower'
        }
      }
    },
    'input[name*="social_network"][name*="[url]"]': 'url',
    'input[name*="website"][name*="[url]"]': 'url'
  }
};
/* end mask */
var main = function() {}
$(document).ready(main);