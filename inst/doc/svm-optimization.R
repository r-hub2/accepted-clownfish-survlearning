## ----eval=FALSE---------------------------------------------------------------
# fit <- surv_tune(Surv(time, event) ~ temperature + age, data,
#   method = "svm", grid = list(cost = c(0.01, 0.1, 1)),
#   params = list(solver = "clarabel"), folds = 3, cache = TRUE)
# fit$results
# surv_diagnostics(fit)
# surv_predict(fit, newdata)

