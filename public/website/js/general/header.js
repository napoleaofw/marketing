/* begin scroll */
var checkScroll = function checkScroll() {
    var $body = $("body");
	var $header = $("header");
	var scrollHeight = 50;
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
	var $this = $(this);
	$header = $this.parent("header");
	$this.toggleClass("active");
	$("body").toggleClass("overlay");
	$navbar = $(this).siblings(".navbar");
	if($navbar.hasClass("navbar-mobile")) {
		$navbar.fadeOut("slow", function() {
			$navbar.toggleClass("hidden-xs navbar-mobile");
		});
	}
	else {
		$navbar.toggleClass("hidden-xs navbar-mobile");
		$navbar.fadeIn("slow");
	}
});
/* end navbar */