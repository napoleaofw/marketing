$("input[type='checkbox']").on("ifClicked", function(event){
    var uri = $(this).parents("a").attr('href');
    location.href = uri;
});