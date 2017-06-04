#' HDX Connect Function
#'
#' This function connects you to the CKAN server for HDX
#' @param NONE
#' @keywords connect hdx
#' @export
#' @examples
#' hdx_connect()

hdx_connect <- function(){
  ckanr_setup(url = "http://data.humdata.org/")
}
