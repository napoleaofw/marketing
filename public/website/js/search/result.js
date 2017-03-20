var $searchResultSection = $("#search-result-section");
var $searchResultList = $searchResultSection.find(".search-result-list");
var $searchResult = $searchResultList.find(".search-result");
for(var i = 0; i < 15; i++) {
    var $searchResultClone = $searchResult.clone();
    $searchResultList.append($searchResultClone);
}