#' @keywords internal
.extract_summary_data <- function(fit, time_scale) {
  summ <- summary(fit, times = time_scale, extend = TRUE)
  d <- data.frame(
    time = summ$time,
    n.risk = summ$n.risk,
    n.event = summ$n.event,
    n.censor = summ$n.censor
  )
  if ("strata" %in% names(fit)) {
    d$strata <- summ$strata
    d$strata <- factor(d$strata, levels = levels(d$strata), labels = gsub(".*=", "", levels(d$strata)))
  }
  return(d)
}
