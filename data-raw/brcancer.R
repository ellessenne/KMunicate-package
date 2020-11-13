## code to prepare `brcancer` dataset goes here
library(haven)
brcancer <- haven::read_dta(file = "http://www.stata-press.com/data/r16/brcancer.dta")
brcancer <- haven::zap_formats(brcancer)
brcancer <- haven::zap_label(brcancer)
brcancer <- haven::zap_labels(brcancer)
brcancer <- haven::zap_missing(brcancer)
brcancer <- haven::zap_widths(brcancer)
usethis::use_data(brcancer, overwrite = TRUE)
