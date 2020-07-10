## code to prepare `brcancer` dataset goes here
library(haven)
brcancer <- haven::read_dta(file = "http://www.stata-press.com/data/r16/brcancer.dta")
usethis::use_data(brcancer, overwrite = TRUE)
