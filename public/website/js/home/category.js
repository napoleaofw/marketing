$(document).ready(function() {
	$(".category svg path").each(function() {
		var comprimento = $(this).get(0).getTotalLength();
		var comprimentoArredondado = Math.round(comprimento);
		$(this).attr("stroke-dasharray", comprimentoArredondado);
		$(this).attr("stroke-dashoffset", comprimentoArredondado);
	});
	$(".category-icon").viewportChecker({
		classToAdd: "stroke-animate",
		offset: 50
	});
});