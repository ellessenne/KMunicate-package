
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KMunicate

<!-- badges: start -->

<!-- badges: end -->

The goal of {KMunicate} is to produce Kaplan–Meier plots in the style
recommended following the [KMunicate
study](http://dx.doi.org/10.1136/bmjopen-2019-030215) (TP Morris *et
al*. Proposals on Kaplan–Meier plots in medical research and a survey of
stakeholder views: KMunicate. *BMJ Open*, 2019, 9:e030215).

## Installation

You can install {KMunicate} from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ellessenne/KMunicate-package")
```

## Example

``` r
library(survival)
library(KMunicate)
#> 
#> Attaching package: 'KMunicate'
#> The following object is masked from 'package:survival':
#> 
#>     cancer
```

The {KMunicate} package comes with a couple of bundled dataset, `cancer`
and `brcancer`. The main function is named `KMunicate`:

``` r
KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
KMunicate(fit = KM, time_scale = time_scale)
#> Warning: Removed 3 rows containing missing values (geom_text).

#> Warning: Removed 3 rows containing missing values (geom_text).
```

<img src="man/figures/README-brcancer-1.png" width="100%" />

``` r
KM <- survfit(Surv(studytime, died) ~ drug, data = cancer)
time_scale <- seq(0, max(cancer$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale)
#> Warning: Removed 3 rows containing missing values (geom_text).
```

<img src="man/figures/README-cancer-1.png" width="100%" />
