#' Search HDX for Datasets
#'
#' This function will search the humanitarian data exchange for the term provided to it. It will return a dataframe of the results.
#' If you are using the precise term and do not want any similar results, use the exact argument. If you want greater than ten results,
#' use the rows argument.
#'
#'
#' @param term Title to search for. No default
#' @param rows Max number of rows to return. Default is 10
#' @param exact If exact = TRUE, will return only those datasets that exactly match the term provided. Default is FALSE
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_dataset_search()
#' hdx_dataset_search("afghanistan-roads", exact = TRUE)
#' hdx_dataset_search(rows = 100)


# Use the ckanr package to search for a ckanr package (same as an hdx dataset)
hdx_dataset_search <- function(term = '*:*', rows = 10, start = NULL, exact = FALSE){
  ckan_data <- ckanr::package_search(q = term, as = "json", rows = rows, start = start) %>%
# Convert this to a dataframe using jsonlite
    jsonlite::fromJSON(., flatten = TRUE) %>%
# Extract the useful nested results
    .$result %>%
    .$results

# Ensure that none of the results have duplicated column names
  valid_column_names <- make.names(names=names(ckan_data), unique=TRUE, allow_ = TRUE)
  names(ckan_data) <- valid_column_names

  if(exact == TRUE){
# Filter out datasets that don't exactly match the term provided when exact is TRUE
    ckan_data %>%
      dplyr::filter(name == term)
  } else {
    ckan_data
    }
}

