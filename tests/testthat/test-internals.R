testthat::context(".fortify()")

# Implement .fortify(), then add tests here

testthat::context(".fortify_summary()")

KM <- survival::survfit(survival::Surv(rectime, censrec) ~ hormon, data = brcancer)
time_scale <- seq(0, max(brcancer$rectime), by = 365)

testthat::test_that("Output is a data.frame", {
  testthat::expect_s3_class(object = KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "KMunicate"), class = "data.frame")
  testthat::expect_s3_class(object = KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "survfit"), class = "data.frame")
})

testthat::test_that("Output has correct size", {
  testthat::expect_equal(object = nrow(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "KMunicate")), expected = length(time_scale) * length(unique(brcancer$hormon)))
  testthat::expect_equal(object = ncol(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "KMunicate")), expected = 5)
  testthat::expect_equal(object = nrow(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "survfit")), expected = length(time_scale) * length(unique(brcancer$hormon)))
  testthat::expect_equal(object = ncol(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "survfit")), expected = 5)
})

testthat::test_that("Output has correct size with no strata", {
  KM <- survival::survfit(survival::Surv(rectime, censrec) ~ 1, data = brcancer)
  time_scale <- seq(0, max(brcancer$rectime), by = 365)
  testthat::expect_equal(object = nrow(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "KMunicate")), expected = length(time_scale))
  testthat::expect_equal(object = ncol(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "KMunicate")), expected = 4)
  testthat::expect_equal(object = nrow(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "survfit")), expected = length(time_scale))
  testthat::expect_equal(object = ncol(KMunicate:::.fortify_summary(fit = KM, time_scale = time_scale, risk_table = "survfit")), expected = 4)
})
