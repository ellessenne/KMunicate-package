devtools::load_all()
library(survival)

KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
p <- KMunicate(fit = KM, time_scale = time_scale)
pm1 <- KMunicate(fit = KM, time_scale = time_scale, .reverse = TRUE)

###
devtools::check_win_devel(quiet = TRUE)
devtools::check_win_oldrelease(quiet = TRUE)
devtools::check_win_release(quiet = TRUE)
rhub::check_for_cran()
