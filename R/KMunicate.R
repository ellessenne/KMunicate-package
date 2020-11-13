#' @title Create KMunicate-Style Kaplan–Meier Plots
#' @description Produce Kaplan–Meier plots in the style recommended following the KMunicate study by TP Morris _et al_. (\doi{10.1136/bmjopen-2019-030215}).
#' @param fit A `survfit` object.
#' @param time_scale The time scale that will be used for the x-axis and for the summary tables.
#' @param .risk_table This arguments define the type of risk table that is produced.
#' @param .reverse If `reverse = TRUE`, then the plot uses 1 - survival probability on the y-axis.
#' Defaults to `KMunicate`, where the cumulative number of events and censored are calculated.
#' Another possibility is `survfit`, which will use the default numbers returned by `summary.survfit` (e.g. number of events and censored per interval).
#' `.risk_table` can also be `NULL`, in which case the risk table will be omitted from the plot.
#' @param .theme `ggplot` theme used by the plot. Defaults to `NULL`, where the default `ggplot` theme will be used.
#' @param .color_scale Colour scale used for the plot. Has to be a `scale_colour_*` component, and defaults to `NULL` where the default colour scale will be used.
#' @param .fill_scale Fill scale used for the plot. Has to be a `scale_fill_*` component, and defaults to `NULL` where the default fill scale will be used.
#' @param .linetype_scale Linetype scale used for the plot. Has to be a `scale_linetype_*` component, and defaults to `NULL` where the default linetype scale will be used.
#' @param .annotate Optional annotation to be added to the plot, e.g. using [ggplot2::annotate()]. Defaults to `NULL`, where no extra annotation is added.
#' @param .xlab Label for the horizontal axis, defaults to _Time_.
#' @param .ylab Label for the vertical axis, defaults to _Estimated survival_ if `.reverse = FALSE`, to _Estimated (1 - survival)_ otherwise.
#' @param .alpha Transparency of the point-wise confidence intervals
#' @param .rel_heights Override default relative heights of plots and tables. Must be a numeric vector of length equal 1 + 1 per each arm in the Kaplan-Meier plot. See [cowplot::plot_grid()] for more details on how to use this argument.
#' @param .ff A string used to define a base font for the plot.
#' @param .risk_table_base_size Base font size for the risk table, given in pts. Defaults to 11.
#' @param .size Thickness of each Kaplan-Meier curve. Defaults to 1.
#' @param .legend_position Position of the legend in the plot. Defaults to `c(1, 1)`, which corresponds to _top-right_ of the plot. N.B.: Legend justification is modified accordingly. See [ggplot2::theme()] for more details on how to place the legend of the plot.
#'
#' @return A KMunicate-style `ggplot` object.
#' @export
#'
#' @examples
#' library(survival)
#' data("cancer2", package = "KMunicate")
#' KM <- survfit(Surv(studytime, died) ~ drug, data = cancer2)
#' time_scale <- seq(0, max(cancer2$studytime), by = 7)
#' KMunicate(fit = KM, time_scale = time_scale)
KMunicate <- function(fit, time_scale, .risk_table = "KMunicate", .reverse = FALSE, .theme = NULL, .color_scale = NULL, .fill_scale = NULL, .linetype_scale = NULL, .annotate = NULL, .xlab = "Time", .ylab = ifelse(.reverse, "Estimated (1 - survival)", "Estimated survival"), .alpha = 0.25, .rel_heights = NULL, .ff = NULL, .risk_table_base_size = 11, .size = 1, .legend_position = c(1, 1)) {

  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # 'fit' must be of class 'survfit'
  checkmate::assert_class(x = fit, classes = "survfit", add = arg_checks)
  # 'time_scale' must be a numeric vector
  checkmate::assert_numeric(x = time_scale, add = arg_checks)
  # '.reverse' must be a logical value
  checkmate::assert_logical(x = .reverse, len = 1, add = arg_checks)
  # '.risk_table' must be a vector of strings, can be NULL
  checkmate::assert_string(x = .risk_table, null.ok = TRUE, add = arg_checks)
  # '.risk_table' must have specific values
  if (!is.null(.risk_table)) {
    .risk_table <- match.arg(.risk_table, choices = c("KMunicate", "survfit", NULL))
    checkmate::assert_true(x = .risk_table %in% c("KMunicate", "survfit"), add = arg_checks)
  }
  # '.theme' must be of class 'theme', 'gg' and must pass ggplot2::is.ggtheme()
  checkmate::assert_class(x = .theme, classes = c("theme", "gg"), null.ok = TRUE, add = arg_checks)
  if (!is.null(.theme)) checkmate::assert_true(x = ggplot2::is.theme(.theme), add = arg_checks)
  # '.color_scale', '.fill_scale', '.linetype_scale', '.annotate' must pass ggplot2::is.ggproto()
  if (!is.null(.color_scale)) checkmate::assert_true(x = ggplot2::is.ggproto(.color_scale), add = arg_checks)
  if (!is.null(.fill_scale)) checkmate::assert_true(x = ggplot2::is.ggproto(.fill_scale), add = arg_checks)
  if (!is.null(.linetype_scale)) checkmate::assert_true(x = ggplot2::is.ggproto(.linetype_scale), add = arg_checks)
  if (!is.null(.annotate)) checkmate::assert_true(x = ggplot2::is.ggproto(.annotate), add = arg_checks)
  # '.xlab', '.ylab' must be a string
  checkmate::assert_string(x = .xlab, add = arg_checks)
  checkmate::assert_string(x = .ylab, add = arg_checks)
  # '.alpha' must be a number
  checkmate::assert_number(x = .alpha, add = arg_checks)
  # '.rel_heights' must be a numeric vector or NULL
  checkmate::assert_numeric(x = .rel_heights, null.ok = TRUE, add = arg_checks)
  # '.ff' must be a string or NULL
  checkmate::assert_string(x = .ff, null.ok = TRUE, add = arg_checks)
  # '.risk_table_base_size', '.size' must be a number
  checkmate::assert_number(x = .risk_table_base_size, add = arg_checks)
  checkmate::assert_number(x = .size, add = arg_checks)
  # '.legend_position' must be a numeric vector of length 2
  checkmate::assert_numeric(x = .legend_position, len = 2, add = arg_checks)
  # Report
  if (!arg_checks$isEmpty()) checkmate::reportAssertions(arg_checks)

  ### Fortify data
  data <- .fortify(fit)
  # If .reverse, use 1 - survival probability
  if (.reverse) {
    data$surv <- 1 - data$surv
    data$lower <- 1 - data$lower
    data$upper <- 1 - data$upper
  }

  ### Create plot
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = time, y = surv, ymin = lower, ymax = upper))
  if ("strata" %in% names(fit)) {
    plot <- plot + pammtools::geom_stepribbon(ggplot2::aes(fill = strata), alpha = .alpha) +
      ggplot2::geom_step(ggplot2::aes(color = strata, linetype = strata), size = .size)
  } else {
    plot <- plot + pammtools::geom_stepribbon(alpha = .alpha, size = .size) +
      ggplot2::geom_step()
  }
  plot <- plot +
    ggplot2::scale_x_continuous(breaks = time_scale) +
    ggplot2::coord_cartesian(ylim = c(0, 1), xlim = range(time_scale)) +
    ggplot2::labs(color = "", fill = "", linetype = "", x = .xlab, y = .ylab)
  if (!is.null(.theme)) {
    plot <- plot + .theme
  } else if (!is.null(.ff)) {
    plot <- plot + ggplot2::theme_gray(base_family = .ff)
  }
  plot <- plot +
    ggplot2::theme(legend.position = .legend_position, legend.justification = .legend_position, legend.background = ggplot2::element_blank(), legend.key = ggplot2::element_blank(), plot.margin = ggplot2::unit(c(0, 0, 0, 0), "cm"))
  if (!is.null(.color_scale)) {
    plot <- plot + .color_scale
  }
  if (!is.null(.fill_scale)) {
    plot <- plot + .fill_scale
  }
  if (!is.null(.linetype_scale)) {
    plot <- plot + .linetype_scale
  }
  if (!is.null(.annotate)) {
    plot <- plot + .annotate
  }

  # Create tables if requested
  if (!is.null(.risk_table)) {
    ### Create tables
    table_data <- .fortify_summary(fit = fit, time_scale = time_scale, risk_table = .risk_table)
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
        p <- p + ggplot2::geom_text(size = .risk_table_base_size / 3)
      } else {
        p <- p + ggplot2::geom_text(mapping = ggplot2::aes(family = .ff), size = .risk_table_base_size / 3)
      }
      p <- p +
        ggplot2::scale_x_continuous(breaks = time_scale) +
        ggplot2::coord_cartesian(xlim = range(time_scale)) +
        ggplot2::theme_void(base_size = .risk_table_base_size) +
        ggplot2::theme(plot.margin = ggplot2::unit(c(0, 0, 0, 0), "cm"))
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
  } else {
    KMunicate_plot <- plot
  }

  ### Return
  return(KMunicate_plot)
}
