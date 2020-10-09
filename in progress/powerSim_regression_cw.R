set.seed(1)
n_sims <- 1000 # we want 1000 simulations
p_vals <- c()
power_at_n <- c(0) # this vector will contain the power for each sample-size (it needs the initial 0 for the while-loop to work)
f2s <- c()
f2s_at_n <- c() 
n <- 30 # sample-size 
i <- 2

b0=0
b1= 0




## null setup




for(sim in 1:n_sims){
  
  ### data for model
  
  x1 <- rnorm(n, mean=0, sd=1)
  
  y <- b0 + (b1 * x1) + rnorm(n, mean=0, sd=1)
  
  model <- lm(y ~ x1)
  summary(model)
  
  output <- summary(model)$coefficients
  
  rsq <- summary(model)$r.squared
  fsq <- rsq / (1-rsq)
  modelPVal <- anova(model)$'Pr(>F)'[1]
  
  p_vals[sim] <- modelPVal # run  and extract the p-value of the model
  
  f2s[sim] <- fsq  # we also save the f squared effect sizes that we observed in each simulation
}

power_at_n_null <- mean(p_vals < .05) # check power (i.e. proportion of p-values that are smaller than alpha-level of .05)

f2s_at_n_null <- mean(f2s) # calculate means of fsquared for each sample-size


###


set.seed(1)
n_sims <- 1000 # we want 1000 simulations
p_vals <- c()
power_at_n <- c(0) # this vector will contain the power for each sample-size (it needs the initial 0 for the while-loop to work)
f2s <- c()
f2s_at_n <- c() 
n <- 90 # sample-size 
i <- 2

b1 <- 0.3
b2 <- 0.3
b3 <- 0.3

###  power variables

powerNeeded <- 0.8

###

while(power_at_n[i-1] < powerNeeded){
  for(sim in 1:n_sims){

    ### data for model
    
    x1 <- rnorm(n, mean=0, sd=1)
    x2 <- rnorm(n, mean=0, sd=1)
    
    y <- b0 + (b1 * x1) + (b2 * x2) + (b3 * x1 * x2) + rnorm(n, mean=0, sd=1)
    
    model <- lm(y ~ x1 * x2)
    summary(model)
    
    output <- summary(model)$coefficients
   
    #coefs <- output[, 1]
    #ps <- output[, 4]
    rsq <- summary(model)$r.squared
    fsq <- rsq / (1-rsq)
    modelPVal <- anova(model)$'Pr(>F)'[1]
    
     p_vals[sim] <- modelPVal # run  and extract the p-value of the model
   
      f2s[sim] <- fsq  # we also save the f squared effect sizes that we observed in each simulation
  }
  
  power_at_n[i] <- mean(p_vals < .05) # check power (i.e. proportion of p-values that are smaller than alpha-level of .05)
  
  f2s_at_n[i] <- mean(f2s) # calculate means of fsquared for each sample-size
  
  n <- n+1 # increase sample-size by 1
  i <- i+1 # increase index of the while-loop by 1 to save power and f squared to vector
}
power_at_n <- power_at_n[-1] # delete first 0 from the vector
f2s_at_n <- f2s_at_n[-1] # delete first NA from the vector

data <- as.data.frame(cbind(power_at_n, f2s_at_n))

data %>% ggplot(aes(x = 90:(n-1), y = power_at_n)) + geom_point(size = f2s_at_n)






