.fit_xgboost <- function(method, x, y, params, seed) {
  if (method == "xgboost_cox") {
    labels <- ifelse(y[, 2L] == 1, y[, 1L], -y[, 1L])
    train <- xgboost::xgb.DMatrix(x, label = labels, nthread = params$threads)
  } else {
    train <- xgboost::xgb.DMatrix(x, label_lower_bound = y[, 1L],
      label_upper_bound = ifelse(y[, 2L] == 1, y[, 1L], Inf), nthread = params$threads)
  }
  settings <- list(objective = if (method == "xgboost_cox") "survival:cox" else "survival:aft",
    tree_method = "hist", max_depth = params$depth, eta = params$learning_rate,
    min_child_weight = params$min_child_weight, reg_lambda = params$leaf_penalty,
    nthread = params$threads, seed = seed, verbosity = 0L)
  if (method == "xgboost_aft") {
    settings$aft_loss_distribution <- params$distribution
    settings$aft_loss_distribution_scale <- params$scale
  }
  xgboost::xgb.train(settings, train, nrounds = params$trees, verbose = 0L)
}

.xgboost_margin <- function(engine, x) {
  as.numeric(stats::predict(engine, newdata = x, outputmargin = TRUE))
}

.xgboost_baseline <- function(engine, x, y) {
  lp <- .xgboost_margin(engine, x)
  center <- max(lp)
  order <- order(y[, 1L])
  time <- y[order, 1L]
  first <- !duplicated(time)
  at_risk <- rev(cumsum(rev(exp(lp[order] - center))))[first]
  events <- as.numeric(rowsum(y[order, 2L], cumsum(first), reorder = FALSE))
  list(time = time[first], cumhaz = cumsum(events / at_risk), center = center)
}

.xgboost_survival <- function(object, x, times) {
  lp <- .xgboost_margin(object$engine, x)
  if (object$method == "xgboost_cox") {
    baseline <- object$baseline
    cumulative <- c(0, baseline$cumhaz)[findInterval(times, baseline$time) + 1L]
    return(exp(-exp(outer(lp - baseline$center, log(cumulative), "+"))))
  }
  z <- outer(lp, log(times), function(location, time) (time - location) / object$params$scale)
  switch(object$params$distribution,
    normal = stats::pnorm(z, lower.tail = FALSE),
    logistic = stats::plogis(z, lower.tail = FALSE),
    extreme = exp(-exp(z)))
}

.xgboost_median <- function(object, x) {
  error_median <- if (object$params$distribution == "extreme") log(log(2)) else 0
  exp(.xgboost_margin(object$engine, x) + object$params$scale * error_median)
}
