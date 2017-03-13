var main = function() {  
  /* begin records */
  $('form.form-list').on('submit', function(event) {
    var $form = $(this);
    var list = $('input[name="_list"]').val();
    var $tBody = $('table tbody');
    var $records = $tBody.find('tr td.select-record .icheckbox_minimal-blue input[type="checkbox"][name="id"].minimal:checked');
    $records.each(function() {
      if($(this).val()) {
        $form.prepend('<input type="hidden" name="idRecords[]" value="'+$(this).val()+'">');
      }
    });
    if($('input[name="idRecords[]"]').length === 0) {
      event.preventDefault();
    }
  });
  /* end records */
  /* begin dataTable */
  $('#listTable').DataTable({
    "aoColumnDefs": [{
      'bSortable': false,
      'aTargets':  [0, -1]
    }],
    "responsive": true,
    "aaSorting": [1, "asc"],
    "language": {
      "decimal": "",
        "emptyTable":     "Não há dados disponíveis",
        "info":           "Exibindo _START_ até _END_ do total de _TOTAL_ registros",
        "infoEmpty":      "Exibindo 0 até 0 do total de 0 registros",
        "infoFiltered":   "(filtrados _MAX_ do total de registros)",
        "infoPostFix":    "",
        "thousands":      ",",
        "lengthMenu":     "Exibindo _MENU_ registros por página",
        "loadingRecords": "Carregando...",
        "processing":     "Processando...",
        "search":         "Pesquisar:",
        "zeroRecords":    "Nenhum resultado encontrado",
        "paginate": {
          "first":        "Primeira",
          "last":         "Última",
          "next":         "Próximo",
          "previous":     "Anterior"
        },
        "aria": {
          "sortAscending":  ": ordenar coluna de forma crescente",
          "sortDescending": ": ordenar coluna de forma decrescente"
        }
      }
  });
  /* end dataTable */
};
$(document).ready(main);