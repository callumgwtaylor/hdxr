#' HDX Resource CSV Function
#'
#' This function modify the results of a hdx_resource_list function. It will download csvs when available, It will return results in a nested dataframe.
#' @param resources Results of hdx_resource_list
#' @keywords resources hdx
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_resource_list()

hdx_resource_csv <- function(resources){
  hdx_read_url <- function(resources){
    readr::read_csv(resources$hdx_rel_url)
  }

  dplyr::as_data_frame(resources) %>%
    dplyr::select(format, hdx_rel_url, name.resources, name.package) %>%
    dplyr::filter(format == "CSV") %>%
    dplyr::mutate(name.resources = stringr::str_replace_all(name.resources, " ", "_")) %>%
    dplyr::mutate(name.package = stringr::str_replace_all(name.package, " ", "_")) %>%
    dplyr::mutate(name.resources = stringr::str_replace(name.resources, ".csv", ""),
                  hdx_rel_url = stringr::str_replace(hdx_rel_url, "/dataset/", "https://data.humdata.org/dataset/")) %>%
    tidyr::unite(dataset_name, name.package, name.resources, sep = "_", remove = FALSE) %>%
    tidyr::unite(dataset_identifier, name.package, name.resources, sep = "_", remove = TRUE) %>%
    dplyr::select(-format) %>%
    dplyr::group_by(dataset_identifier) %>%
    tidyr::nest(.key = location) %>%
    dplyr::mutate(csv = purrr::map(location, hdx_read_url))
}
