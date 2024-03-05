#' @import cowplot ggplot2 pammtools survival tidyr
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

# Quiets concerns of R CMD check re: variable names used internally
if (getRversion() >= "2.15.1") utils::globalVariables(c("time", "surv", "lower", "upper", "strata", "table_group", "n.event", "n.censor", "n.risk", "name", "value"))
