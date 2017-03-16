var $searchResults = $("#search-results");
var $searchResultsList = $searchResults.find(".search-results-list");
var $searchResult = $searchResultsList.find(".search-result");
for(var i = 0; i < 15; i++) {
    var $searchResultClone = $searchResult.clone();
    $searchResultsList.append($searchResultClone);
}