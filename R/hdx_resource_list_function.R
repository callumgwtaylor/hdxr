#' HDX Resource List Function
#'
#' This function modify the results of a hdx_package_search function. It will expand the resources section and left join that result onto the dataframe provided to it.
#' @param package Results of hdx_package_search in dataframe format
#' @keywords resources hdx
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_resource_list()

hdx_resource_list <- function(package){
  data <- package$resources %>%
    dplyr::bind_rows(.)

  names(data)[names(data) == ""] <- "missing_name"

  data %>%
    dplyr::select(-missing_name) %>%
    dplyr::left_join(., package, by = c("package_id" = "id"), suffix = c(".resources", ".package")) %>%
    dplyr::select(-resources)
}
