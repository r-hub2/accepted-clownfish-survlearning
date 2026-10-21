## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
# importance <- surv_importance(fit, test, n_repeats = 10, seed = 10)
# effects <- surv_ale(fit, test, variable = "load", bins = 10,
#   type = "failure", time = 10)
# plot(importance)
# plot(effects)

## -----------------------------------------------------------------------------
# remaining <- surv_reliability(fit, profiles, age = 5,
#   horizons = c(10, 20), probs = c(.1, .5), grid_points = 501)
# remaining$summary
# remaining$quantiles

## -----------------------------------------------------------------------------
# g <- surv_censor_fit(Surv(time, event) ~ load + design, train, method = "cox")
# surv_evaluate(fit, test, c("ipcw_c", "auc", "brier"),
#   times = 10, tau = 15, censoring_model = g)

## -----------------------------------------------------------------------------
# tuned <- surv_tune(f, train, "aft",
#   grid = list(distribution = c("weibull", "lognormal")), folds = 3,
#   workers = 2, checkpoint = "owned-search", progress = TRUE)
# # Repeat exactly to reuse committed folds and the completed winning refit.
# resumed <- surv_tune(f, train, "aft",
#   grid = list(distribution = c("weibull", "lognormal")), folds = 3,
#   workers = 2, checkpoint = "owned-search")
# resumed$execution

