#' @keywords internal
.fortify <- function(fit) {
  fit <- survival::survfit0(x = fit)
  out <- data.frame(
    time = fit$time,
    n.risk = fit$n.risk,
    n.event = fit$n.event,
    n.censor = fit$n.censor,
    surv = fit$surv,
    lower = fit$lower,
    upper = fit$upper
  )
  if ("strata" %in% names(fit)) {
    out$strata <- rep(names(fit$strata), times = as.numeric(fit$strata))
    out$strata <- factor(out$strata, levels = names(fit$strata), labels = sub(".+?=", "", names(fit$strata)))
  }
  return(out)
}

#' @keywords internal
.fortify_summary <- function(fit, time_scale, risk_table) {
  summ <- summary(fit, times = time_scale, extend = TRUE)

  d <- data.frame(
    time = summ$time,
    n.risk = summ$n.risk,
    n.event = summ$n.event,
    n.censor = summ$n.censor
  )
  if ("strata" %in% names(fit)) {
    d$strata <- summ$strata
    d$strata <- factor(d$strata, levels = levels(d$strata), labels = sub(".+?=", "", levels(d$strata)))
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
      # Solve (for now) inconsistency between n.risk and the rest
      # Trusting n.censor and n.event for now...
      # See (and follow-up) over at:
      # - https://github.com/ellessenne/KMunicate-package/issues/6
      # - https://github.com/therneau/survival/issues/119
      x$n.risk <- max(x$n.risk) - x$n.censor - x$n.event
      x
    })
    d <- do.call(rbind, dsplit)
  }

  # Return d
  return(d)
}
