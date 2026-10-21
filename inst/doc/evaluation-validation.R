## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(survlearning)

## ----example------------------------------------------------------------------
d <- survival::veteran
set.seed(17)
id <- sample(seq_len(nrow(d)), 100)
train <- d[id, ]
test <- d[-id, ]
f <- Surv(time, status) ~ age + karno
fit <- surv_fit(f, train, "aft")
surv_score(fit, test)

## ----metrics------------------------------------------------------------------
ev <- surv_evaluate(fit, test,
  metrics = c("harrell", "uno", "auc", "brier", "ibs"),
  times = c(30, 60, 90), tau = 90)
ev
plot(ev, metric = "brier")

## ----calibration--------------------------------------------------------------
cal <- surv_calibrate(fit, test, times = 60, groups = 3)
cal
plot(cal)

## ----conditional-calibration--------------------------------------------------
g <- surv_censor_fit(f, train, method = "cox")
conditional_cal <- surv_calibrate(fit, test, times = 60, groups = 3,
  censoring_model = g, n_boot = 100, seed = 14)
conditional_cal

## ----validation---------------------------------------------------------------
splits <- surv_resamples(f, train, folds = 3, seed = 11)
tuned <- surv_tune(f, train, "aft",
  grid = list(distribution = c("weibull", "lognormal")), resamples = splits)
tuned$results
surv_score(tuned, test)

validated <- surv_validate(f, train, methods = c("km", "cox", "aft"),
  grids = list(aft = list(distribution = c("weibull", "lognormal"))),
  resamples = splits, inner_folds = 3, seed = 12, metric = "harrell")
validated$summary

