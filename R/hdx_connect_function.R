#' Connect to HDX
#'
#' This function uses ckanr to connect to the humanitarian data
#' exchange.
#'
#' @export
#' @examples
#' hdx_connect()

hdx_connect <- function(...){
  ckanr::ckanr_setup(url = "https://data.humdata.org/")
}
