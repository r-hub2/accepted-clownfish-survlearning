## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(survlearning)

## ----rank---------------------------------------------------------------------
d <- survival::veteran
f <- Surv(time, status) ~ age + karno
rank_fit <- surv_fit(f, d, "svm_rank", params = list(lambda = 0.01))
surv_predict(rank_fit, d[1:4, ])
rank_fit$engine$diagnostics[c("comparable_pairs", "gradient_norm",
                            "strong_convexity_gap_bound")]

## ----additive-----------------------------------------------------------------
additive_fit <- surv_fit(f, d, "svm_rank",
  params = list(kernel = "additive", lambda = 0.01))
surv_predict(additive_fit, d[1:4, ])

## ----hybrid-------------------------------------------------------------------
hybrid_fit <- surv_fit(f, d, "svm_hybrid",
  params = list(kernel = "linear", lambda = 0.01, rank_weight = 0.5))
surv_predict(hybrid_fit, d[1:4, ])

## ----ipcw---------------------------------------------------------------------
ipcw_fit <- surv_fit(f, d, "svm_ipcw",
  params = list(horizon = 60, lambda = 0.01, epsilon = 0,
                censoring_method = "km"))
ipcw_fit$engine$diagnostics$ipcw

## ----tuning-------------------------------------------------------------------
plan <- surv_resamples(f, d, folds = 3, seed = 104)
search <- surv_tune(f, d, "svm_rank",
  grid = list(kernel = c("linear", "additive"), lambda = c(0.01, 0.1)),
  resamples = plan, seed = 104)
search$results[c("kernel", "lambda", "mean_cindex", "failed_folds")]

