/* begin timepicker */
var initTimePicker = function() {
  $timePickerWidget = $('.bootstrap-timepicker-widget').remove();
  $('.timepicker').each(function() {
    if($(this).data('timepicker') === undefined) {
      $(this).timepicker({
        defaultTime: false,
        disableFocus: true,
        disableMousewheel: true,
        hoursOnTwoDigits: true,
        maxHours: 24,
        minuteStep: 15,
        showMeridian: false,
        showInputs: true,
      });
    }
  });
  $(document).on('keydown', function(event) {
    var keyCode = event.keyCode || event.which;
    if(keyCode == 9) {
      $(this).find('.timepicker').timepicker('hideWidget');
    }
  });
}
/* end timepicker */
/* begin mask */
var createMaskFields = function($type) {
  if(Object.keys(maskFields).length > 0) {
    if($type === 'record' || $type === 'both') {
      $.each(maskFields, function(element, mask) {
        if(element !== 'form_record') {
          $(element).each(function() {
            if(!$(this).data('_inputmask_opts')) {
              var value = $(this).val();
              $(this).inputmask(mask, {removeMaskOnSubmit: true});
              $(this).inputmask('setvalue', value);
            }
          });
        }
      });
    }
    if($type === 'form_record' || $type === 'both') {
      if(maskFields['form_record'] !== undefined && Object.keys(maskFields['form_record']).length > 0) {
        $.each(maskFields['form_record'], function(element, mask) {
          $(element).each(function() {
            if(!$(this).data('_inputmask_opts')) {
              var value = $(this).val();
              $(this).inputmask(mask, {removeMaskOnSubmit: true});
              $(this).inputmask('setvalue', value);
            }
          });
        });
      }
    }
  }
};
/* end mask */
/* begin initStandardFields */
var initStandardFields = function() {
  initTimePicker();
  createMaskFields('both');
}
/* end initStandardFields */
/* begin initStandardFieldsRecord */
var initStandardFieldsRecord = function() {
  initTimePicker();
  createMaskFields('form_record');
}
/* end initStandardFieldsRecord */
var main = function() {
  /* begin standard */
  initStandardFields();
  /* end standard */
  /* begin formRecords */
  var cleanRecord = function($record) {
    $checkbox = $record.find('input[type="checkbox"].minimal');
    $checkbox.val('');
    $checkbox.iCheck('uncheck');
    $select = $record.find('select');
    $select.each(function() {
      $(this).removeData().off().val('');
    });
    $inputText = $record.find('input[type="text"]');
    $inputText.each(function() {
      $(this).removeData().off().val('');
    });
    return $record;
  };
  var reIndexRecords = function($box) {
    var formRecord = $box.find('input[name="_form_record"]').val();
    var $records = $box.find('.box-body > table > tbody > tr');
    var counter = 0;
    $records.each(function() {
      var $elements = $(this).find('[name*="'+formRecord+'"]');
      $elements.each(function() {
        var elementName = $(this).attr('name');
        var elementMainName = elementName.substr(elementName.lastIndexOf('['));
        $(this).attr('name', formRecord+'['+counter+']'+elementMainName);
      });
      counter++;
    });
  };
  $('.form-record-actions').on('click', '.btn-add', function(event) {
    $box = $(this).parents('.box');
    $tBody = $box.find('.box-body > table > tbody');
    $record = $box.find('.box-body > table > tbody > tr:last-child');
    $newRecord = $record.clone(true);
    $newRecord = cleanRecord($newRecord);
    $tBody.append($newRecord);
    initiCheck();
    $mainCheckbox = $box.find('table thead tr th.select-record .icheckbox_minimal-blue input[type="checkbox"].minimal');
    executeAnalysis = false;
    $mainCheckbox.iCheck('uncheck');
    executeAnalysis = true;
    reIndexRecords($box);
    initStandardFieldsRecord();
  });
  $('.form-record-actions').on('click', '.btn-del', function(event) {
    $box = $(this).parents('.box');
    $box.find('.box-body > table > tbody > tr td.select-record .icheckbox_minimal-blue input[type="checkbox"].minimal:checked').each(function() {
      $record = $(this).parents('tr');
      if($box.find('.box-body > table > tbody > tr').length > 1) {
        $record.remove();
      }
      else {
        cleanRecord($record);
      }
    });
    $mainCheckbox = $box.find('table thead tr th.select-record .icheckbox_minimal-blue input[type="checkbox"].minimal');
    analysisMainCheckboxTable($mainCheckbox);
    reIndexRecords($box);
    initStandardFieldsRecord();
  });
  /* end formRecords */
  /* begin form */
  $('input').on('keypress', function(event) {
    if(event.keyCode == 13) {
      event.preventDefault();
    }
  });
  /* end form */
};
$(document).ready(main);