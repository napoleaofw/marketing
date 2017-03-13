/* begin scroll */
var checkScroll = function checkScroll() {
    var $body = $("body");
	var $searchContent = $("#search-content");
	var $header = $("header");
	if($body[0].scrollTop > $searchContent[0].scrollHeight) {
		$header.addClass("small-header");
	}
	else {
		$header.removeClass("small-header");
	}
};

$(document).on("scroll", checkScroll);
/* end scroll */

/* begin navbar */
$(document).on("click", "header .navbar-toggle", function() {
	$("body").toggleClass("overlay-active");
	$navbar = $(this).siblings(".navbar");
	$navbar.toggleClass("collapse navbar-mobile");
});
/* end navbar */