## code to prepare `cancer` dataset goes here
library(haven)
cancer <- haven::read_dta(file = "http://www.stata-press.com/data/r16/cancer.dta")
usethis::use_data(cancer, overwrite = TRUE)
