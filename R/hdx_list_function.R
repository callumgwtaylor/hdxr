#' HDX List Function
#'
#' This function will create a data frame of package titles
#' @param limit Limit of packages to search for. Defaults to 5000
#' @keywords list hdx
#' @export
#' @examples
#' hdx_list()


hdx_list <- function(limit = 5000){
  ckanr::package_list(as = 'table', limit = limit) %>%
    as_data_frame(.)
}
