var main = function() {
  /* begin inputFile */
  var mainInitialPreview = jQuery.parseJSON($('input[name="mainInitialPreview"]').val());
  var mainInitialPreviewConfig = jQuery.parseJSON($('input[name="mainInitialPreviewConfig"]').val());
  $('input[name="main_photo"]').fileinput({
    allowedFileTypes: ['image'],
    autoReplace: true,
    initialPreview: mainInitialPreview,
    initialPreviewConfig: mainInitialPreviewConfig,
    language: 'pt-BR',
    layoutTemplates: {
      actionDrag: ''
    },
    maxFileCount: 1,
    showUploadedThumbs: false,
    overwriteInitial: false,
    uploadExtraData: {
      _token: $('input[name="_token"]').val(),
      idAd: $('input[name="ad_id"]').val()
    },
    uploadUrl: '/app/ad/main-photo/create',
    validateInitialCount: true
  });
  var initialPreview = jQuery.parseJSON($('input[name="initialPreview"]').val());
  var initialPreviewConfig = jQuery.parseJSON($('input[name="initialPreviewConfig"]').val());
  $('input[name="photo[]"]').fileinput({
    allowedFileTypes: ['image'],
    language: 'pt-BR',
    fileActionSettings: {
      dragIcon: '<i class="glyphicon glyphicon-move"></i>'
    },
    initialPreview: initialPreview,
    initialPreviewConfig: initialPreviewConfig,
    maxFileCount: 3,
    otherActionButtons: '<button type="button" class="kv-file-information btn btn-xs btn-default" data-toggle="modal" title="Informações"><i class="glyphicon glyphicon-menu-hamburger"></i></button>',
    overwriteInitial: false,
    uploadExtraData: function(previewId, index) {
      return {
        _token: $('input[name="_token"]').val(),
        idAd: $('input[name="ad_id"]').val(),
        sequence: index
      };
    },
    uploadUrl: '/app/ad/photo/create',
    validateInitialCount: true
  }).on('filesorted', function(event, params) {
    $.ajax({
      type: 'post',
      url: '/app/ad/photo/reorder',
      data: { 
        _token: $('input[name="_token"]').val(),
        idAd: $('input[name="ad_id"]').val(),
        stack: params.stack
      },
      dataType: 'json',
      success: function(data) {},
      error: function(data) {}
    });
  }).on('fileuploaded', function(event, data, previewId, index) {
    console.log($(this).data());
    console.log(data);
  });
  $('form').on('click', '.kv-file-information', function() {
    var id = $(this).parents('.file-preview-frame').find('input[name="image_id"]').val();
    $(this).attr('data-target', '#modalPhoto'+id);
  });
  /* end inputFile */
  /* begin ajaxSave */
  $('form').on('click', '.btn-save-photo', function() {
    var modalBody = $(this).parent('.modal-footer').siblings('.modal-body');
    var errorPanel = modalBody.find('#errors-photo');
    $.ajax({
      type: 'post',
      url: '/app/ad/photo/save',
      data: { 
        _token: $('input[name="_token"]').val(),
        image_id: modalBody.find('input[name="image_id"]').val(),
        title: modalBody.find('input[name="title"]').val(),
        description: modalBody.find('textarea[name="description"]').val()
      },
      dataType: 'json',
      success: function(data) {
        errorPanel.find('.alert').remove();
        errorPanel.hide();
        modalBody.closest('.modal').modal('toggle');
      },
      error: function(data) {
        var errors = data.responseJSON;
        errorPanel.find('.alert').remove();
        errorPanel.append('<div class="alert alert-danger alert-dismissable">'+
                              '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+
                              '<ul></ul>'+
                            '</div>'+
                          '</div>');
        if(errors['error'] !== undefined) {
          errorPanel.find('ul').append('<li>'+errors['error']+'</li>');
        }
        else {
          $.each(errors, function(index, p_error) {
              errorPanel.find('ul').append('<li>'+p_error[0]+'</li>');
          });
        }
        errorPanel.show();
      }
    });
  });
  /* end ajaxSave */
}
$(document).ready(main);