var request = function request($elementCategory) {
    $elementSubcategory = $("select[name='subcategory']");
    $elementSubcategory.find('option:not(:first-child)').remove();
    if($elementCategory.val()) {
        $.ajax({
            type: "GET",
            url: "/api/category",
            data: { 
                categoryId: $elementCategory.val(),
            },
            dataType: "json",
            success: function(data) {
                var response = data;
                $.each(response, function(index, value) {
                    $elementSubcategory.append("<option value='" + value.id + "'>" + value.name + "</option>");
                });
            },
            error: function(data) {},
            complete: function(data) {}
        });
    }
};

$("select[name='category']").on("change", function() {
    request($(this));
});