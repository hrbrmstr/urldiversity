#' Quantify 'URL' Diversity and Apply Popular Biodiversity Indices to a 'URL' Collection
#'
#' Methods are provided to compute the 'WSDL Diversity Index' <http://ws-dl.blogspot.com/2018/05/2018-05-04-exploration-of-url-diversity.html>
#' along with selected biodiversity indidces to a corpus (collection) of 'URLs'.
#'
#' @md
#' @name urldiversity
#' @docType package
#' @author Alexander Nwala (anwala@@cs.odu.edu); Bob Rudis (bob@@rud.is)
#' @importFrom purrr pmap %>%
#' @importFrom urltools suffix_extract
#' @importFrom dplyr count data_frame mutate summarise bind_cols
#' @importFrom xml2 url_parse
#' @importFrom utils globalVariables
#' @references <http://ws-dl.blogspot.com/2018/05/2018-05-04-exploration-of-url-diversity.html>
NULL
