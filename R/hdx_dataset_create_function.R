#' Create a Dataset on HDX
#'
#' This function will create a dataset on HDX. This function was created by ROpenSci in their CKANR package.
#' This version simply has an additional argument for dataset_source.
#' It requires a name, a dataset_source, an owner_org.
#'
#' @export
#' @examples
#' hdx_dataset_create()


hdx_dataset_create <- function(name = NULL, title = NULL, author = NULL, author_email = NULL,
                           maintainer = NULL, maintainer_email = NULL, license_id = NULL, notes = NULL, package_url = NULL,
                           version = NULL, state = "active", type = NULL, resources = NULL, tags = NULL, extras = NULL,
                           relationships_as_object = NULL, relationships_as_subject = NULL, groups = NULL,
                           owner_org = NULL, key = get_default_key(), url = get_default_url(), dataset_source = NULL, as = 'list', ...) {

  body <- cc(list(name = name, title = title, dataset_source = dataset_source, author = author, author_email = author_email,
                  maintainer = maintainer, maintainer_email = maintainer_email, license_id = license_id,
                  notes = notes, url = package_url, version = version, state = state, type = type,
                  resources = resources, tags = tags, extras = extras,
                  relationships_as_object = relationships_as_object,
                  relationships_as_subject = relationships_as_subject, groups = groups,
                  owner_org = owner_org))
  res <- ckan_POST(url, 'package_create',
                   body = tojun(body, TRUE), key = key,
                   encode = "json", ctj(), ...)
  switch(as, json = res, list = as_ck(jsl(res), "ckan_package"), table = jsd(res))
}
