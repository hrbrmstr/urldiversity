c(
  "wsdl_uri_diversity",
  "wsdl_hostname_diversity",
  "wsdl_domain_diversity",
  "simpson_uri_diversity",
  "shannon_uri_evenness",
  "simpson_host_diversity",
  "shannon_host_evenness"
) -> .urid_levels

c(
  "WSDL URI Diversity",
  "WSDL Hostname Diversity",
  "WSDL Domain Diversity",
  "Simpson URI Diversity",
  "Shannon URI Evenness",
  "Simpson Host Diversity",
  "Shannon Host Evenness"
) -> .urid_labels

#' Clean up diversity and evenness names
#'
#' Snake-case names are great for coding but look terrible in
#' tables and plots. Use this function to turn the WSDL,
#' Shannon and Simpson snake-case index labels into Title Case Versions
#' of themselves.
#'
#' @md
#' @param x a character vector of snake-case WSDL, Simpson and Shannon
#'        index names (i.e. that came from a call to [uri_diversity()]).
#' @param newline if `TRUE` the Title Case Versions will be separated by
#'        a newline ("`\\n`") vs a space.
#' @export
clean_index_factors <- function(x, newline = FALSE) {

  factor(
    x,
    levels = .urid_levels,
    labels = if (newline) gsub(" ", "\n", .urid_labels)
  )

}
