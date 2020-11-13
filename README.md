
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KMunicate

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/ellessenne/KMunicate-package.svg?branch=master)](https://travis-ci.com/ellessenne/KMunicate-package)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/ellessenne/KMunicate-package?branch=master&svg=true)](https://ci.appveyor.com/project/ellessenne/KMunicate-package)
[![Codecov test
coverage](https://codecov.io/gh/ellessenne/KMunicate-package/branch/master/graph/badge.svg)](https://codecov.io/gh/ellessenne/KMunicate-package?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/KMunicate)](https://CRAN.R-project.org/package=KMunicate)
[![CRAN\_Logs\_Badge](http://cranlogs.r-pkg.org/badges/KMunicate)](https://cran.r-project.org/package=KMunicate)
[![CRAN\_Logs\_Badge\_Total](http://cranlogs.r-pkg.org/badges/grand-total/KMunicate)](https://cran.r-project.org/package=KMunicate)
<!-- badges: end -->

The goal of {KMunicate} is to produce Kaplan–Meier plots in the style
recommended following the [KMunicate
study](http://dx.doi.org/10.1136/bmjopen-2019-030215) (TP Morris *et
al*. Proposals on Kaplan–Meier plots in medical research and a survey of
stakeholder views: KMunicate. *BMJ Open*, 2019, 9:e030215).

## Installation

You can install {KMunicate} from
[CRAN](https://CRAN.R-project.org/package=KMunicate) by typing the
following in your R console:

``` r
install.packages("KMunicate")
```

Alternatively, you can install the dev version of {KMunicate} from
[GitHub](https://github.com/ellessenne/KMunicate-package/) with:

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

<img src="man/figures/README-brcancer-1.png" width="90%" style="display: block; margin: auto;" />

``` r
KM <- survfit(Surv(studytime, died) ~ drug, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale)
```

<img src="man/figures/README-cancer-1.png" width="90%" style="display: block; margin: auto;" />

You also might wonder, does this work with a single arm? Yes, yes it
does:

``` r
KM <- survfit(Surv(studytime, died) ~ 1, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale)
```

<img src="man/figures/README-cancer-single-1.png" width="90%" style="display: block; margin: auto;" />

Finally, you can also plot 1 - survival by using the argument
`.reverse = TRUE`:

``` r
KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
KMunicate(fit = KM, time_scale = time_scale, .reverse = TRUE)
```

<img src="man/figures/README-brcancer-reverse-1.png" width="90%" style="display: block; margin: auto;" />

## Customise Risk Table

By default, `KMunicate()` will build a risk table conform to the
KMunicate style, e.g., with cumulative number of events and censored
(the column-wise sum is equal to the total number of individuals at risk
per arm):

``` r
KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
KMunicate(fit = KM, time_scale = time_scale)
```

<img src="man/figures/README-brcancer-KMunicate-1.png" width="90%" style="display: block; margin: auto;" />

Alternatively, it is possible to customise the risk table via the
`.risk_table` argument. For instance, if one wants to have interval-wise
number of events and censored, just pass the `survfit` value to the
`.risk_table` argument:

``` r
KMunicate(fit = KM, time_scale = time_scale, .risk_table = "survfit")
```

<img src="man/figures/README-brcancer-survfit-1.png" width="90%" style="display: block; margin: auto;" />

This is the default output of the `summary.survfit()` function.

Finally, it is also possible to fully omit the risk table by setting
`.risk_table = NULL`:

``` r
KMunicate(fit = KM, time_scale = time_scale, .risk_table = NULL)
```

<img src="man/figures/README-brcancer-NULL-1.png" width="90%" style="display: block; margin: auto;" />

## Custom Fonts

Assuming you have set up your computer to use custom fonts with
`ggplot2`, customising your KMunicate-style plot is trivial. All you
have to do is pass the font name as the `.ff` argument:

``` r
KM <- survfit(Surv(studytime, died) ~ 1, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale, .ff = "Victor Mono")
```

<img src="man/figures/README-cancer-single-ff-1.png" width="90%" style="display: block; margin: auto;" />

## Furter customisation

Several options to further customise each plot are provided, see
e.g. the introductory vignette for more details.
