testthat::context(".fortify()")

library(simsurv)
testfit1 <- function() {
  # Simulate a trial with 100 individuals, 1:1 random allocation and a log-treatment effect of -0.5
  covs <- data.frame(id = seq(100))
  s1 <- simsurv::simsurv(lambdas = 0.1, gammas = 1.5, x = covs, maxt = 5)
  simdf <- merge(x = covs, y = s1)
  fit <- survival::survfit(survival::Surv(eventtime, status) ~ 1, data = simdf)
  return(fit)
}
testfit2 <- function() {
  # Simulate a trial with 100 individuals, 1:1 random allocation and a log-treatment effect of -0.5
  covs <- data.frame(id = seq(100), trt = stats::rbinom(100, 1L, 0.5))
  s1 <- simsurv::simsurv(lambdas = 0.1, gammas = 1.5, betas = c(trt = -0.5), x = covs, maxt = 5)
  simdf <- merge(x = covs, y = s1)
  fit <- survival::survfit(survival::Surv(eventtime, status) ~ trt, data = simdf)
  return(fit)
}

testthat::test_that("Results from .fortify and ggfortify::fortify are consistent (single arm)", {
  library(broom)
  for (ii in seq(50)) {
    f <- testfit1()
    df <- .fortify(f)
    df <- df[order(df$time), ]
    dfref <- broom::tidy(survival::survfit0(f))
    dfref <- dfref[order(dfref$time), ]
    testthat::expect_equal(object = df$time, expected = dfref$time)
    testthat::expect_equal(object = df$n.risk, expected = dfref$n.risk)
    testthat::expect_equal(object = df$n.event, expected = dfref$n.event)
    testthat::expect_equal(object = df$n.censor, expected = dfref$n.censor)
    testthat::expect_equal(object = df$surv, expected = dfref$estimate)
    testthat::expect_equal(object = df$lower, expected = dfref$conf.low)
    testthat::expect_equal(object = df$upper, expected = dfref$conf.high)
  }
})

testthat::test_that("Results from .fortify and ggfortify::fortify are consistent (two arms)", {
  library(broom)
  for (ii in seq(50)) {
    f <- testfit2()
    df <- .fortify(f)
    df <- df[order(df$strata, df$time), ]
    dfref <- broom::tidy(survival::survfit0(f))
    dfref <- dfref[order(dfref$strata, dfref$time), ]
    testthat::expect_equal(object = df$time, expected = dfref$time)
    testthat::expect_equal(object = df$n.risk, expected = dfref$n.risk)
    testthat::expect_equal(object = df$n.event, expected = dfref$n.event)
    testthat::expect_equal(object = df$n.censor, expected = dfref$n.censor)
    testthat::expect_equal(object = df$surv, expected = dfref$estimate)
    testthat::expect_equal(object = df$lower, expected = dfref$conf.low)
    testthat::expect_equal(object = df$upper, expected = dfref$conf.high)
  }
})

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
