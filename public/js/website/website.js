// $("#search-typed").typed({
//     strings: [
//         "Os melhores restaurantes...",
//         "Os melhores hotéis...",
//         "Os melhores serviços...",
//         "Pesquise, encontre e descubra.",
//         "Surpreenda-se com o melhor da sua região."
//     ],
//     typeSpeed: 80,
//     backSpeed: 50,
//     backDelay: 2000
// });
$(document).ready(function() {
    $(".visible-effect").viewportChecker({
        classToAdd: "visible",
        offset: 150
    });
});