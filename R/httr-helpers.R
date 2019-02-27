.sGET <- purrr::safely(httr::GET)
.sPOST <- purrr::safely(httr::POST)

#' Safer version of [httr::GET()]
#'
#' Scraping the web is fraught with peril. URLs die; networks get disrupted
#' and best laid plans for building a corups from links can quickly go awry.
#' Use this funtion to mitigate some of the pain of retrieving web resoures.
#'
#' This is a thin wrapper for [httr::GET()] using [purrr::safely()] that will
#' either return a `httr` `response` object or `NULL` if there was an error.
#' If you need the reason for the error (e.g. `Could not resolve host...`)
#' you should write your own wrapper.
#'
#' @md
#' @param url the url of the page to retrieve
#' @param ... Further named parameters, such as \code{query}, \code{path}, etc,
#'   passed on to \code{\link{modify_url}}. Unnamed parameters will be combined
#'   with \code{\link{config}}.
#' @param config Additional configuration settings such as http
#'   authentication (\code{\link{authenticate}}), additional headers
#'   (\code{\link{add_headers}}), cookies (\code{\link{set_cookies}}) etc.
#'   See \code{\link{config}} for full details and list of helpers.
#' @param timeout a call to [httr::timeout()]. Default timeout is `5` seconds.
#' @param handle The handle to use with this request. If not
#'   supplied, will be retrieved and reused from the \code{\link{handle_pool}}
#'   based on the scheme, hostname and port of the url. By default \pkg{httr}
#    automatically reuses the same http connection (aka handle) for mulitple
#'   requests to the same scheme/host/port combo. This substantially reduces
#'   connection time, and ensures that cookies are maintained over multiple
#'   requests to the same host. See \code{\link{handle_pool}} for more
#'   details.
#' @export
safeGET <- function(url = NULL, config = list(),
                    timeout = httr::timeout(5), ..., handle = NULL) {

  res <- .sGET(url = url, config = config, timeout, ..., handle = handle)

  return(res$result)

}

#' Safer version of [httr::POST()]
#'
#' Scraping the web is fraught with peril. URLs die; networks get disrupted
#' and best laid plans for building a corups from links can quickly go awry.
#' Use this funtion to mitigate some of the pain of retrieving web resoures.
#'
#' This is a thin wrapper for [httr::GET()] using [purrr::safely()] that will
#' either return a `httr` `response` object or `NULL` if there was an error.
#' If you need the reason for the error (e.g. `Could not resolve host...`)
#' you should write your own wrapper.
#'
#' @md
#' @inheritParams safeGET
#' @param body One of the following:
#'   \itemize{
#'     \item \code{FALSE}: No body. This is typically not used with \code{POST},
#'       \code{PUT}, or \code{PATCH}, but can be useful if you need to send a
#'       bodyless request (like \code{GET}) with \code{VERB()}.
#'     \item \code{NULL}: An empty body
#'     \item \code{""}: A length 0 body
#'     \item \code{upload_file("path/")}: The contents of a file.  The mime
#'       type will be guessed from the extension, or can be supplied explicitly
#'       as the second argument to \code{upload_file()}
#'     \item A character or raw vector: sent as is in body. Use
#'       \code{\link{content_type}} to tell the server what sort of data
#'       you are sending.
#'     \item A named list: See details for encode.
#'   }
#' @param encode If the body is a named list, how should it be encoded? Can be
#'   one of form (application/x-www-form-urlencoded), multipart,
#'   (multipart/form-data), or json (application/json).
#'
#'   For "multipart", list elements can be strings or objects created by
#'   \code{\link{upload_file}}. For "form", elements are coerced to strings
#'   and escaped, use \code{I()} to prevent double-escaping. For "json",
#'   parameters are automatically "unboxed" (i.e. length 1 vectors are
#'   converted to scalars). To preserve a length 1 vector as a vector,
#'   wrap in \code{I()}. For "raw", either a character or raw vector. You'll
#'   need to make sure to set the \code{\link{content_type}()} yourself.
#' @export
safePOST <- function(url = NULL, config = list(), timeout = httr::timeout(5), ..., body = NULL,
                     encode = c("multipart", "form", "json", "raw"), handle = NULL) {

  res <- .sPOST(url = url, config = config, timeout, ..., body = body,
                encode = encode, handle = handle)

  return(res$result)

}
