#' HDX Dataset List Function
#'
#' This function will create a data frame of package titles
#' @param limit Limit of packages to search for. Defaults to 5000
#' @keywords list hdx
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_datasetlist()


hdx_dataset_list <- function(limit = 5000){
  ckanr::package_list(as = 'table', limit = limit) %>%
    dplyr::as_data_frame(.)
}
