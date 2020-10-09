regression_sim <- function(simNum, n, b0, b1, b2, b3, x1_mean=0, x1_sd=1, err_mean=0, err_sd=1) {
  x1 <- rnorm(n, mean=x1_mean, sd=x1_sd)
  x2 <- sample(0:1, n, replace=TRUE)
  
  y <- b0 + (b1 * x1) + (b2 * x2) + (b3 * x1 * x2) + rnorm(n, mean=err_mean, sd=err_sd)
  
  model <- lm(y ~ x1 * x2)
  summary(model)
  
  output <- summary(model)$coefficients
  coefs <- output[, 1]
  ps <- output[, 4]
  
  rsq <- summary(model)$r.squared
  
  fsq <- rsq / (1-rsq)
  
  modelPVal <- anova(model)$'Pr(>F)'[1]
  
  results <- c(coefs, ps, rsq, fsq, modelPVal)
  names(results) <- c('b0_coef', 'b1_coef', 'b2_coef', 'b3_coef',
                      'b0_p', 'b1_p', 'b2_p', 'b3_p', 'rsq', 'fsq', 'modelPVal')
  return(results)
}



regression_sim(1, n=100, b0=0, b1=.3, b2=.2, b3=.3)

if(!require('plyr')) install.packages('plyr')  # installs package if not already installed
library('plyr')

num_sims <- 10
sims <- ldply(1:num_sims, regression_sim, n=100, b0=0, b1=.3, b2=.2, b3=.3)

power <- sum(sims$b3_p < .05) / nrow(sims)

sample_sizes <- c(50, 100, 200, 300, 500)
results <- NULL
for (val in sample_sizes) {
  sims <- ldply(1:1000, regression_sim, n=val, b0=0, b1=.3, b2=.2, b3=.3)
  sims$n <- val  # add the sample size in as a separate column to our results
  results <- rbind(results, sims)
}

if(!require('dplyr')) install.packages('dplyr')  # installs package if not already installed
if(!require('ggplot2')) install.packages('ggplot2')
library('dplyr')
library('ggplot2')

power_ests <- results %>%
  group_by(n) %>%
  summarize(power=sum(b3_p < .05 & fsq >= 0.25) / n())

ggplot(power_ests, aes(x=n, y=power)) +
  geom_point() +
  geom_line() +
  ylim(c(0, 1)) +
  theme_minimal()

grid <- expand.grid(n=c(50, 100, 200), b3=c(.2, .5, .8))
results <- NULL
for (row in 1:nrow(grid)) {
  sims <- ldply(1:1000, regression_sim, n=grid[row, 'n'], b0=0,
                b1=.3, b2=.2, b3=grid[row, 'b3'])
  sims$n <- grid[row, 'n']
  sims$b3 <- grid[row, 'b3']
  results <- rbind(results, sims)
}

power_ests2 <- results %>%
  group_by(n, b3) %>%
  summarize(power=sum(b3_p < .05 & fsq >= 0.25) / n())
power_ests2$b3 <- factor(power_ests2$b3)

ggplot(power_ests2, aes(x=n, y=power, group=b3, color=b3)) +
  geom_point() +
  geom_line() +
  ylim(c(0, 1)) +
  theme_minimal()
