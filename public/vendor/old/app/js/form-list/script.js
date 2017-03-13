initiCheck();
/* end iCheck */
/* begin checkboxTable */
var analysisMainCheckboxTable = function($checkbox) {
  executeAnalysis = false;
  var qtyCheckbox = $checkbox.parents('table').find('tbody tr td.select-record .icheckbox_minimal-blue').length;
  var qtyCheckboxChecked = $checkbox.parents('table').find('tbody tr td.select-record .icheckbox_minimal-blue.checked').length;
  if(qtyCheckbox == qtyCheckboxChecked) {
    $checkbox.find('input[type="checkbox"].minimal').iCheck('check');
  }
  else {
    $checkbox.find('input[type="checkbox"].minimal').iCheck('uncheck');
  }
  executeAnalysis = true;
};
/* end checkboxTable */
var main = function() {
  /* begin */
  $('.overlay').fadeOut();
  /* end */
  /* begin checkboxTable */
  var executeAnalysis = true;
  var analysisClickMainCheckboxTable = function($checkbox) {
    executeAnalysis = false;
    var $table = $checkbox.parents('table');
    var isChecked = $checkbox.parents('.icheckbox_minimal-blue').hasClass('checked');
    $table.find('tbody tr td.select-record .icheckbox_minimal-blue').each(function() {
      if(isChecked) {
        $(this).find('input[type="checkbox"].minimal').iCheck('uncheck');
      }
      else {
        $(this).find('input[type="checkbox"].minimal').iCheck('check');
      }
    });
    executeAnalysis = true;
  };
  var analysisClickCheckboxTable = function($checkbox) {
    executeAnalysis = false;
    var isChecked = $checkbox.parents('.icheckbox_minimal-blue').hasClass('checked');
    var $mainCheckbox = $checkbox.parents('table').find('thead tr th.select-record .icheckbox_minimal-blue');
    if(!isChecked) {
      var qtyCheckbox = $checkbox.parents('tbody').find('tr td.select-record .icheckbox_minimal-blue').length;
      var qtyCheckboxChecked = $checkbox.parents('tbody').find('tr td.select-record .icheckbox_minimal-blue.checked').length;
      if((qtyCheckbox-1) == qtyCheckboxChecked) {
        $mainCheckbox.find('input[type="checkbox"].minimal').iCheck('check');
      }
    }
    else {
      $mainCheckbox.find('input[type="checkbox"].minimal').iCheck('uncheck');
    }
    executeAnalysis = true;
  };
  var analysisBtnDel = function($table) {
    $box = $table.parents('.box');
    var qtyCheckboxChecked = $table.find('tbody tr td.select-record input[type="checkbox"]:checked').length;
    if(qtyCheckboxChecked > 0) {
      $box.find('.btn-del').prop('disabled', false);
    }
    else {
      $box.find('.btn-del').prop('disabled', true);
    }
  };
  $('table thead').on('ifToggled', 'tr th.select-record input[type="checkbox"]', function(event) {
    if(executeAnalysis) {
      analysisClickMainCheckboxTable($(this));
    }    
  });  
  $('table tbody').on('ifToggled', 'tr td.select-record input[type="checkbox"]', function(event) {
    if(executeAnalysis) {
      analysisClickCheckboxTable($(this));
    }    
  });
  $('table tbody').on('ifChanged', 'tr td.select-record input[type="checkbox"]', function(event) {
    $table = $(this).parents('table');
    analysisBtnDel($table);
  });
  $('#listTable').on('draw.dt', function() {
    $table = $('table');
    $mainCheckbox = $table.find('thead tr th.select-record .icheckbox_minimal-blue');
    analysisMainCheckboxTable($mainCheckbox);
    analysisBtnDel($table);
  });
  /* end checkboxTable */
};
$(document).ready(main);