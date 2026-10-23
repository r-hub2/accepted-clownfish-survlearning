## ----eval=FALSE---------------------------------------------------------------
# linear <- surv_tune(Surv(time, event) ~ temperature + age, data,
#   method = "svm", grid = list(cost = 10^(-3:3)),
#   params = list(kernel = "linear"), folds = 3, cache = TRUE)
# 
# additive <- surv_tune(Surv(time, event) ~ temperature + age, data,
#   method = "svm", grid = list(cost = 10^(-3:3)),
#   params = list(kernel = "additive"), folds = 3, cache = TRUE)
# 
# linear$results
# additive$results
# surv_diagnostics(additive)
# surv_predict(additive, newdata)

