devtools::load_all()
library(survival)

KM <- survfit(Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)
p <- KMunicate(fit = KM, time_scale = time_scale, .reverse = TRUE, .risk_table_base_size = 6, .rel_heights = c(6, 1, 1), .legend_position = "none")

ggsave(p, filename = "test.png", height = 7, width = 7, dpi = 300)
