README
================
Callum Taylor
2 July 2017

hdxr
====

hdxr is a package designed to allow you to interact with Humanitarian Data Exchange (HDX) in R, allowing for more reproducible workflow with humanitarian data.

Currently it has functions, that can read information from:

-   Datasets
-   Resources

Installation:

`library(devtools)`

`install_github("callumgwtaylor/hdxr")`

Load:

`library(hdxr)`

Connecting to HDX
-----------------

HDX uses CKAN to store data, and to connect to its server you first use:

`hdx_connect()`

This simply uses the ckanr command `ckanr_setup()`, specifying HDX

Datasets
--------

### Listing Datasets

To see what datasets are available on HDX, use:

`hdx_dataset_list()`

This will provide a dataframe, with a column containing the first 5000 titles of datasets available (use the `limit` argument to get more than 5000)

### Retreiving Datasets

To download further information about a dataset, use:

`hdx_dataset_search(term = "blah")`

This will retrieve a dataframe of the first 10 datasets that have titles similar to the provided search term.

To return more than 10 results use the `rows` argument.

When you know the correct title, and only want that result, use the `exact` argument.

`hdx_dataset_search(term = "afghanistan-roads", exact = TRUE)`

Resources
---------

### Extracting Resources

Once you've selected the dataset you want using the `hdx_dataset_search()` function, you can extract information about the resources (the data files themselves) using:

`hdx_resource_list()`

This can be piped, in a situation like:

``` r
hdx_dataset_search(term = "afghanistan-roads", exact = TRUE) %>%
  hdx_resource_list()
```

This will provide a dataframe, with one line for each resource found, joined on to the initial information about the datasets.

### Loading CSV

The `hdx_resource_csv()` function will take the results of `hdx_resource_list()`, select the resources that are csv, and download them into the environment, as a nested dataframe. You can use this function to load multiple csv files into the environment at once.

Once downloaded, you can then unnest the csv file you want to explore further:

``` r
afghanistan <- hdx_dataset_search(term = "ocha-afghanistan-topline-figures") %>%
  hdx_resource_list() %>%
  hdx_resource_csv()

afghanistan[1,] %>%
  unnest()
```

### Loading Shapefiles

The `hdx_resource_shapefile()` function will take the results of `hdx_resource_list()`, select the resources that are zipped shapefiles, and download the first one. It will unzip it into its own folder, then load the shapefiles into the environment using simple features.

``` r
afghanistan <- hdx_dataset_search(term = "afghanistan-roads") %>%
  hdx_resource_list() %>%
  hdx_resource_shapefile()
```

Example Usage
=============

``` r
hdx_connect()

list <- hdx_dataset_list(500)

dim(list)
```

    ## [1] 500   1

``` r
head(list)
```

    ## # A tibble: 6 x 1
    ##                                                                         value
    ##                                                                         <chr>
    ## 1                                       141121-sierra-leone-health-facilities
    ## 2                                      160516-ecuador-earthquake-4w-1st-round
    ## 3                                                      160523-ocha-4w-round-2
    ## 4                                                     160625-hrrp-4w-national
    ## 5 1999-2013-tally-of-internaly-displaced-persons-resulting-from-natural-disas
    ## 6                                                                  2011-nepal

``` r
# Search for a specific package, then filter by title using dplyr
dataset <- hdx_dataset_search("ACLED Conflict Data") %>%
  filter(title == "ACLED Conflict Data for Algeria")

# Or if you know the exact name, search directly for that

dataset <- hdx_dataset_search("acled-conflict-data-for-algeria", exact = TRUE)

names(dataset)
```

    ##  [1] "data_update_frequency"        "license_title"               
    ##  [3] "maintainer"                   "relationships_as_object"     
    ##  [5] "package_creator"              "private"                     
    ##  [7] "dataset_date"                 "num_tags"                    
    ##  [9] "solr_additions"               "id"                          
    ## [11] "metadata_created"             "methodology_other"           
    ## [13] "caveats"                      "metadata_modified"           
    ## [15] "author"                       "author_email"                
    ## [17] "subnational"                  "state"                       
    ## [19] "methodology"                  "version"                     
    ## [21] "dataset_source"               "license_id"                  
    ## [23] "type"                         "resources"                   
    ## [25] "num_resources"                "tags"                        
    ## [27] "groups"                       "creator_user_id"             
    ## [29] "maintainer_email"             "relationships_as_subject"    
    ## [31] "name"                         "isopen"                      
    ## [33] "url"                          "notes"                       
    ## [35] "owner_org"                    "license_url"                 
    ## [37] "title"                        "revision_id"                 
    ## [39] "tracking_summary.total"       "tracking_summary.recent"     
    ## [41] "organization.description"     "organization.created"        
    ## [43] "organization.title"           "organization.name"           
    ## [45] "organization.is_organization" "organization.state"          
    ## [47] "organization.image_url"       "organization.revision_id"    
    ## [49] "organization.type"            "organization.id"             
    ## [51] "organization.approval_status"

``` r
# Expand the resources section from the search you just performed
resources <- hdx_resource_list(dataset)

# The results can also be piped:
resources <- hdx_dataset_search("acled-conflict-data-for-algeria", exact = TRUE) %>%
  hdx_resource_list()

names(resources)
```

    ##  [1] "cache_last_updated"               
    ##  [2] "package_id"                       
    ##  [3] "webstore_last_updated"            
    ##  [4] "id"                               
    ##  [5] "size"                             
    ##  [6] "revision_last_updated"            
    ##  [7] "state.resources"                  
    ##  [8] "hash"                             
    ##  [9] "description"                      
    ## [10] "format"                           
    ## [11] "hdx_rel_url"                      
    ## [12] "last_modified"                    
    ## [13] "url_type"                         
    ## [14] "mimetype"                         
    ## [15] "cache_url"                        
    ## [16] "name.resources"                   
    ## [17] "created"                          
    ## [18] "url.resources"                    
    ## [19] "webstore_url"                     
    ## [20] "mimetype_inner"                   
    ## [21] "position"                         
    ## [22] "revision_id.resources"            
    ## [23] "resource_type"                    
    ## [24] "tracking_summary.total.resources" 
    ## [25] "tracking_summary.recent.resources"
    ## [26] "data_update_frequency"            
    ## [27] "license_title"                    
    ## [28] "maintainer"                       
    ## [29] "relationships_as_object"          
    ## [30] "package_creator"                  
    ## [31] "private"                          
    ## [32] "dataset_date"                     
    ## [33] "num_tags"                         
    ## [34] "solr_additions"                   
    ## [35] "metadata_created"                 
    ## [36] "methodology_other"                
    ## [37] "caveats"                          
    ## [38] "metadata_modified"                
    ## [39] "author"                           
    ## [40] "author_email"                     
    ## [41] "subnational"                      
    ## [42] "state.package"                    
    ## [43] "methodology"                      
    ## [44] "version"                          
    ## [45] "dataset_source"                   
    ## [46] "license_id"                       
    ## [47] "type"                             
    ## [48] "num_resources"                    
    ## [49] "tags"                             
    ## [50] "groups"                           
    ## [51] "creator_user_id"                  
    ## [52] "maintainer_email"                 
    ## [53] "relationships_as_subject"         
    ## [54] "name.package"                     
    ## [55] "isopen"                           
    ## [56] "url.package"                      
    ## [57] "notes"                            
    ## [58] "owner_org"                        
    ## [59] "license_url"                      
    ## [60] "title"                            
    ## [61] "revision_id.package"              
    ## [62] "tracking_summary.total.package"   
    ## [63] "tracking_summary.recent.package"  
    ## [64] "organization.description"         
    ## [65] "organization.created"             
    ## [66] "organization.title"               
    ## [67] "organization.name"                
    ## [68] "organization.is_organization"     
    ## [69] "organization.state"               
    ## [70] "organization.image_url"           
    ## [71] "organization.revision_id"         
    ## [72] "organization.type"                
    ## [73] "organization.id"                  
    ## [74] "organization.approval_status"

``` r
# You can use column `format` to filter for the type of data you want
resources$format
```

    ## [1] "XLSX"

``` r
# You can use column `hdx_rel_url` to find the address of the resource you want
resources$hdx_rel_url
```

    ## [1] "http://www.acleddata.com/wp-content/uploads/2016/01/Algeria.xlsx"

``` r
# You can use hdx_resource_csv to download csv files from the server into a nested dataframe. This can all be done in a pipeline.

kenya <- hdx_dataset_search("kenya-conflict-2012-2014", exact = TRUE) %>%
  hdx_resource_list() %>%
  hdx_resource_csv()
```

    ## Warning: Missing column names filled in: 'X17' [17], 'X18' [18],
    ## 'X19' [19], 'X20' [20], 'X21' [21], 'X22' [22], 'X23' [23], 'X24' [24],
    ## 'X25' [25], 'X26' [26], 'X27' [27], 'X28' [28]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_character(),
    ##   Year = col_integer(),
    ##   Month = col_integer(),
    ##   Day = col_integer(),
    ##   Deaths = col_integer(),
    ##   Injuries = col_integer(),
    ##   Affected = col_integer()
    ## )

    ## See spec(...) for full column specifications.

``` r
kenya
```

    ## # A tibble: 1 x 4
    ##                                             dataset_identifier
    ##                                                          <chr>
    ## 1 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ## # ... with 3 more variables: hdx_rel_url <chr>, id <chr>, csv <list>

``` r
kenya %>%
  unnest()
```

    ## # A tibble: 5,414 x 31
    ##                                              dataset_identifier
    ##                                                           <chr>
    ##  1 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  2 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  3 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  4 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  5 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  6 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  7 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  8 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ##  9 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ## 10 kenya-conflict-2012-2014_KEN_conflict_2012_to_date_26Jan2015
    ## # ... with 5,404 more rows, and 30 more variables: hdx_rel_url <chr>,
    ## #   id <chr>, Date <chr>, Year <int>, Month <int>, Day <int>,
    ## #   Country <chr>, `Admin 1` <chr>, Location <chr>, Deaths <int>,
    ## #   Injuries <int>, Displaced <chr>, Affected <int>, Source <chr>,
    ## #   Other <chr>, `Humanitarian Response` <chr>, `Livestock Deaths` <chr>,
    ## #   `Houses Burnt` <chr>, X17 <chr>, X18 <chr>, X19 <chr>, X20 <chr>,
    ## #   X21 <chr>, X22 <chr>, X23 <chr>, X24 <chr>, X25 <chr>, X26 <chr>,
    ## #   X27 <chr>, X28 <chr>

``` r
# You can use hdx_resource_shapefiles to download the first shapefile from the server into a simple features pipeline. This can all be done in a pipeline.

afghanistan <- hdx_dataset_search("afghanistan-roads", exact = TRUE) %>%
  hdx_resource_list() %>%
  hdx_resource_shapefile()
```

    ## Warning in dir.create(folder_name): 'afg_roads_lin_aims_osmap' already
    ## exists

    ## Reading layer `afg_roads_lin_oasis_osmap' from data source `\R\hdxr\afg_roads_lin_aims_osmap' using driver `ESRI Shapefile'
    ## replacing null geometries with empty geometries
    ## Simple feature collection with 6645 features and 9 fields (with 3 geometries empty)
    ## geometry type:  GEOMETRY
    ## dimension:      XY
    ## bbox:           xmin: 60.49997 ymin: 29.49975 xmax: 74.69596 ymax: 38.48688
    ## epsg (SRID):    4326
    ## proj4string:    +proj=longlat +datum=WGS84 +no_defs

``` r
afghanistan 
```

    ## # A tibble: 6,645 x 12
    ## # Groups:   shapefile_name [1]
    ##    OBJECTID      ID_ NAME1_ NAME2_ PARTS_ POINTS_   LENGTH_ CLASS
    ##       <int>   <fctr> <fctr> <fctr>  <int>   <int>     <dbl> <int>
    ##  1        1 AFG33230     R1     NA      1       5  0.438227     1
    ##  2        2 AFG23694    H-R   1385      1     170 30.051210     1
    ##  3        3 AFG24159    H-R   1785      1     135 20.794200     2
    ##  4        4     A-93    R-A   1583      1      37  9.424366     1
    ##  5        5     A-89    R-A   1482      1      54 12.570490     1
    ##  6        6     A-81    R-A   1378      1       2  0.157600     3
    ##  7        7     A-87    R-A   1377      1      89 13.149750     1
    ##  8        8     A-88    R-A   1381      1      17  3.001055     2
    ##  9        9     A-86    R-A   1481      1      11  3.426427     2
    ## 10       10     A-80    R-A   1681      1     148 37.295630     1
    ## # ... with 6,635 more rows, and 4 more variables: Shape_Leng <dbl>,
    ## #   geometry <S3: sfc_GEOMETRY>, shapefile_name <chr>, resource_id <chr>
