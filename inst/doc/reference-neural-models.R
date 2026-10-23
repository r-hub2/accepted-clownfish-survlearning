## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(survlearning)

## ----references---------------------------------------------------------------
d <- survival::veteran
f <- Surv(time, status) ~ age + karno
km <- surv_fit(f, d, "km")
smooth <- surv_fit(f, d, "cox_spline", params = list(df = 3))
surv_compare(list(km = km, smooth = smooth), d)

## ----additional-engines, eval=FALSE-------------------------------------------
# surv_fit(f, d, "flexsurv", list(knots = 1, scale = "hazard"))
# surv_fit(f, d, "coxboost", list(steps = 100, penalty = 100))
# surv_fit(f, d, "ranger", list(trees = 200))
# surv_fit(f, d, "aorsf", list(trees = 200))

## ----neural-cox, eval=FALSE---------------------------------------------------
# fit <- surv_fit(f, training, "neural_cox",
#   params = list(hidden = 16, epochs = 100, learning_rate = 0.001,
#     decay = 0.0001, ties = "efron"))
# surv_predict(fit, new_equipment, "survival", times = c(30, 60, 90))

## ----neural-discrete, eval=FALSE----------------------------------------------
# fit <- surv_fit(f, d, "neural_discrete",
#   params = list(hidden = 8, intervals = 10, decay = 0.01, max_iter = 500))
# surv_predict(fit, d[1:2, ], "survival", times = c(30, 60, 90))
# surv_diagnostics(fit)

