## code to prepare `cancer` dataset goes here
library(haven)
cancer2 <- haven::read_dta(file = "http://www.stata-press.com/data/r16/cancer.dta")
cancer2 <- haven::zap_formats(cancer2)
cancer2 <- haven::zap_label(cancer2)
cancer2 <- haven::zap_labels(cancer2)
cancer2 <- haven::zap_missing(cancer2)
cancer2 <- haven::zap_widths(cancer2)
usethis::use_data(cancer2, overwrite = TRUE)
