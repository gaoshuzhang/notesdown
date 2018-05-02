loaloa$logit <- log((loaloa$NO_INF + 0.5)/(loaloa$NO_EXAM - loaloa$NO_INF + 0.5))
# 在对数据做经验 logit 变换后，计算 kappa 的 profile 似然  
profile.kappa <- shape.matern(formula = logit ~ 1,coords = ~ LONGITUDE + LATITUDE,
								data = loaloa, set.kappa = seq(0.2,2.2, length = 30),
								start.par = c(0.2,0.05), coverage = 0.95,
								messages=FALSE,plot.profile=FALSE)
c(profile.kappa$lower, profile.kappa$upper)
# 0.2138191 1.1045117

profile.kappa$kappa.hat
  # 0.4988948
  
  
mydata$logit <- log((mydata$y + 0.5)/(mydata$units.m - mydata$y + 0.5))
coords <- as.matrix(mydata[, c("x1", "x2")])
vari <- variog(coords = coords, data = mydata$logit,
				uvec = seq(from = 0,to = 3,length.out = 25))

vari.fit <- variofit(vari, ini.cov.pars = c(10, 1),
					  cov.mode = "powered.exponential",
					  fix.nugget = FALSE, nugget = 0.2 , # 既然只是选初始值就没必要把块金效应加上 
					  fix.kappa = TRUE, kappa = 0.5)  # WLSE  带权最小二乘估计
fit.glm <- glm(cbind(y, units.m) ~ 1, data = mydata,
	family = binomial)
par0 <- c(coef(fit.glm), vari.fit$cov.pars, vari.fit$nugget)

par0.exact <- par0 # coef(fit.glm) cov.pars phi sigma nugget
exact.mcmc <- control.mcmc.MCML(n.sim = 15000, burnin = 5000, thin = 5, 
  h = 1.65/(nrow(mydata)^(1/6)))       

system.time(fit.MCML.exact <- binomial.logistic.MCML(y ~ 1, 
  units.m = ~ units.m, coords = ~ x1 + x2,
  data = mydata, par0 = par0.exact, 
  start.cov.pars = c(17,2),
  control.mcmc = exact.mcmc,
  kappa = 2, fixed.rel.nugget = 1, method = "nlminb",
  plot.correlogram = FALSE))

