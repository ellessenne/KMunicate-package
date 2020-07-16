#' @title Create KMunicate-Style Kaplan–Meier Plots
#' @description Produce Kaplan–Meier plots in the style recommended following the KMunicate study by TP Morris _et al_. (\doi{10.1136/bmjopen-2019-030215}).
#' @param fit A `survfit` object.
#' @param time_scale The time scale that will be used for the x-axis and for the summary tables.
#' @param .theme `ggplot` theme used by the plot. Defaults to `NULL`, where the default `ggplot` theme will be used.
#' @param .color_scale Colour scale used for the plot. Has to be a `scale_colour_*` component, and defaults to `NULL` where the default colour scales will be used.
#' @param .fill_scale Fill scale used for the plot. Has to be a `scale_fill_*` component, and defaults to `NULL` where the default fill scales will be used.
#' @param .xlab Label for the horizontal axis, defaults to _Time_.
#' @param .alpha Transparency of the point-wise confidence intervals
#' @param .rel_heights Override default relative heights of plots and tables. Must be a numeric vector of length equal 1 + 1 per each arm in the Kaplan-Meier plot. See [cowplot::plot_grid()] for more details on how to use this argument.
#' @param .ff A string used to define a base font for the plot.
#' @return A KMunicate-style `ggplot` object.
#' @export
#'
#' @examples
#' library(survival)
#' data("cancer2", package = "KMunicate")
#' KM <- survfit(Surv(studytime, died) ~ drug, data = cancer2)
#' time_scale <- seq(0, max(cancer2$studytime), by = 7)
#' KMunicate(fit = KM, time_scale = time_scale)
KMunicate <- function(fit, time_scale, .theme = NULL, .color_scale = NULL, .fill_scale = NULL, .xlab = "Time", .alpha = 0.25, .rel_heights = NULL, .ff = NULL) {

  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # 'fit' must be of class 'survfit'
  checkmate::assert_class(x = fit, classes = "survfit", add = arg_checks)
  # 'time_scale' must be a numeric vector
  checkmate::assert_numeric(x = time_scale, add = arg_checks)
  # '.theme' must be of class 'theme', 'gg' and must pass ggplot2::is.ggtheme()
  checkmate::assert_class(x = .theme, classes = c("theme", "gg"), null.ok = TRUE, add = arg_checks)
  if (!is.null(.theme)) checkmate::assert_true(x = ggplot2::is.theme(.theme), add = arg_checks)
  # '.color_scale' and '.fill_scale' must pass ggplot2::is.ggproto()
  if (!is.null(.color_scale)) checkmate::assert_true(x = ggplot2::is.ggproto(.color_scale), add = arg_checks)
  if (!is.null(.fill_scale)) checkmate::assert_true(x = ggplot2::is.ggproto(.fill_scale), add = arg_checks)
  # '.xlab' must be a string
  checkmate::assert_string(x = .xlab, add = arg_checks)
  # '.alpha' must be a number
  checkmate::assert_number(x = .alpha, add = arg_checks)
  # '.rel_heights' must be a numeric vector or NULL
  checkmate::assert_numeric(x = .rel_heights, null.ok = TRUE, add = arg_checks)
  # '.ff' must be a string or NULL
  checkmate::assert_string(x = .ff, null.ok = TRUE, add = arg_checks)
  # Report
  if (!arg_checks$isEmpty()) checkmate::reportAssertions(arg_checks)

  ### Fortify data
  data <- ggplot2::fortify(fit, surv.connect = TRUE)

  ### Create plot
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = time, y = surv, ymin = lower, ymax = upper))
  if ("strata" %in% names(fit)) {
    plot <- plot + pammtools::geom_stepribbon(ggplot2::aes(fill = strata), alpha = .alpha) +
      ggplot2::geom_step(ggplot2::aes(color = strata, linetype = strata))
  } else {
    plot <- plot + pammtools::geom_stepribbon(alpha = .alpha) +
      ggplot2::geom_step()
  }
  plot <- plot +
    ggplot2::scale_x_continuous(breaks = time_scale) +
    ggplot2::coord_cartesian(ylim = c(0, 1), xlim = range(time_scale)) +
    ggplot2::labs(color = "", fill = "", linetype = "", x = .xlab, y = "Estimated survival")
  if (!is.null(.theme)) {
    plot <- plot + .theme
  } else if (!is.null(.ff)) {
    plot <- plot + ggplot2::theme_gray(base_family = .ff)
  }
  plot <- plot +
    ggplot2::theme(legend.position = c(1, 1), legend.justification = c(1, 1), legend.background = ggplot2::element_blank(), legend.key = ggplot2::element_blank())
  if (!is.null(.color_scale)) {
    plot <- plot + .color_scale
  }
  if (!is.null(.fill_scale)) {
    plot <- plot + .fill_scale
  }

  ### Create tables
  table_data <- .extract_summary_data(fit = fit, time_scale = time_scale)
  table_data <- tidyr::pivot_longer(data = table_data, cols = c("n.risk", "n.event", "n.censor"))
  table_data$name <- factor(table_data$name, levels = c("n.event", "n.censor", "n.risk"), labels = c("Events", "Censored", "At risk"))
  ### Create table 'plots'
  if (!("strata" %in% names(fit))) {
    table_data$strata <- "Overall"
  }
  tds <- split(table_data, f = table_data$strata)
  tds <- lapply(seq_along(tds), function(i) {
    p <- ggplot2::ggplot(tds[[i]], ggplot2::aes(x = time, y = name, label = value))
    if (is.null(.ff)) {
      p <- p + ggplot2::geom_text()
    } else {
      p <- p + ggplot2::geom_text(mapping = ggplot2::aes(family = .ff))
    }
    p <- p +
      ggplot2::scale_x_continuous(breaks = time_scale) +
      ggplot2::coord_cartesian(xlim = range(time_scale)) +
      ggplot2::theme_void()
    if (is.null(.ff)) {
      p <- p + ggplot2::theme(axis.text.y = ggplot2::element_text(face = "italic"))
    } else {
      p <- p + ggplot2::theme(axis.text.y = ggplot2::element_text(face = "italic", family = .ff), plot.title = ggplot2::element_text(family = .ff))
    }
    p <- p +
      ggplot2::labs(title = names(tds)[i])
  })

  ### Process relative heights
  if (is.null(.rel_heights)) {
    .rel_heights <- c(3, rep(1, length(tds)))
  }

  ### Combine plot and tables
  KMunicate_plot <- cowplot::plot_grid(plotlist = c(list(plot), tds), align = "hv", axis = "tlbr", ncol = 1, rel_heights = .rel_heights)

  ### Return
  return(KMunicate_plot)
}
