#' HDX Connect Function
#'
#' This function connects you to the CKAN server for HDX
#' @keywords connect hdx
#' @export
#' @examples
#' hdx_connect()

hdx_connect <- function(){
  ckanr::ckanr_setup(url = "http://data.humdata.org/")
}
