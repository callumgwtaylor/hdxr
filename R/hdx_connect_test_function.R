#' Connect to HDX
#'
#' This function uses ckanr to connect to the test version of humanitarian data
#' exchange.
#'
#' @export
#' @examples
#' hdx_connect_test()

hdx_connect_test <- function(...){
  ckanr::ckanr_setup(url = "https://test-data.humdata.org/")
}
