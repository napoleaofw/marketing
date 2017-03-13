var main = function() {
  /* begin iCheck */
  initiCheck();
  /* end iCheck */
  /* begin search */
  if($('form#main-search').length > 0) {
    $('form#main-search input[name="city"]').typeahead({
      highlighter: function (item) {
        var map = {"â":"a","Â":"A","à":"a","À":"A","á":"a","Á":"A","ã":"a","Ã":"A","ê":"e","Ê":"E","è":"e","È":"E","é":"e","É":"E","î":"i","Î":"I","ì":"i","Ì":"I","í":"i","Í":"I","õ":"o","Õ":"O","ô":"o","Ô":"O","ò":"o","Ò":"O","ó":"o","Ó":"O","ü":"u","Ü":"U","û":"u","Û":"U","ú":"u","Ú":"U","ù":"u","Ù":"U","ç":"c","Ç":"C"};
        var html = $('<div></div>');
        var query = this.query;
        var i = item.replace(/[\W\[\] ]/g,function(a){return map[a]||a}).toLowerCase().indexOf(query.replace(/[\W\[\] ]/g,function(a){return map[a]||a}).toLowerCase());
        var len = query.length;
        var leftPart;
        var middlePart;
        var rightPart;
        var strong;
        if (len === 0) {
          return html.text(item).html();
        }
        while (i > -1) {
          leftPart = item.substr(0, i);
          middlePart = item.substr(i, len);
          rightPart = item.substr(i + len);
          strong = $('<strong></strong>').text(middlePart);
          html
            .append(document.createTextNode(leftPart))
            .append(strong);
          item = rightPart;
          i = item.replace(/[\W\[\] ]/g,function(a){return map[a]||a}).toLowerCase().indexOf(query.replace(/[\W\[\] ]/g,function(a){return map[a]||a}).toLowerCase());
        }
        return html.append(document.createTextNode(item)).html();
      },
      minLength: 3,
      matcher: function(item) {
        var map = {"â":"a","Â":"A","à":"a","À":"A","á":"a","Á":"A","ã":"a","Ã":"A","ê":"e","Ê":"E","è":"e","È":"E","é":"e","É":"E","î":"i","Î":"I","ì":"i","Ì":"I","í":"i","Í":"I","õ":"o","Õ":"O","ô":"o","Ô":"O","ò":"o","Ò":"O","ó":"o","Ó":"O","ü":"u","Ü":"U","û":"u","Û":"U","ú":"u","Ú":"U","ù":"u","Ù":"U","ç":"c","Ç":"C"};
        var it = this.displayText(item).replace(/[\W\[\] ]/g,function(a){return map[a]||a});
        var query = this.query.replace(/[\W\[\] ]/g,function(a){return map[a]||a});
        return ~it.toLowerCase().indexOf(query.toLowerCase());
      },
      source: jQuery.parseJSON($('form#main-search input[name="city_json"]').val()),
    });
    $('form#main-search input').on('keypress', function(event) {
      var $form = $('form#main-search');
      if(event.keyCode == 13) {
        $form.find('input[name="keywords"],input[name="city"]').each(function() {
          if($(this).val() !== '') {
            $form.submit();
          }
        });
      }
    });
  }
  /* end search */
};
$(document).ready(main);