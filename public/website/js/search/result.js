// var $searchResultSection = $("#search-result-section");
// var $searchResultList = $searchResultSection.find(".search-result-list");
// var $searchResult = $searchResultList.find(".search-result");
// for(var i = 0; i < 15; i++) {
//     var $searchResultClone = $searchResult.clone();
//     $searchResultList.append($searchResultClone);
// }
$(document).ready(function() {
    var request = function request(button, action) {
        var $searchResult = button.parents(".search-result");
        var id = $searchResult.data("id");
        $.ajax({
            type: "PUT",
            url: "/api/ad/markFor",
            data: { 
                _token: $("input[name='_token']").val(),
                id: id,
                action: action
            },
            dataType: "json",
            success: function(data) {
                if(action === "review") {
                    $searchResult.find("[data-action='review']").toggleClass("text-green");
                }
                else if(action === "delete") {
                    $searchResult.find("[data-action='delete']").toggleClass("text-red");
                }
            },
            error: function(data) {},
            done: function(data) {
                var $html = $(data.html);
                $html.find("button").remove();
                $html.css({
                    "display": "none",
                    "position": "absolute",
                    "right": "15px",
                    "z-index": "9999"
                });
                $(".page-content").prepend($html);
                $html.fadeIn("fast", function() {
                    setTimeout(function() {
                        $html.fadeOut("slow");
                    }, 3000);
                });
                $html.remove();
            }
        });
    };
    $("[data-action='review']").on("click", function() {
        request($(this), "review");
    });
    $("[data-action='delete']").on("click", function() {
        request($(this), "delete");
    });
});