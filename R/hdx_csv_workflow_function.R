#' Load single csv from HDX
#'
#' This function wraps a couple of other hdxr functions. Provided with a string (the end of the hdx dataset url) it will
#' download a csv where available, unnest it and strip it of the hdxr columns.
#'
#'
#' @param hdx Title of dataset (found https://data.humdata.org/dataset/"HERE"), Input in quotation marks
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_csv_workflow(hdx = "total_number_of_reported_malaria_cases")

hdx_csv_workflow <- function(hdx){
  hdx_dataset_search(term = hdx, exact = TRUE) %>%
    hdx_resource_list() %>%
    hdx_resource_csv() %>%
    tidyr::unnest() %>%
    select(-dataset_identifier, -hdx_rel_url, -id)
}
