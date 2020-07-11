#' @title KMunicate-Style Kaplan–Meier Plots
#' @description Produce Kaplan–Meier plots in the style recommended following the KMunicate study <doi:10.1136/bmjopen-2019-030215>.
#' @param fit A `survfit` object.
#' @param time_scale The time scale that will be used for the x-axis and for the summary tables.
#' @param .theme `ggplot` theme used by the plot. Defaults to [ggplot2::theme_minimal()].
#' @param .color_scale Colour scale used for the plot. Has to be a `scale_colour_*` component, and defaults to `NULL` where the default colour scales will be used.
#' @param .fill_scale Fill scale used for the plot. Has to be a `scale_fill_*` component, and defaults to `NULL` where the default fill scales will be used.
#' @param .xlab Label for the horizontal axis, defaults to _Time_.
#' @param .alpha Transparency of the point-wise confidence intervals
#' @param .rel_heights Override default relative heights of plots and tables. See [cowplot::plot_grid()] for more details on how to use this argument.
#' @return A KMunicate-style `ggplot` object.
#' @export
#'
#' @examples
#' library(survival)
#' data("cancer2", package = "KMunicate")
#' KM <- survfit(Surv(studytime, died) ~ drug, data = cancer2)
#' time_scale <- seq(0, max(cancer2$studytime), by = 7)
#' KMunicate(fit = KM, time_scale = time_scale)
KMunicate <- function(fit, time_scale, .theme = ggplot2::theme_minimal(), .color_scale = NULL, .fill_scale = NULL, .xlab = "Time", .alpha = 0.25, .rel_heights = NULL) {
  ### Fortify data
  data <- ggplot2::fortify(fit, surv.connect = TRUE)

  ### Create plot
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = time, y = surv)) +
    pammtools::geom_stepribbon(ggplot2::aes(ymin = lower, ymax = upper, fill = strata), alpha = .alpha) +
    ggplot2::geom_step(ggplot2::aes(color = strata, linetype = strata)) +
    ggplot2::scale_x_continuous(breaks = time_scale) +
    ggplot2::coord_cartesian(ylim = c(0, 1), xlim = range(time_scale)) +
    ggplot2::labs(color = "", fill = "", linetype = "", x = .xlab, y = "Estimated survival") +
    .theme +
    ggplot2::theme(legend.position = c(1, 1), legend.justification = c(1, 1), legend.background = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank())
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
  tds <- split(table_data, f = table_data$strata)
  tds <- lapply(seq_along(tds), function(i) {
    ggplot2::ggplot(tds[[i]], ggplot2::aes(x = time, y = name, label = value)) +
      ggplot2::geom_text() +
      ggplot2::scale_x_continuous(breaks = time_scale) +
      ggplot2::coord_cartesian(xlim = range(time_scale)) +
      ggplot2::theme_void() +
      ggplot2::theme(axis.text.y = ggplot2::element_text(face = "italic")) +
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
