# survlearning 0.2.2

* Reject infeasible and non-finite SVM solver output before returning a model.
  Prediction also rejects saved engines explicitly marked as infeasible or failed.
  Keep the same loss, kernels, solvers, tolerances and complete training samples.
* Add methodology references to DESCRIPTION and an automatic package citation.
* Declare testthat >= 3.1.8 for the binding-mocking helpers already used in tests.
* Prepare independent portability and engine-compatibility checks; their actual
  outcomes are recorded separately, not inferred from workflow configuration.

# survlearning 0.2.1

* Implement linear and additive SVM kernels internally, preserving the reference
  range convention, extrapolation and censored-regression quadratic objective.
  SVM fitting, tuning and prediction no longer require survivalsvm. It remains
  an optional dependency solely for independent reference-comparison tests.
* Call quadprog::solve.QP directly for the explicit dense reference solver,
  preserving constraint order and removing pracma from package dependencies.
  Compact Clarabel remains the default; Newton, OSQP and additive RSpectra paths
  are unchanged. No observations or methods are removed.
* Report the native SVM engine as stats. Catalogue availability describes the
  default Clarabel configuration; explicit linear Newton needs only core imports.
  SVM checkpoints no longer depend on an unused survivalsvm version.
* Keep both randomForestSRC and ranger forest adapters unchanged. Preserve the
  frozen 0.2.0 source and article replication rather than relabeling their results.

# survlearning 0.2.0

* Prepare a local release candidate, without publishing or submitting it.
* Use seed = NULL by default. Explicit seeds use withr's scoped RNG helper,
  replacing package-written manipulation of .Random.seed. Checkpoint searches
  require explicit seeds; forest/XGBoost fits store their generated engine seed.
* Correct Cox survival at zero hazard for extreme finite log-risks, compute
  parametric AFT upper tails directly, and rescale extreme design moments before
  accumulation. Non-representable moments raise errors instead of dropping columns.
* Accept fully censored Kaplan-Meier training samples and probability-based
  validation; concordance remains undefined without comparable assessment pairs.
* Document actual returns of every public function and registered S3 method;
  provide standalone executable SVM examples and deterministic boundary tests.
* Extend article replication with a matched censored comparison, a fixed-setting
  split sensitivity, three additive-Clarabel processes and one entry point.

# survlearning 0.1.5.9000

* Make compact Clarabel the default censored-SVM solver; retain explicit dense
  quadprog and the existing Newton/OSQP alternatives, without subsampling.
* Add standard fit/search summaries and classical coef/vcov methods for ordinary
  Cox and parametric AFT, preserving original design labels.
* Make nested-validation selection independent of reporting-metric order;
  validate horizons before fitting and label single-configuration searches.
* Extend calibration to supplied marginal, stratified or Cox censoring fits,
  with normalized IPCW estimates, effective sample size and fixed-fit bootstrap.
* Reconstruct Backblaze predictors from the exact entry-day snapshots and retain
  explicit risk-set eligibility. Regenerate predictive and probability results.
* Supply executable all-R numerical/computational replication, including a
  Windows process-memory launcher. No Torch or Python runtime is required.

# survlearning 0.1.4.9000

* Add held-out Harrell permutation importance, grouped permutations, and first-order
  accumulated local effects with base-graphics methods.
* Add conditional reliability probabilities, restricted remaining means, and
  explicitly bounded remaining-time grid quantiles without fabricated tail values.
* Add training-only Cox and stratified-KM censoring fits, conditional Brier/AUC,
  and separately named pair-weighted concordance (`ipcw_c`). Historical Uno stays
  marginal; analysis folds learn their own censoring distribution.
* Add local PSOCK tuning grouped by fold, compatible checkpoint recovery, retained
  failed records, and completed-winner reuse. Serial/disk-free defaults remain.
* Add an English sequential example and workflow vignette. No Torch or Python
  dependency is introduced; parallel/tools are bundled R imports.

# survlearning 0.1.3.9000

* Replace neural Cox's external neural runtime with native R matrix operations,
  analytic backpropagation and full-batch Adam. Remove torch and survdnn from
  package dependencies; no Python or neural runtime installation is needed.
* Add Efron (default) and Breslow tie handling, including event/censor ties,
  with matching training-only baselines and stable log-domain calculations.
* Preserve prediction from former adapter weight arrays without its runtime.
  Fixed-epoch diagnostics are not represented as a convergence certificate.

# survlearning 0.1.2.9000

* Extend compact SVM solvers to the additive kernel, using exact sorted-prefix
  kernel products and an adaptive matrix-free eigensolver for the reference's
  unchanged nearPD spectral cutoff. Do not impose an extra fixed rank.
* Add exact duplicate multiplicities, with orthonormally scaled objective,
  equality and bounds. Reconstruct all original dual coefficients before
  rounding; no training observations or their contributions are removed.
* Add additive prefix prediction with the original support-specific ranges,
  including new values outside those ranges. Avoid support-by-query kernels.
* Reject incomplete/ambiguous eigensystems, expose spectral residuals and
  optimization dimensions, and benchmark full-data equivalence, time and RAM.
* Add an explicit Newton dual solver through stats::nlm with analytic gradient
  and generalized Hessian. Eliminate box coordinates analytically, retain
  the equality, and require an independent primal-dual convergence certificate.

# survlearning 0.1.1.9000

* Add explicit linear censored-regression SVM solvers OSQP and Clarabel.
  A diagonal-plus-low-rank Hessian reproduces the reference nearPD correction
  without a dense kernel; this is not a ranking SVM or a kernel approximation.
* Cache training-only SVM design, kernel/Hessian and solver workspace across
  cost candidates within each split. Add a cold reference path (cache = FALSE).
* Compress linear prediction to one coefficient vector, retaining the legacy
  five-decimal support and intercept convention. Saved older fits still predict.
* Expose convergence, constraint violation, objective and solver provenance;
  infeasible reference-solver results can no longer win tuning. Add a dense
  memory planning guard, without automatic subsampling or kernel substitution.
* Add reproducible, isolated-process Windows time/peak-memory benchmarks,
  full-cohort Backblaze verification and an optimization vignette. No public
  release or retroactive change to the frozen manuscript results.

# survlearning 0.1.0.9000

* Preserve the scalar Harrell C-index API; add tabular IPCW evaluation,
  horizon-specific probability scores, grouped calibration and conditional
  bootstrap intervals with censoring-support diagnostics.
* Add reusable repeated, grouped and temporal resampling, nested validation,
  fold-level warnings/failures and optional training-only median/mode imputation.
* Add Kaplan-Meier, spline Cox, Royston-Parmar, componentwise CoxBoost,
  ranger and oblique aorsf adapters, plus native R neural Cox and PLANN.
* Reject tied event times for the current neural Cox engine rather than
  silently changing event times or claiming an unsupported ties correction.
* Add parameter/diagnostic inspection, common held-out comparison, examples,
  vignettes, local pkgdown configuration and a multi-data engineering benchmark.
* Prepare cross-platform CI and a release checklist locally. No GitHub or
  CRAN publication has been performed; maintainer review comes first.

# survlearning 0.0.2.9000

- Prediction reloads and checks the optional engine for saved fits, including
  its registered S3 methods in a fresh R session. Added a regression test.

* Added Cox and semiparametric AFT elastic net with tunable alpha and lambda.
* Added XGBoost Cox with an explicit training-only Breslow baseline.
* Added censored XGBoost AFT with normal, logistic, and extreme errors,
  coherent survival curves, and conditional medians.
* Added MTLR curves and negative restricted mean survival risk scores without
  full-mean or median tail extrapolation, including single-item prediction.
* Extended common C-index tuning, native-equivalence tests, and Spanish examples.
* Fifteen method identifiers are now available; optional engines remain optional.

# survlearning 0.0.1.9000

* Initial development package with ten supported method identifiers.
* Unified fit, event-stratified tuning, native prediction, and C-index APIs.
* Optional backends for penalized AFT/Cox, trees, forests, boosting, and SVM.
* No hidden calibration, automatic subsampling, or new SVM optimizer.
* Spanish sequential reliability example and automated regression tests.

