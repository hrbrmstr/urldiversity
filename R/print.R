#' @md
#' @noRd
#' @param x uri_diversity object
#' @param ... unused
#' @export
print.uri_diversity <- function(x, ...) {

  cat(
    with(
      x,
      sprintf(
        "URI diversity report for %s URIs:

WSDL URI diversity:
  URI: %s
  Hostname: %s
  Domain: %s

Simpson's diversity index:
  URI: %s
  Unified (Species: URI, Individuals: Paths): %s

Shannon's evenness index:
  URI: %s
  Unified (Species: URI, Individuals: Paths): %s
",
        format(n_urls, ..., big.mark = ",", scientific = FALSE, trim = TRUE),
        prettyNum(wsdl_uri_diversity),
        prettyNum(wsdl_hostname_diversity),
        prettyNum(wsdl_domain_diversity),
        prettyNum(simpson_uri_diversity),
        prettyNum(simpson_host_diversity),
        prettyNum(shannon_uri_evenness),
        prettyNum(shannon_host_evenness)
      )
    )
  )

}
