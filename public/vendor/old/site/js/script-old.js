var maxHeight = 0;

$('.ad-info ul').each(function(){
   if ($(this).height() > maxHeight) { maxHeight = $(this).height(); }
});

$('.ad-info ul').height(maxHeight);