#' @title KMunicate-Style Kaplan–Meier Plots
#'
#' @description Produce Kaplan–Meier plots in the style recommended following the KMunicate study <doi:10.1136/bmjopen-2019-030215>.
#'
#' @name KMunicate
#' @docType package
#' @author Alessandro Gasparini (alessandro.gasparini@@ki.se)
#' @import cowplot ggfortify ggplot2 pammtools survival tidyr
NULL

# Quiets concerns of R CMD check re: variable names used internally
if (getRversion() >= "2.15.1") utils::globalVariables(c("time", "surv", "lower", "upper", "strata", "table_group", "n.event", "n.censor", "n.risk", "name", "value"))
