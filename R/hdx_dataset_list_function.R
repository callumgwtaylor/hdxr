#' List HDX Datasets
#'
#' This function will return the names of the first 5000 datasets from
#' humanitarian data exchange, as a dataframe.
#'
#' @param limit Number of packages to search for. Defaults to 5000
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_dataset_list()


hdx_dataset_list <- function(limit = 5000){
  ckanr::package_list(as = 'table', limit = limit) %>%
    dplyr::as_data_frame(.)
}
