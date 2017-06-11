#' HDX Package Search Function
#'
#' This function will create a data frame of search results from HDX
#' @param term Title to search for. No default
#' @param rows Max number of rows to return. Default is 10
#' @keywords search hdx
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_package_search()

hdx_package_search <- function(term = '*:*', rows = 10, start = NULL){
  ckan_data <- ckanr::package_search(q = term, as = "json", rows = rows, start = start) %>%
    jsonlite::fromJSON(., flatten = TRUE) %>%
    .$result %>%
    .$results

  valid_column_names <- make.names(names=names(ckan_data), unique=TRUE, allow_ = TRUE)
  names(ckan_data) <- valid_column_names

  ckan_data
}

