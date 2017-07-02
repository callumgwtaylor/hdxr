#' Expand resources from HDX Dataset Search
#'
#' This function modify the results of a hdx_dataset_search function.
#' It will expand the resources section and left join these results onto the original dataframe.
#' @param package Results of hdx_dataset_search in dataframe format
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_dataset_search() %>% hdx_resource_list()

hdx_resource_list <- function(package){
  resources_data <- package$resources %>%
    dplyr::bind_rows(.)

  valid_column_names <- make.names(names=names(resources_data), unique=TRUE, allow_ = TRUE)
  names(resources_data) <- valid_column_names

  resources_data <- resources_data %>%
    dplyr::left_join(., package, by = c("package_id" = "id"), suffix = c(".resources", ".package")) %>%
    dplyr::select(-resources)

  valid_column_names <- make.names(names=names(resources_data), unique=TRUE, allow_ = TRUE)
  names(resources_data) <- valid_column_names

  resources_data
}
