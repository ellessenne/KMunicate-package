devtools::load_all()
library(survival)

KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
KMunicate(fit = KM, time_scale = time_scale)

KM <- survfit(Surv(studytime, died) ~ drug, data = cancer)
time_scale <- seq(0, max(cancer$studytime), by = 7)
KMunicate(fit = KM, time_scale = time_scale)
