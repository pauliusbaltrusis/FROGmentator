
<!-- README.md is generated from README.Rmd. Please edit that file -->

# FROGmentor

<!-- badges: start -->
<!-- badges: end -->

The goal of FROGmentator is to …

## Installation

You can install the development version of FROGmentator from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("pauliusbaltrusis/FROGmentator")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(FROGmentator)
#
library(tidyverse)
library(ggplot2)
library(ggpubr)
# 
my_DNA<-gen_DNA(10000)
pattern1<-'GATC'
FROG_pal_output<-FROG_pal(my_DNA, pattern1)

head(FROG_pal_output) # fragment length sizes
#> [1] 203  79 177   8 306 254
```

``` r
FROG_plot(FROG_pal_output, pattern1)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />
