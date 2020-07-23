#' @keywords internal
.extract_summary_data <- function(fit, time_scale, risk_table) {
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
  # Use cumulative n.event and n.censor if risk_table == "KMunicate"
  if (risk_table == "KMunicate") {
    if ("strata" %in% names(fit)) {
      dsplit <- split(x = d, f = d$strata)
    } else {
      dsplit <- list(d)
    }
    dsplit <- lapply(dsplit, function(x) {
      x$n.event <- cumsum(x$n.event)
      x$n.censor <- cumsum(x$n.censor)
      x
    })
    d <- do.call(rbind, dsplit)
  }
  return(d)
}
