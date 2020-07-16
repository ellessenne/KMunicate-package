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

testthat::test_that("Arg: .color_scale", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = rnorm))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = time_scale))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .fill_scale = ggplot2::theme_bw()))
})

testthat::test_that("Arg: .xlab", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = 1))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .xlab = time_scale))
})

testthat::test_that("Arg: .alpha", {
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = "1"))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = TRUE))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = brcancer))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = KM))
  testthat::expect_error(object = KMunicate(fit = KM, time_scale = time_scale, .alpha = time_scale))
})
