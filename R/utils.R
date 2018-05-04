canonicalize_uri <- function(server, path, query, exception_domains = c("youtube.com")) {
  sprintf(
    "%s%s%s",
    server,
    path,
    ifelse(server %in% exception_domains, sprintf("?%s", query), "")
  )
}

canonicalize_host <- function(subdomain=NULL, domain, suffix) {

  if (!is.null(subdomain)) {
    purrr::pmap_chr(list(subdomain, domain, suffix), ~{
      ..1 <- if (is.na(..1)) NULL else ..1
      ..2 <- if (is.na(..3)) NULL else ..2
      ..3 <- if (is.na(..3)) NULL else ..3
      paste0(c(..1, ..2, ..3), collapse=".")
    })
  } else {
    purrr::pmap_chr(list(domain, suffix), ~{
      ..1 <- if (is.na(..1)) NULL else ..1
      ..2 <- if (is.na(..2)) NULL else ..2
      paste0(c(..1, ..2), collapse=".")
    })
  }

}
