
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KMunicate

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/ellessenne/KMunicate-package.svg?branch=master)](https://travis-ci.com/ellessenne/KMunicate-package)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/ellessenne/KMunicate-package?branch=master&svg=true)](https://ci.appveyor.com/project/ellessenne/KMunicate-package)
[![Codecov test
coverage](https://codecov.io/gh/ellessenne/KMunicate-package/branch/master/graph/badge.svg)](https://codecov.io/gh/ellessenne/KMunicate-package?branch=master)
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
```

The {KMunicate} package comes with a couple of bundled dataset, `cancer`
and `brcancer`. The main function is named `KMunicate`:

``` r
KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
KMunicate(fit = KM, time_scale = time_scale)
```

<img src="man/figures/README-brcancer-1.png" width="100%" />

``` r
KM <- survfit(Surv(studytime, died) ~ drug, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale)
```

<img src="man/figures/README-cancer-1.png" width="100%" />
