
# 产生数据
library(mvtnorm)
library(geoR)
library(sp)
library(RandomFieldsUtils)
library(RandomFields)
set.seed(2018)
# 协方差矩阵 模拟二元正态分布
sigma <- matrix(c(2, .2, .2, 3), byrow = TRUE, ncol = 2)
N <- 1600 # N <- 10000
data.x <- cbind(rep(1, N), rmvnorm(n = N, mean = c(1, 2), sigma = sigma))
data.z <- rnorm(N, mean = 0, sd = 3)
beta <- c(1.2, 1, 0.2) # beta_0 = 1.2 是截距
# 添加空间随机效应 sigma^2 = 1 phi = 25 tau^2 =1 kappa = 1
# 不规则网络
exp_irreg_S <- grf(N,
                   grid = "irreg", nx = N, ny = N,
                   xlims = c(0, 100), ylims = c(0, 100), nsim = 1, mean = 0,
                   cov.mode = "powered.exponential",
                   cov.par = c(1, 25), nugget = 1, kappa = 1
)
# 规则网络 产生 N*N 个点
exp_reg_S <- grf(sqrt(N),
                 grid = "reg", nx = sqrt(N), ny = sqrt(N),
                 xlims = c(0, 100), ylims = c(0, 100), nsim = 1, mean = 0,
                 cov.mode = "powered.exponential",
                 cov.par = c(1, 25), nugget = 1, kappa = 1
)

# 不规则网络
matern_irreg_S <- grf(N,
                      grid = "irreg", nx = N, ny = N,
                      xlims = c(0, 100), ylims = c(0, 100), nsim = 1, mean = 0,
                      cov.mode = "matern",
                      cov.par = c(1, 25), nugget = 1, kappa = .5
)

# 规则网络 产生 N*N 个点
matern_reg_S <- grf(sqrt(N),
                    grid = "reg", nx = sqrt(N), ny = sqrt(N),
                    xlims = c(0, 100), ylims = c(0, 100), nsim = 1, mean = 0,
                    cov.mode = "matern",
                    cov.par = c(1, 25), nugget = 1, kappa = .5
)

pdf(file = 'reg-gp.pdf',width = 8,height = 8)
mycols <- colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral")))(30)
op <- par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
image(exp_reg_S, asp = NA, col = mycols)
image(matern_reg_S, asp = NA, col = mycols)
points(exp_reg_S, col = mycols)
points(matern_reg_S, col = mycols)
par(op)
dev.off()


pdf(file = 'irreg-gp.pdf',width = 13,height = 6)
mycols <- colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral")))(30)
op <- par(mfrow = c(1, 2), mar = c(4, 2, 1, .5))
points(exp_irreg_S, col = mycols)
points(matern_irreg_S, col = mycols)
par(op)
dev.off()


mu <- exp(exp_reg_S$data + data.x %*% beta) / (1 + exp(exp_reg_S$data + data.x %*% beta))
binom.data.y <- rbinom(N, size = 100, prob = mu)

binom_exp_reg_sim <- cbind.data.frame(binom.data.y, exp_reg_S$coord, data.x, data.z)

colnames(binom_exp_reg_sim) <- c("y","x1","x2","d1","d2","d3","z")

library(MASS)
library(nlme) # will be loaded automatically if omitted

# d1 作为常数项视为虚假随机效应

binom_exp_reg_sim_fit <- glmmPQL(y ~ d2 + d3, random = ~ 1 | d1,
                                 correlation = corExp(form = ~ x1 + x2 | d1),
                                 family = binomial, data = binom_exp_reg_sim
)

# iteration 1
# iteration 2
# iteration 3
# Warning message:
# In eval(family$initialize) : non-integer #successes in a binomial glm!
# 
# summary(binom_exp_reg_sim_fit)
# Linear mixed-effects model fit by maximum likelihood
#  Data: binom_exp_reg_sim 
#   AIC BIC logLik
#    NA  NA     NA
# 
# Random effects:
#  Formula: ~1 | d1
#          (Intercept)  Residual
# StdDev: 5.945984e-05 0.4092199
# 
# Correlation Structure: Exponential spatial correlation
#  Formula: ~x1 + x2 | d1 
#  Parameter estimate(s):
#    range 
# 1.866339 
# Variance function:
#  Structure: fixed weights
#  Formula: ~invwt 
# Fixed effects: y ~ d2 + d3 
#                 Value  Std.Error   DF  t-value p-value
# (Intercept) 0.9561796 0.05497952 1597 17.39156       0
# d2          0.7795871 0.02445972 1597 31.87228       0
# d3          0.1358919 0.01618551 1597  8.39590       0
#  Correlation: 
#    (Intr) d2    
# d2  0.266       
# d3 -0.423  0.012
# 
# Standardized Within-Group Residuals:
#        Min         Q1        Med         Q3        Max 
# -5.7465519 -0.3581836  0.3154303  0.6250068  2.7649474 
# 
# Number of Observations: 1600
# Number of Groups: 1 

# https://stackoverflow.com/questions/32038355/r-glmm-glmer-vs-glmmpql

library(spaMM)

lfit <- corrHLfit(cbind(y, 100 - y) ~ d1 + d2 + d3 + z
                  + Matern(1 | x1 + x2),
                  HLmethod = "HL(0,1)", data = binom_exp_reg_sim,
                  family = binomial(), ranFix = list(nu = 0.5, rho = 2.255197, lambda = 1.075)
)

summary(lfit)

# formula: cbind(y, 100 - y) ~ d1 + d2 + d3 + z + Matern(1 | x1 + x2)
# Estimation of corrPars by Laplace REML approximation (p_bv).
# Estimation of fixed effects by h-likelihood approximation.
# Family: binomial ( link = logit ) 
#  ------------ Fixed effects (beta) ------------
#             Estimate Cond. SE t-value
# (Intercept)  1.11401 0.045439  24.517
# d1                NA       NA      NA
# d2           0.93369 0.021829  42.773
# d3           0.17367 0.016924  10.262
# z           -0.01515 0.009751  -1.553
#  --------------- Random effects ---------------
# Family: gaussian ( link = identity ) 
#                    --- Correlation parameters:
#    1.rho     1.nu 
# 2.255197 0.500000 
#            --- Variance parameters ('lambda'):
# lambda = var(u) for u ~ Gaussian; 
#    x1 + x2  :  1.075 [fixed] 
# # of obs: 1600; # of groups: x1 + x2, 1600 
#  ------------- Likelihood values  -------------
#                         logLik
#        h-likelihood: -5533.244
# p_v(h) (marginal L): -5638.748
#   p_beta,v(h) (ReL): -5651.148


library(maps)

pdf(file = "spaMM-simulation.pdf", width = 6, height = 4, pointsize = 10)
par(mar = c(4, 4, 2, 0))

filled.mapMM(lfit,
             key.title = title(main = "ratio"), 
             # key.axes = axis(4, seq(0, 1, by = .2)),
             color.palette = colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral"))),
             map.asp = 1, gridSteps = 61, var.contour.args = list(add = FALSE),
             add.map = FALSE, plot.axes = quote({ # 取消地图背景，这是模拟数据
               axis(1)
               axis(2)
             }),
             decorations = NULL,
             plot.title = title(
               main = "Inferred prevalence, Simulation",
               xlab = "X Coord", ylab = "Y Coord"
             )
)
dev.off()

# plot(S$coords,
#   type = "p", pch = 16, xlab = "X Coord", ylab = "Y Coord",
#   col = terrain.colors(11)[binom.data.y * 10]
# )
# 绘制响应变量随空间位置变化的散点图，颜色从蓝到红，变量的值由0到1
library(ggplot2)
ggplot(data = as.data.frame(S$coords), aes(x = x, y = y, colour = binom.data.y)) + 
  geom_point(pch = 16, size = 3, alpha = .8) +	
  scale_colour_distiller(palette = "Spectral") +
  labs(colour = "Prob",x = "X Coord",y = "Y Coord")




loc = matrix(runif(32*2, min = -0.2, max = 1.2), 32, 2) 

mesh = inla.mesh.2d(loc,
                    boundary=list(inla.nonconvex.hull(loc, 0.1, 0.15),
                                  inla.nonconvex.hull(loc, 0.2, 0.2)),
                    max.edge=c(0.05, 0.1))
plot(mesh)

system.time(fit.SPDE.exact <- binomial.logistic.MCML(y ~ 1,
                                                     units.m = ~ units.m, coords = ~ x1 + x2,
                                                     data = data_sim, par0 = par0.exact,
                                                     start.cov.pars = 0.15, mesh = mesh,
                                                     control.mcmc = exact.mcmc, SPDE = TRUE,
                                                     kappa = 1, fixed.rel.nugget = 0, method = "nlminb", # kappa = 1 only for SPDE
                                                     plot.correlogram = FALSE
))


par.hat <- coef(fit.SPDE.exact)
Sigma.hat <- varcov.spatial(
  coords = data_sim[c("x1", "x2")],
  cov.pars = par.hat[2:3], kappa = 1
)$varcov
# 重要性采样 近似高维积分
mu.hat <- rep(par.hat[1], nrow(data_sim))
system.time(S.cond.sim <- Laplace.sampling(
  mu = mu.hat, Sigma = Sigma.hat, y = data_sim$y,
  units.m = data_sim$units.m, control.mcmc = exact.mcmc,
  plot.correlogram = FALSE
))

Conditional simulation (burnin=5000, thin=5): 
  Iteration 15000 out of 15000 
user  system elapsed 
329.530 368.020 233.725 

# 模拟近似的和精确的 prevalence 预测
prevalence.sim <- exp(S.cond.sim$samples) / (1 + exp(S.cond.sim$samples))
prevalence.exact <- apply(prevalence.sim, 2, mean)

mycols <- colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral")))(30)
r.exact <- rasterFromXYZ(cbind(
  data_sim[, c("x1", "x2")],
  prevalence.exact
))

pdf(file = 'INLA-simulation.pdf',width = 8,height = 7.2)
plot(r.exact, zlim = c(0, 1), main = "INLA method", col = mycols, asp = NA)
contour(r.exact, levels = seq(0.1, 0.9, 0.1), add = TRUE)
dev.off()

pdf(file = 'mesh-spde.pdf',width = 8,height = 7.2)
par(mar = c(.5,.5,.5,.5))
plot(mesh, main = "")
dev.off()



# 生成 data_sim 数据集
# data.x
# binom.data.y 

# binomial.logistic.MCML #支持多元协变量 
library(PrevMap)
data("data_sim")

knots1 <- expand.grid(
  seq(-0.2, 1.2, length = 8),
  seq(-0.2, 1.2, length = 8)
)
knots2 <- expand.grid(
  seq(-0.2, 1.2, length = 16),
  seq(-0.2, 1.2, length = 16)
)
knots3 <- expand.grid(
  seq(-0.2, 1.2, length = 32),
  seq(-0.2, 1.2, length = 32)
)
# 精确计算
par0.exact <- c(0, 1, 0.15)
exact.mcmc <- control.mcmc.MCML(
  n.sim = 15000, burnin = 5000, thin = 5,
  h = 1.65 / (nrow(data_sim)^(1 / 6))
)
system.time(fit.MCML.exact <- binomial.logistic.MCML(y ~ 1,
                                                     units.m = ~ units.m, coords = ~ x1 + x2,
                                                     data = data_sim, par0 = par0.exact,
                                                     start.cov.pars = 0.15,
                                                     control.mcmc = exact.mcmc,
                                                     kappa = 2, fixed.rel.nugget = 0, method = "nlminb",
                                                     plot.correlogram = FALSE
))

# Fixed relative variance of the nugget effect: 0 
# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Estimation: 
#   0:    -0.0000000:  0.00000  0.00000 -1.89712
#   1:  -0.096588322: 0.00221774 -0.00353693 -1.88858
#   2:   -0.22173788: 0.00735497 -0.0104126 -1.87278
#   3:   -0.97752221: 0.255598 -0.181303 -1.91676
#   4:    -1.2385645: 0.613893 -0.535106 -2.00673
#   5:    -1.3523607: 0.517397 -0.434678 -1.98096
#   6:    -1.3544228: 0.503688 -0.417004 -1.97647
#   7:    -1.3544238: 0.503373 -0.416617 -1.97637
#   8:    -1.3544238: 0.503373 -0.416617 -1.97637
#    user  system elapsed 
#  839.57   18.94  858.19

##################SPDE###################################

loc = matrix(runif(32*2, min = -0.2, max = 1.2), 32, 2) 

mesh = inla.mesh.2d(loc,
                    boundary=list(inla.nonconvex.hull(loc, 0.1, 0.15),
                                  inla.nonconvex.hull(loc, 0.2, 0.2)),
                    max.edge=c(0.05, 0.1))
plot(mesh)

system.time(fit.SPDE.exact <- binomial.logistic.MCML(y ~ 1,
                                                     units.m = ~ units.m, coords = ~ x1 + x2,
                                                     data = data_sim, par0 = par0.exact,
                                                     start.cov.pars = 0.15, mesh = mesh,
                                                     control.mcmc = exact.mcmc, SPDE = TRUE,
                                                     kappa = 1, fixed.rel.nugget = 0, method = "nlminb", # kappa = 1 only for SPDE
                                                     plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Estimation: 
#   0: 2.3347990e-13:  0.00000  6.32526 -1.89712
#   1:    -2.1974354: 0.0102003  6.23976 -1.92820
#   2:    -2.8459807: 0.0325185  6.21985 -1.94023
#   3:    -3.3978720: 0.0709544  6.23206 -2.00562
#   4:    -3.4350001: 0.0794023  6.24118 -2.00005
#   5:    -3.4402187: 0.0768922  6.23986 -2.00120
#   6:    -3.4402292: 0.0767705  6.23980 -2.00126
#   7:    -3.4402292: 0.0767701  6.23980 -2.00126
#    user  system elapsed 
# 111.170   7.600 118.238


# 近似计算 low-rank  参数估计 分3种粒度 记录程序运行的时间
par0.lr <- c(-0.219294, 0.97945, 0.21393)
lr.mcmc <- control.mcmc.MCML(
  n.sim = 15000, burnin = 5000, thin = 5,
  h = 1.65 / (nrow(knots1)^(1 / 6))
)

system.time(fit.MCML.lr1 <- binomial.logistic.MCML(y ~ 1,
                                                   units.m = ~ units.m, coords = ~ x1 + x2,
                                                   data = data_sim, par0 = par0.lr,
                                                   start.cov.pars = par0.lr[3], control.mcmc = lr.mcmc,
                                                   low.rank = TRUE, knots = knots1, kappa = 2,
                                                   method = "nlminb", plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Estimation: 
#   0:    -0.0000000: -0.219294 -1.61996 -0.502386
#   1:    -1.9700794: -0.204222 -1.64731 -0.415457
#   2:    -5.5861874: -0.249859 -2.04459 -0.432375
#   3:    -7.0904812: -0.298889 -2.12859 -0.427948
#   4:    -8.1851010: -0.316596 -2.13015 -0.436352
#   5:    -9.5082331: -0.355437 -2.13856 -0.425871
#   6:    -10.067565: -0.372897 -2.17102 -0.407318
#   7:    -10.974438: -0.380679 -2.40809 -0.400481
#   8:    -10.975223: -0.380693 -2.41513 -0.400440
#   9:    -10.975223: -0.380693 -2.41510 -0.400440
#  10:    -10.975223: -0.380693 -2.41510 -0.400440
#    user  system elapsed 
#   74.11    1.47   75.77

lr.mcmc$h <- 1.65 / (nrow(knots2)^(1 / 6))
par0.lr <- c(-0.017333, 0.16490, 0.16971)
system.time(fit.MCML.lr2 <- binomial.logistic.MCML(y ~ 1,
                                                   units.m = ~ units.m, coords = ~ x1 + x2,
                                                   data = data_sim, par0 = par0.lr,
                                                   start.cov.pars = par0.lr[3], control.mcmc = lr.mcmc,
                                                   low.rank = TRUE, knots = knots2, kappa = 2,
                                                   method = "nlminb", plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Estimation: 
#   0:    -0.0000000: -0.0173330 -4.16441 -0.733943
#   1:    -1.4156772: -0.000845313 -4.19508 -0.645052
#   2:    -1.6032590: -0.00360549 -4.27732 -0.647427
#   3:    -1.6133414: 0.000503305 -4.29473 -0.654881
#   4:    -1.6136570: 0.00136614 -4.29962 -0.656305
#   5:    -1.6136571: 0.00137241 -4.29971 -0.656335
#   6:    -1.6136571: 0.00137240 -4.29971 -0.656335
#    user  system elapsed 
#  144.46    9.01  153.56 

lr.mcmc$h <- 1.65 / (nrow(knots3)^(1 / 6))
par0.lr <- c(-0.031759, 0.30572, 0.18854)
system.time(fit.MCML.lr3 <- binomial.logistic.MCML(y ~ 1,
                                                   units.m = ~ units.m, coords = ~ x1 + x2,
                                                   data = data_sim, par0 = par0.lr,
                                                   start.cov.pars = par0.lr[3], control.mcmc = lr.mcmc,
                                                   low.rank = TRUE, knots = knots3, kappa = 2,
                                                   method = "nlminb", plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Estimation: 
#   0:    -0.0000000: -0.0317590 -4.26470 -0.628724
#   1:    -4.2142054: -0.0243050 -4.29660 -0.542862
#   2:    -5.0398103: -0.00729183 -4.32851 -0.530939
#   3:    -5.3459532: -0.0146437 -4.36908 -0.525692
#   4:    -5.3511289: -0.0147919 -4.36446 -0.526091
#   5:    -5.3511292: -0.0147946 -4.36443 -0.526097
#   6:    -5.3511292: -0.0147946 -4.36443 -0.526097
#    user  system elapsed 
#  901.22  118.55 1019.87 


# 提取系数
par.hat <- coef(fit.MCML.exact)
Sigma.hat <- varcov.spatial(
  coords = data_sim[c("x1", "x2")],
  cov.pars = par.hat[2:3], kappa = 2
)$varcov
# 重要性采样 近似高维积分
mu.hat <- rep(par.hat[1], nrow(data_sim))
system.time(S.cond.sim <- Laplace.sampling(
  mu = mu.hat, Sigma = Sigma.hat, y = data_sim$y,
  units.m = data_sim$units.m, control.mcmc = exact.mcmc,
  plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
#    user  system elapsed 
#  278.84   47.99  327.77 

# 模拟近似的和精确的 prevalence 预测
prevalence.sim <- exp(S.cond.sim$samples) / (1 + exp(S.cond.sim$samples))
prevalence.exact <- apply(prevalence.sim, 2, mean)

## 预测 分3种粒度
lr.mcmc$h <- 1.65 / (nrow(knots1)^(1 / 6))
system.time(pred.MCML.lr1 <- spatial.pred.binomial.MCML(fit.MCML.lr1,
                                                        grid.pred = data_sim[c("x1", "x2")], control.mcmc = lr.mcmc,
                                                        type = "joint", scale.predictions = "prevalence",
                                                        plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Spatial predictions: prevalence 
#    user  system elapsed 
#   37.83    0.93   38.78

lr.mcmc$h <- 1.65 / (nrow(knots2)^(1 / 6))
system.time(pred.MCML.lr2 <- spatial.pred.binomial.MCML(fit.MCML.lr2,
                                                        grid.pred = data_sim[c("x1", "x2")], control.mcmc = lr.mcmc,
                                                        type = "joint", scale.predictions = "prevalence",
                                                        plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Spatial predictions: prevalence 
#    user  system elapsed 
#   83.76    6.95   90.78 

lr.mcmc$h <- 1.65 / (nrow(knots3)^(1 / 6))
system.time(pred.MCML.lr3 <- spatial.pred.binomial.MCML(fit.MCML.lr3,
                                                        grid.pred = data_sim[c("x1", "x2")], control.mcmc = lr.mcmc,
                                                        type = "joint", scale.predictions = "prevalence",
                                                        plot.correlogram = FALSE
))

# Conditional simulation (burnin=5000, thin=5): 
# Iteration 15000 out of 15000 
# Spatial predictions: prevalence 
#    user  system elapsed 
#  643.09  130.62  773.80



# 画图展示  images of estimated surfaces of prevalence
# pdf(file = 'figure/simulation.pdf',width = 8,height = 7.2)
# mycols <- viridisLite::viridis(30)
mycols <- colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral")))(30)
op <- par(mfrow = c(2, 2), mar = c(3, 4, 3, 4))
r.exact <- rasterFromXYZ(cbind(
  data_sim[, c("x1", "x2")],
  prevalence.exact
))
plot(r.exact, zlim = c(0, 1), main = "Exact method", col = mycols)
contour(r.exact, levels = seq(0.1, 0.9, 0.1), add = TRUE)

plot(pred.MCML.lr1, "prevalence", "predictions",
     zlim = c(0, 1),
     main = "Low-rank: 64 knots", col = mycols
)
contour(pred.MCML.lr1, "prevalence", "predictions",
        zlim = c(0, 1),
        levels = seq(0.1, 0.9, 0.1), add = TRUE
)

plot(pred.MCML.lr2, "prevalence", "predictions",
     zlim = c(0, 1),
     main = "Low-rank: 256 knots", col = mycols
)
contour(pred.MCML.lr2, "prevalence", "predictions",
        zlim = c(0, 1),
        levels = seq(0.1, 0.9, 0.1), add = TRUE
)

plot(pred.MCML.lr3, "prevalence", "predictions",
     zlim = c(0, 1),
     main = "Low-rank: 1024 knots", col = mycols
)
contour(pred.MCML.lr3, "prevalence", "predictions",
        zlim = c(0, 1),
        levels = seq(0.1, 0.9, 0.1), add = TRUE
)
par(op)

# dev.off()



## 泊松分布 空间随机效应和协变量同上
lambda <- exp(S$data + data.x %*% beta)
pois.data.y <- rpois(length(S$data), lambda = lambda)

ggplot(
  data = as.data.frame(S$coords),
  aes(x = x, y = y, colour = log(pois.data.y + 1))
) +
  geom_point(pch = 16, size = 3, alpha = .8) +
  scale_colour_distiller(palette = "Spectral") +
  labs(colour = "对数\n观察数目", x = "横坐标", y = "纵坐标")

