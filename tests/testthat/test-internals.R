testthat::context(".extract_summary_data()")

KM <- survival::survfit(survival::Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)

testthat::test_that("Output is a data.frame", {
  testthat::expect_s3_class(object = KMunicate:::.extract_summary_data(fit = KM, time_scale = time_scale), class = "data.frame")
})

testthat::test_that("Output has correct size", {
  testthat::expect_equal(object = nrow(KMunicate:::.extract_summary_data(fit = KM, time_scale = time_scale)), expected = length(time_scale) * length(unique(brcancer$hormon)))
  testthat::expect_equal(object = ncol(KMunicate:::.extract_summary_data(fit = KM, time_scale = time_scale)), expected = 5)
})

testthat::test_that("Output has correct size with no strata", {
  KM <- survival::survfit(survival::Surv(rectime, censrec) ~ 1, data = brcancer)
  time_scale <- seq(0, max(brcancer$rectime), by = 365)
  testthat::expect_equal(object = nrow(KMunicate:::.extract_summary_data(fit = KM, time_scale = time_scale)), expected = length(time_scale))
  testthat::expect_equal(object = ncol(KMunicate:::.extract_summary_data(fit = KM, time_scale = time_scale)), expected = 4)
})
