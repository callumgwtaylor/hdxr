#' HDX Resource Shapefile Function
#'
#' This function modify the results of a hdx_resource_list function. It will download the first zipped shapefile found, and load it as a simple features dataframe.
#' @param resources Results of hdx_resource_list
#' @keywords resources hdx
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' hdx_resource_shapefile()


hdx_resource_shapefile <- function(resources){
  # This takes the output of hdx_resource_list and looks for distinct urls to download zipped shapefiles from
  hdx_shapefiles <- resources %>%
    dplyr::mutate(format = stringr::str_to_lower(format)) %>%
    dplyr::filter(format == "zipped shapefile") %>%
    dplyr::distinct(hdx_rel_url, .keep_all = TRUE) %>%
    tidyr::separate(name.resources, into = c("name_resources", "zip"),  sep = "\\.", remove = FALSE) %>%
    dplyr::mutate(hdx_rel_url = stringr::str_replace(hdx_rel_url, "/dataset/", "https://data.humdata.org/dataset/"))



  # This creates a set of variables, that will be referred to at later points
  resource_id <- hdx_shapefiles$id[1]
  file_name <- hdx_shapefiles$name.resources[1]
  folder_name <- hdx_shapefiles$name_resources[1]
  folder_location <- stringr::str_c(c("./", folder_name), collapse = "")

  #This section then extracts the url from the dataframe, downloads and extracts the file that we want
  httr::GET(hdx_shapefiles$hdx_rel_url[1], httr::write_disk(file_name, overwrite=TRUE))
  dir.create(folder_name)
  utils::unzip(file_name, overwrite = TRUE, exdir = folder_name)


  # This section  works out what we've just downloaded and extracts the names
  file_names <- dir(folder_location) %>%
    dplyr::as_data_frame()

  # It takes those names and works out which ones are shp files, and filters them, it then cuts off the .shp bit and turns the result into a list
  shapefile_name <- file_names %>%
    dplyr::mutate(shape_file = stringr::str_detect(value, ".shp$")) %>%
    dplyr::filter(shape_file == TRUE) %>%
    tidyr::separate(value, into = c("shape_file_name", "shape"), sep = "\\.") %>%
    dplyr::select(shape_file_name)


  sf::st_read(dsn = folder_location, layer = shapefile_name[[1,1]]) %>%
    dplyr::mutate(shapefile_name = shapefile_name[[1,1]]) %>%
    dplyr::as_data_frame() %>%
    dplyr::group_by(shapefile_name) %>%
    dplyr::mutate(resource_id = resource_id)
}
