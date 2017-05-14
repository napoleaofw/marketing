$("input[type='checkbox']").on("ifClicked", function(event){
    var uri = $(this).parents("a").attr('href');
    location.href = uri;
});

$(".filter-tools").on("click", ".btn-box-tool[data-widget='collapse']", function(event) {
    event.preventDefault();
    var element = $(this);
    //Find the box parent
    var filterSection = element.parents(".search-filter-section").first();
    //Find the body and the footer
    var filterBody = filterSection.find(".search-filter-body");
    if(!filterSection.hasClass("collapsed-filter")) {
        //Convert minus into plus
        element.children(":first")
            .removeClass("fa-minus")
            .addClass("fa-plus");
        //Hide the content
        filterBody.slideUp(500, function () {
            filterSection.addClass("collapsed-filter");
        });
    } else {
        //Convert plus into minus
        element.children(":first")
            .removeClass("fa-plus")
            .addClass("fa-minus");
        //Show the content
        filterBody.slideDown(500, function () {
            filterSection.removeClass("collapsed-filter");
        });
    }
});


(function($, viewport){
    $(document).ready(function() {

        // Executes only in XS breakpoint
        if(viewport.is('xs')) {
            $(".filter-tools .btn-box-tool[data-widget='collapse']").click();
        }

        // Executes in SM, MD and LG breakpoints
        if(viewport.is('>=sm')) {
            // ...
        }

        // Executes in XS and SM breakpoints
        if(viewport.is('<md')) {
            // ...
        }

        // Execute code each time window size changes
        $(window).resize(
            viewport.changed(function() {
                if(viewport.is('xs')) {
                    
                }
            })
        );
    });
})(jQuery, ResponsiveBootstrapToolkit);