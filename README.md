
# urldiversity

Quantify ‘URL’ Diversity and Apply Popular Biodiversity Indices to a
‘URL’ Collection

## Description

Methods are provided to compute the ‘WSDL Diversity Index’
<http://ws-dl.blogspot.com/2018/05/2018-05-04-exploration-of-url-diversity.html>
along with selected biodiversity indidces to a corpus (collection) of
‘URLs’.

## NOTE

All credit goes to [Alexander Nwala](http://www.cs.odu.edu/~anwala/) for
the algorithm research and [original Python
implementation](https://github.com/anwala/url-diversity).

## TODO

  - \[ \] Handle some edge cases
  - \[ \] Tests
  - \[ \] Better documentation
  - \[ \] Vignette with many citations from the WSDL blog post

## What’s Inside The Tin

The following functions are implemented:

  - `uri_diversity`: Quantify URL diversity

## Installation

``` r
devtools::install_github("hrbrmstr/urldiversity")
```

## Usage

``` r
library(urldiversity)

# current verison
packageVersion("urldiversity")
```

    ## [1] '0.1.0'

``` r
collection <- readLines(system.file("extdat", "corpus.txt", package = "urldiversity"))

print(collection)
```

    ##  [1] "http://www.niaid.nih.gov/topics/ebolaMarburg/understandingEbola/"             
    ##  [2] "http://www.niaid.nih.gov/topics/ebolaMarburg/understandingEbola/"             
    ##  [3] "http://www.niaid.nih.gov/topics/ebolaMarburg/understandingEbola/"             
    ##  [4] "http://www.niaid.nih.gov/topics/ebolaMarburg/understandingEbola/"             
    ##  [5] "http://www.niaid.nih.gov/topics/ebolaMarburg/understandingEbola/"             
    ##  [6] "http://www.cdc.gov/vhf/ebola/pdf/facts-about-ebola-french.pdf"                
    ##  [7] "http://www.cdc.gov/vhf/ebola/pdf/facts-about-ebola-french.pdf"                
    ##  [8] "http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/previous-updates.html"
    ##  [9] "http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/previous-updates.html"
    ## [10] "http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/previous-updates.html"
    ## [11] "http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/previous-updates.html"
    ## [12] "http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/previous-updates.html"
    ## [13] "http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/previous-updates.html"
    ## [14] "http://www.cdc.gov/vhf/ebola/french/2014-west-africa/previous-updates.html"   
    ## [15] "http://www.cdc.gov/vhf/ebola/french/2014-west-africa/previous-updates.html"   
    ## [16] "http://www.cdc.gov/vhf/ebola/french/2014-west-africa/index.html"

``` r
x <- uri_diversity(collection)

dplyr::glimpse(x)
```

    ## List of 8
    ##  $ n_urls                 : int 16
    ##  $ wsdl_uri_diversity     : num 0.267
    ##  $ wsdl_hostname_diversity: num 0.0667
    ##  $ wsdl_domain_diversity  : num 0.0667
    ##  $ simpson_uri_diversity  : num 0.775
    ##  $ shannon_uri_evenness   : num 0.885
    ##  $ simpson_host_diversity : num 0.458
    ##  $ shannon_host_evenness  : num 0.896
    ##  - attr(*, "row.names")= int 1
    ##  - attr(*, "class")= chr "uri_diversity"

``` r
x
```

    ## URI diversity report for 16 URIs:
    ## 
    ## WSDL URI diversity:
    ##   URI: 0.2666667
    ##   Hostname: 0.06666667
    ##   Domain: 0.06666667
    ## 
    ## Simpson's diversity index:
    ##   URI: 0.775
    ##   Unified (Species: URI, Individuals: Paths): 0.4583333
    ## 
    ## Shannon's evenness index:
    ##   URI: 0.8850561
    ##   Unified (Species: URI, Individuals: Paths): 0.8960382

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
