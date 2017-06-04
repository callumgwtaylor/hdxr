#' HDX Package Search Function
#'
#' This function will create a data frame of search results from HDX
#' @param term Title to search for. No default
#' @keywords search hdx
#' @export
#' @examples
#' hdx_package_search()

hdx_package_search <- function(term){
  package_search(q = term, as = "json") %>%
    jsonlite::fromJSON(., flatten = TRUE) %>%
    .$result %>%
    .$results
}
