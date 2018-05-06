#' Quantify URL diversity
#'
#' Compute WSDL Diversity Index, Shannon's evenness index, and Simpson's diversity index
#' for a corpus (collection) of URLs.
#'
#' @md
#' @param corpus a collection (character vector) of URLs
#' @param exception_domains a character vector of domains; use this to specify domains
#'     where the query string is important. Normally, the query string is excluded from
#'     the canonicalized URI but in some cases (e.g. `youtube.com`) it is desirable
#'     to have the query string influence the diversity computations.
#' @return a data frame (tibble) with WSDL, Shannon and Simpson diversity indices for
#'    canonical URIs and hostnames.
#' @references <http://ws-dl.blogspot.com/2018/05/2018-05-04-exploration-of-url-diversity.html>
#' @note Algorithm creator: [Alexander C. Nwala](https://twitter.com/acnwala)
#' @author Alexander Nwala (anwala@@cs.odu.edu); Bob Rudis (bob@@rud.is)
#' @export
#' @examples
#' collection <- readLines(system.file("extdat", "corpus.txt", package = "urldiversity"))
#' uri_diversity(collection)
uri_diversity <- function(corpus, exception_domains = NULL) {

  xml2::url_parse(corpus) %>%
    dplyr::bind_cols(urltools::suffix_extract(.$server)) %>%
    dplyr::mutate(
      uri_canon = canonicalize_uri(server, path, query, exception_domains),
      host_canon = canonicalize_host(subdomain, domain, suffix),
      domain_canon = canonicalize_host(domain = domain, suffix = suffix)
    ) -> collection_df

  N <- nrow(collection_df)

  dplyr::bind_cols(

    # WSDL URI diversity
    dplyr::data_frame(
      n_urls = N,
      wsdl_uri_diversity = (length(unique(collection_df$uri_canon)) - 1) / (N - 1),
      wsdl_hostname_diversity = (length(unique(collection_df$host_canon)) - 1) / (N - 1),
      wsdl_domain_diversity = (length(unique(collection_df$domain_canon)) - 1) / (N - 1)
    )

    ,

    # Simpson's diversity & Shannon's evenness index for canonical URIs
    dplyr::count(collection_df, uri_canon) %>%
      dplyr::summarise(
        summation_over_species = sum(n * (n-1)),
        summation_over_prop_species = sum((n/N) * (log(n/N))),
        max_evennness = log(n())
      ) %>%
      dplyr::summarise(
        simpson_uri_diversity =
          if (N == 1) 0 else 1 - (summation_over_species / (N * (N - 1))),
        shannon_uri_evenness =
          if (max_evennness == 0) 0 else (-summation_over_prop_species)/max_evennness
      )

    ,

    # Simpson's diversity & Shannon's evenness index for canonical hostnames
    dplyr::count(collection_df, host_canon) %>%
      dplyr::summarise(
        summation_over_species = sum(n * (n-1)),
        summation_over_prop_species = sum((n/N) * (log(n/N))),
        max_evennness = log(n())
      ) %>%
      dplyr::summarise(
        simpson_host_diversity =
          if (N == 1) 0 else 1 - (summation_over_species / (N * (N - 1))),
        shannon_host_evenness =
          if (max_evennness == 0) 0 else (-summation_over_prop_species)/max_evennness
      )

  ) -> out

  class(out) <- c("uri_diversity", "tbl_df", "tbl", "data.frame")

  out

}

