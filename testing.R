devtools::load_all()
library(survival)

KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
p <- KMunicate(fit = KM, time_scale = time_scale, .reverse = TRUE, .title = "Here is a title")
ggsave(p, filename = "test.png", dev = ragg::agg_png, height = 7, width = 7, dpi = 300)

p2 <- KMunicate(fit = KM, time_scale = time_scale, .reverse = TRUE)
ggsave(p2, filename = "test2.png", dev = ragg::agg_png, height = 7, width = 7, dpi = 300)
