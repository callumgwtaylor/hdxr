README
================
Callum Taylor
8 June 2017

hdxr
====

A package, storing functions to make my life easier when getting data from Humanitarian Data Exchange

I have uploaded this to share the code I made for this [post](https://callumgwtaylor.github.io/blog/2017/06/04/getting-data-from-humanitarian-data-exchange-in-a-reproducible-r-pipeline/)

I found it useful for me, but I could see it being messy and frustrating for others! If you read my post and wanted to use these functions, then you're very welcome to try using this mini package. But this is **not** neat and **not** polished. It also might not work for you or your needs! This package will be continually updated over the next while until we think it's vaguely reliable.

Installation: `library(devtools)` `install_github("callumgwtaylor/hdxr")`

if you haven't already got these then you'll need them also: `install.packages("ckanr")` `install.packages("jsonlite")`

Load:

    library(hdxr)

Usage:

``` r
# Connect to the HDX server
hdx_connect()

# Download a list of packages available from HDX
list <- hdx_list(500)

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
hum_data <- hdx_package_search("ACLED Conflict Data") %>%
  filter(title == "ACLED Conflict Data for Algeria")

names(hum_data)
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
hum_resoures <- hdx_resource_list(hum_data)

# The results can also be piped:
hum_resources <- hdx_package_search("ACLED Conflict Data") %>%
  hdx_resource_list()

names(hum_resoures)
```

    ##  [1] "data_update_frequency"            
    ##  [2] "license_title"                    
    ##  [3] "maintainer"                       
    ##  [4] "relationships_as_object"          
    ##  [5] "package_creator"                  
    ##  [6] "private"                          
    ##  [7] "dataset_date"                     
    ##  [8] "num_tags"                         
    ##  [9] "solr_additions"                   
    ## [10] "id"                               
    ## [11] "metadata_created"                 
    ## [12] "methodology_other"                
    ## [13] "caveats"                          
    ## [14] "metadata_modified"                
    ## [15] "author"                           
    ## [16] "author_email"                     
    ## [17] "subnational"                      
    ## [18] "state.package"                    
    ## [19] "methodology"                      
    ## [20] "version"                          
    ## [21] "dataset_source"                   
    ## [22] "license_id"                       
    ## [23] "type"                             
    ## [24] "num_resources"                    
    ## [25] "tags"                             
    ## [26] "groups"                           
    ## [27] "creator_user_id"                  
    ## [28] "maintainer_email"                 
    ## [29] "relationships_as_subject"         
    ## [30] "name.package"                     
    ## [31] "isopen"                           
    ## [32] "url.package"                      
    ## [33] "notes"                            
    ## [34] "owner_org"                        
    ## [35] "license_url"                      
    ## [36] "title"                            
    ## [37] "revision_id.package"              
    ## [38] "tracking_summary.total.package"   
    ## [39] "tracking_summary.recent.package"  
    ## [40] "organization.description"         
    ## [41] "organization.created"             
    ## [42] "organization.title"               
    ## [43] "organization.name"                
    ## [44] "organization.is_organization"     
    ## [45] "organization.state"               
    ## [46] "organization.image_url"           
    ## [47] "organization.revision_id"         
    ## [48] "organization.type"                
    ## [49] "organization.id"                  
    ## [50] "organization.approval_status"     
    ## [51] "cache_last_updated"               
    ## [52] "webstore_last_updated"            
    ## [53] "id.resources"                     
    ## [54] "size"                             
    ## [55] "revision_last_updated"            
    ## [56] "state.resources"                  
    ## [57] "hash"                             
    ## [58] "description"                      
    ## [59] "format"                           
    ## [60] "hdx_rel_url"                      
    ## [61] "last_modified"                    
    ## [62] "url_type"                         
    ## [63] "mimetype"                         
    ## [64] "cache_url"                        
    ## [65] "name.resources"                   
    ## [66] "created"                          
    ## [67] "url.resources"                    
    ## [68] "webstore_url"                     
    ## [69] "mimetype_inner"                   
    ## [70] "position"                         
    ## [71] "revision_id.resources"            
    ## [72] "resource_type"                    
    ## [73] "tracking_summary.total.resources" 
    ## [74] "tracking_summary.recent.resources"

``` r
# You can use column `format` to filter for the type of data you want
hum_resoures$format
```

    ## [1] "XLSX"

``` r
# You can use column `hdx_rel_url` to find the address of the resource you want
hum_resoures$hdx_rel_url
```

    ## [1] "http://www.acleddata.com/wp-content/uploads/2016/01/Algeria.xlsx"
