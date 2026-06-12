# Executable Code for Measurement Error Tutorial 

# ==============================================================================
# Exercise 1: Classical ME in Outcome
# RQ: Does study time improve GPA?
# ==============================================================================

# %% Setup
library(wooldridge)
d_gpa <- na.omit(gpa1[, c("colGPA", "study")])
set.seed(5)
d_gpa$gpa_noisy <- d_gpa$colGPA + rnorm(nrow(d_gpa), mean = 0, sd = 0.3)

# %% Q1. mean and std
err <- d_gpa$gpa_noisy - d_gpa$colGPA
mean(err)   # ≈ 0.0
sd(err)     # ≈ 0.3

# %% Q2. correlation between proxy and ground truth
cor(d_gpa$colGPA, d_gpa$gpa_noisy)

# %% Q3. Regression comparison
summary(lm(colGPA    ~ study, data = d_gpa))  # true GPA
summary(lm(gpa_noisy ~ study, data = d_gpa))  # noisy GPA




# ==============================================================================
# Exercise 2: Two-Stage Least Squares for ME in Treatment
# Research question: What is the relationship between BMI and systolic blood pressure?
# ==============================================================================

# %% Step 0: Load data and simulate measurement error
d_iv <- na.omit(NHANES[, c("BPSysAve", "BMI")])

set.seed(9)
d_iv$bmi_star <- d_iv$BMI + rnorm(nrow(d_iv), mean = 0, sd = 4)   # noisy regressor
d_iv$iv       <- d_iv$BMI + rnorm(nrow(d_iv), mean = 1, sd = 10)  # instrument

# %% OLS benchmarks
ols_true <- lm(BPSysAve ~ BMI,      data = d_iv)   # true (unobserved) BMI
ols_fit  <- lm(BPSysAve ~ bmi_star, data = d_iv)   # noisy proxy

summary(ols_true)
summary(ols_fit)

# %% 2SLS with ivreg()
library(AER)
iv_fit <- ivreg(BPSysAve ~ bmi_star | iv, data = d_iv)
summary(iv_fit, diagnostics = TRUE)

# %% Compare all three
models <- list(
  "OLS (true BMI)"  = ols_true,
  "OLS (noisy BMI)" = ols_fit,
  "2SLS (ivreg)"    = iv_fit
)

results <- sapply(models, function(m) {
  b  <- round(coef(m)[2], 3)
  se <- round(sqrt(diag(vcov(m)))[2], 3)
  c(estimate = b, se = se)
})

print(results)
# Expected:
#           OLS (true BMI)  OLS (noisy BMI)  2SLS (ivreg)
# estimate         0.644            ~0.499        ~0.644
# se               0.028             0.024        ~0.043
