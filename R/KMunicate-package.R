#' @title KMunicate-Style Kaplan–Meier Plots
#'
#' @name KMunicate_package
#' @docType package
#' @author Alessandro Gasparini (alessandro.gasparini@@ki.se)
#' @import cowplot ggfortify ggplot2 pammtools survival tidyr
NULL

# Quiets concerns of R CMD check re: variable names used internally
if (getRversion() >= "2.15.1") utils::globalVariables(c("time", "surv", "lower", "upper", "strata", "table_group", "n.event", "n.censor", "n.risk", "name", "value"))
