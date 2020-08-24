devtools::load_all()
library(survival)

KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
p <- KMunicate(fit = KM, time_scale = time_scale)
KMunicate(fit = KM, time_scale = time_scale, .reverse = TRUE, .risk_table_base_size = 10, .rel_heights = c(5, 1, 1))

###
devtools::check_win_devel(quiet = TRUE)
devtools::check_win_oldrelease(quiet = TRUE)
devtools::check_win_release(quiet = TRUE)
rhub::check_for_cran()
