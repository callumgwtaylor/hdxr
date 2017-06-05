#' HDX Resource List Function
#'
#' This function modify the results of a hdx_package_search function. It will expand the resources section and left join that result onto the dataframe provided to it.
#' @param package Results of hdx_package_search in dataframe format
#' @keywords resources hdx
#' @export
#' @examples
#' hdx_resource_list()

hdx_resource_list <- function(package){
  package$resources %>%
    bind_rows(.) %>%
    left_join(package, ., by = c("id" = "package_id"), suffix = c(".package", ".resources")) %>%
    select(-resources)
}
