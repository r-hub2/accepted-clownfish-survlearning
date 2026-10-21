## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6, fig.height = 4)
library(survlearning)

## ----data---------------------------------------------------------------------
set.seed(20261026)
d <- data.frame(load = runif(300, -1, 1), design = rbinom(300, 1, .5))
failure_time <- rexp(300, rate = .02 * exp(.8 * d$load - .3 * d$design))
censor_time <- pmin(80, rexp(300, rate = .02 * exp(.6 * d$load)))
d$time <- pmin(failure_time, censor_time)
d$event <- as.integer(failure_time <= censor_time)
train <- d[1:200, ]
test <- d[201:300, ]
f <- Surv(time, event) ~ load + design
fit <- surv_fit(f, train, "cox")
profiles <- data.frame(load = c(-.5, .5), design = c(0, 1))

## -----------------------------------------------------------------------------
importance <- surv_importance(fit, test, n_repeats = 3, seed = 10)
effects <- surv_ale(fit, test, variable = "load", bins = 10,
  type = "failure", time = 10)
plot(importance)
plot(effects)

## -----------------------------------------------------------------------------
remaining <- surv_reliability(fit, profiles, age = 5,
  horizons = c(10, 20), probs = c(.1, .5), grid_points = 501)
remaining$summary
remaining$quantiles

## -----------------------------------------------------------------------------
g <- surv_censor_fit(Surv(time, event) ~ load + design, train, method = "cox")
surv_evaluate(fit, test, c("ipcw_c", "auc", "brier"),
  times = 10, tau = 15, censoring_model = g)

## -----------------------------------------------------------------------------
checkpoint <- tempfile("survlearning-vignette-")
tuned <- surv_tune(f, train, "aft",
  grid = list(distribution = c("weibull", "lognormal")), folds = 2,
  workers = 2, seed = 20, checkpoint = checkpoint)
# Repeat exactly to reuse committed folds and the completed winning refit.
resumed <- surv_tune(f, train, "aft",
  grid = list(distribution = c("weibull", "lognormal")), folds = 2,
  workers = 2, seed = 20, checkpoint = checkpoint)
resumed$execution
stopifnot(resumed$execution$computed_jobs == 0L,
  resumed$execution$refit_reused)

## ----cleanup, include=FALSE---------------------------------------------------
target <- normalizePath(checkpoint, winslash = "/", mustWork = TRUE)
parent <- normalizePath(tempdir(), winslash = "/", mustWork = TRUE)
stopifnot(startsWith(tolower(target), paste0(tolower(parent), "/")))
unlink(target, recursive = TRUE)

