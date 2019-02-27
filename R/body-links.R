#' Extract all body anchor hypertext references
#'
#' Given a valid HTML/XML document, node set or single node, a
#' claracter vector of all `<body>` `<a href>` URLs will be returned.
#' If `base` is not `NULL` all relative URLs will be converted
#' to absolute URLs.
#'
#' @md
#' @param x Either a document, a node set or a single node.
#' @param unique if `TRUE`, then only unique URLs will be returned. Default: `FALSE`.
#' @param base if not `NULL`, all relative URLs will be converted
#'        to absolute URLs. Default: `NULL`.
#' @return character vector of extracted URLs; if no `<a>` `href` URLs were discovered
#'         `charactrer(0)` will be returned.
#' @export
#' @examples
#' x <- rvest::read_html("https://congress.gov/")
#' body_anchor_urls(x, unique = TRUE, base = "https://congress.gov/")
body_anchor_urls <- function(x, unique = FALSE, base = NULL) {

  rvest::html_nodes(x, xpath=".//body//a") %>%
    rvest::html_attr("href") -> res

  if (length(res) > 0) {

    if (unique) res <- unique(res)

    if (!is.null(base)) res <- xml2::url_absolute(res, base)

  } else {
    res <- character(0)
  }

  res

}