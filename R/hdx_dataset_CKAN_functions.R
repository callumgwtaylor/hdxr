as_ck <- function(x, class) {
  structure(x, class = class)
}

cc <- function(l) Filter(Negate(is.null), l)

ck <- function() 'api/3/action'

ckan_POST <- function(url, method, body = NULL, key = NULL, ...){
  ckan_VERB("POST", url, method, body, key, ...)
}

ckan_VERB <- function(verb, url, method, body, key, ...) {
  VERB <- getExportedValue("httr", verb)
  url <- notrail(url)
  if (is.null(key)) {
    # no authentication
    if (is.null(body) || length(body) == 0) {
      res <- VERB(file.path(url, ck(), method), ctj(), ...)
    } else {
      res <- VERB(file.path(url, ck(), method), body = body, ...)
    }
  } else {
    # authentication
    api_key_header <- httr::add_headers("X-CKAN-API-Key" = key)
    if (is.null(body) || length(body) == 0) {
      res <- VERB(file.path(url, ck(), method), ctj(), api_key_header, ...)
    } else {
      res <- VERB(file.path(url, ck(), method), body = body, api_key_header, ...)
    }
  }
  err_handler(res)
  httr::content(res, "text", encoding = "UTF-8")
}

ctj <- function() httr::content_type_json()

err_handler <- function(x) {
  if (x$status_code > 201) {
    obj <- try({
      err <- jsonlite::fromJSON(httr::content(x, "text", encoding = "UTF-8"))$error
      tmp <- err[names(err) != "__type"]
      errmsg <- paste(names(tmp), unlist(tmp[[1]]))
      list(err = err, errmsg = errmsg)
    }, silent = TRUE)
    if (class(obj) != "try-error") {
      stop(sprintf("%s - %s\n  %s",
                   x$status_code,
                   obj$err$`__type`,
                   obj$errmsg),
           call. = FALSE)
    } else {
      obj <- {
        err <- httr::http_condition(x, "error")
        errmsg <- httr::content(x, "text", encoding = "UTF-8")
        list(err = err, errmsg = errmsg)
      }
      stop(sprintf("%s - %s\n  %s",
                   x$status_code,
                   obj$err[["message"]],
                   obj$errmsg),
           call. = FALSE)
    }
  }
}

jsl <- function(x) jsonlite::fromJSON(x, FALSE)$result

notrail <- function(x) {
  gsub("/+$", "", x)
}

tojun <- function(x, unbox = TRUE) {
  jsonlite::toJSON(x, auto_unbox = unbox)
}





