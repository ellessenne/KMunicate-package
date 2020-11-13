KM <- survival::survfit(survival::Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)

testthat::test_that("Basic args are passed", {
  testthat::expect_error(object = KMunicate(time_scale = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM))
  testthat::expect_error(object = KMunicate())
})

testthat::test_that("Arg: fit", {
  testthat::expect_error(object = KMunicate(fit = brcancer, time_scale = time_scale))
  testthat::expect_error(object = KMunicate(fit = time_scale, time_scale = time_scale))
})

testthat::test_that("Arg: time_scale", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = c(TRUE, FALSE)))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = LETTERS))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = brcancer))
})

testthat::test_that("Arg: .risk_table", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table = time_scale))
})

testthat::test_that("Arg: .reverse", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .reverse = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .reverse = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .reverse = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .reverse = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .reverse = time_scale))
})

testthat::test_that("Arg: .theme", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = rnorm))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .theme = time_scale))
})

testthat::test_that("Arg: .color_scale", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = rnorm))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .color_scale = ggplot2::theme_bw()))
})

testthat::test_that("Arg: .fill_scale", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = rnorm))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = ggplot2::theme_bw()))
})

testthat::test_that("Arg: .linetype_scale", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = rnorm))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .linetype_scale = ggplot2::theme_bw()))
})

testthat::test_that("Arg: .annotate", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = rnorm))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .annotate = ggplot2::theme_bw()))
})

testthat::test_that("Arg: .xlab", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = time_scale))
})

testthat::test_that("Arg: .ylab", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ylab = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ylab = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ylab = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ylab = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ylab = time_scale))
})

testthat::test_that("Arg: .alpha", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = time_scale))
})

testthat::test_that("Arg: .rel_heights", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .rel_heights = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .rel_heights = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .rel_heights = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .rel_heights = KM))
})

testthat::test_that("Arg: .ff", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ff = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ff = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ff = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ff = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .ff = time_scale))
})

testthat::test_that("Arg: .risk_table_base_size", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table_base_size = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table_base_size = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table_base_size = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table_base_size = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .risk_table_base_size = time_scale))
})

testthat::test_that("Arg: .size", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .size = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .size = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .size = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .size = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .size = time_scale))
})

testthat::test_that("Arg: .legend_position", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = c("1", "2")))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = c(TRUE, FALSE)))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .legend_position = c("1", FALSE)))
})
