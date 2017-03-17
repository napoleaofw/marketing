/* begin scroll */
var checkScroll = function checkScroll() {
    var $body = $("body");
	var $header = $("header");
	var scrollHeight = 600;
	if($body[0].scrollTop >scrollHeight) {
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
	$("body").toggleClass("overlay");
	$navbar = $(this).siblings(".navbar");
	$navbar.toggleClass("collapse navbar-mobile");
});
/* end navbar */