devtools::load_all()
library(survival)

KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
p <- KMunicate(fit = KM, time_scale = time_scale)
ggsave(p, filename = "test.pdf", height = 7, width = 7 / sqrt(2))

p2 <- KMunicate(fit = KM, time_scale = time_scale, .risk_table = "survfit")
ggsave(p2, filename = "test2.pdf", height = 7, width = 7 / sqrt(2))

p3 <- KMunicate(fit = KM, time_scale = time_scale, .risk_table = NULL)
ggsave(p3, filename = "test3.pdf", height = 7, width = 7 / sqrt(2))


KM <- survfit(Surv(studytime, died) ~ drug, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
p <- KMunicate(fit = KM, time_scale = time_scale)
ggsave(p, filename = "test.pdf", height = 7, width = 7 / sqrt(2))

KM <- survfit(Surv(studytime, died) ~ 1, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale)

KM <- survfit(Surv(studytime, died) ~ 1, data = cancer2)
time_scale <- seq(0, max(cancer2$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale, .ff = "Victor Mono")

###
devtools::check_win_devel(quiet = TRUE)
devtools::check_win_oldrelease(quiet = TRUE)
devtools::check_win_release(quiet = TRUE)
rhub::check_for_cran()
