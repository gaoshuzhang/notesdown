##########################################################################################
## Script 2: Comparing Laplace and MClikelihood through rongelap data ####################
##########################################################################################
## Analysis of rongelap data comparing Laplace and MC Likelihood #########################
## Author: Wagner Hugo Bonat LEG/UFPR ####################################################
## Date: 23/05/2013 ######################################################################
##########################################################################################
# load("rongelap.RData")
## Loading extra packages
require(geoR)
require(geoRglm)
require(Matrix)
require(bbmle)

## Loading extra functions
#source("functions.R")
source("functionssglmm.R")
## Loading rongelap data
data(rongelap)
plot(rongelap)

## Transforming to data frame object
data <- data.frame(rongelap$data, rongelap$coords, offset = rongelap$units.m)
names(data) <- c("y", "coord.X", "coord.Y","offset")

## We will fit eight model to compare the results from Laplace approximation by function glgm() and MC likelihood by function likfit.glsm() from package geoRglm.
## The diferrence between the models are the correlation function (matern and spherical), smooth parameter the matern function (kappa = 0.5, 1.5 and 2.5) and the presence or no the nugget.

##########################################################################################
## Fitting several models ################################################################
##########################################################################################

##########################################################################################
## Fit model 1 - kappa = 0.5 without nugget ##############################################
##########################################################################################

## Obtain initial values
initial = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=FALSE,offset = data$offset)
initial[3] <- log(50)

fit1 <- glgm(y ~ 1, cov.model = "matern", kappa = log(0.5), inits = initial, data=data, coords = data[,2:3], nugget=FALSE,
             family="poisson", offset=data$offset, method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit1)

##########################################################################################
## Fit 2 - kappa = 0.5 with nugget #######################################################
##########################################################################################

## Obtain initial values
initial2 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=TRUE,offset = data$offset)
initial2[3] <- log(50)

fit2 <- glgm(y ~ 1, cov.model = "matern", kappa = log(0.5), inits = initial2, data=data,
             coords = data[,2:3], nugget=TRUE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")

## point estimates
summary.glgm(fit2)

##########################################################################################
## Fit 3 - kappa = 1.5 without nugget ####################################################
##########################################################################################

## Obtain initial values
initial3 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=FALSE,offset = data$offset)
initial3[3] <- log(50)

fit3 <- glgm(y ~ 1, cov.model = "matern", kappa = log(1.5), inits = initial3, data=data,
             coords = data[,2:3], nugget=FALSE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit3)


##########################################################################################
## Fit 4 - kappa = 1.5 with nugget #######################################################
##########################################################################################

## Obtain initial values
initial4 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=TRUE,offset = data$offset)
initial4[3] <- log(50)

fit4 <- glgm(y ~ 1, cov.model = "matern", kappa = log(1.5), inits = initial4, data=data, coords = data[,2:3],
             nugget=TRUE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit4)


##########################################################################################
## Fit 5 - kappa = 2.5 without nugget #######################################################
##########################################################################################

## Obtain initial values
initial5 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=FALSE,offset = data$offset)
initial5[3] <- log(50)

fit5 <- glgm(y ~ 1, cov.model = "matern", kappa = log(2.5), inits = initial5, data=data, coords = data[,2:3],
             nugget=FALSE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit5)


##########################################################################################
## Fit 6 - kappa = 2.5 with nugget #######################################################
##########################################################################################

## Obtain initial values
initial6 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=TRUE,offset = data$offset)
initial6[3] <- log(50)

fit6 <- glgm(y ~ 1, cov.model = "matern", kappa = log(2.5), inits = initial6, data=data, coords = data[,2:3],
             nugget=TRUE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit6)

##########################################################################################
## Fit 7 - spherical  without nugget #####################################################
##########################################################################################

## Obtain initial values
initial7 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=FALSE,offset = data$offset)
initial6[3] <- log(50)

fit7 <- glgm(y ~ 1, cov.model = "spherical", kappa = "NULL", inits = initial7, data=data, coords = data[,2:3],
             nugget=FALSE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit7)

##########################################################################################
## Fit 8 - spherical  with nugget ########################################################
##########################################################################################

## Obtain initial values
initial8 = start.values.glgm(y ~ 1, family="poisson", data= data, coords = data[,2:3],nugget=TRUE,offset = data$offset)
initial8[3] <- log(50)

fit8 <- glgm(y ~ 1, cov.model = "spherical", kappa = "NULL", inits = initial8, data=data, coords = data[,2:3],
             nugget=TRUE, family="poisson", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR")
## point estimates
summary.glgm(fit8)

##########################################################################################
## Comparing the log-likelihood ##########################################################
##########################################################################################

lll.poisson = t(data.frame("Mt0.5" = logLik(fit1[9][[1]]),"Mt0.5 nug" = logLik(fit2[9][[1]]), "Mt1.5" = logLik(fit3[9][[1]]),
    "Mt1.5 nug" = logLik(fit4[9][[1]]),
    "Mt2.5" = logLik(fit5[9][[1]]), "Mt2.5 nug" = logLik(fit6[9][[1]]), "Sph" = logLik(fit7[9][[1]]), "Sph nug" = logLik(fit8[9][[1]])))

points = rbind(c(coef(fit1[9][[1]])[1],fit1[6][[1]],NA),c(coef(fit2[9][[1]])[1],fit2[6][[1]]),c(coef(fit3[9][[1]])[1],fit3[6][[1]],NA),c(coef(fit4[9][[1]])[1],fit4[6][[1]]),
c(coef(fit5[9][[1]])[1],fit5[6][[1]],NA),c(coef(fit6[9][[1]])[1],fit6[6][[1]]),c(coef(fit7[9][[1]])[1],fit7[6][[1]],NA),c(coef(fit8[9][[1]])[1],fit8[6][[1]]))
colnames(points) <- c("Int", "sigma2", "phi", "tau2")
round(points,4)

##########################################################################################
## Fitting the same models with geoRglm by MC likelihood #################################
##########################################################################################

## Initial points
beta = initial[1]
sigma2 <- exp(initial[2])
phi <- 50

## Tunning the algorithm
mcmc.1 <- list(cov.pars=c(sigma2, phi), link="log", beta=beta,family="poisson")
S.prop <- mcmc.control(S.scale=0.1, thin=10)

tune.S <- glsm.mcmc(rongelap, model=mcmc.1, mcmc.input=S.prop)
S.control <- mcmc.control(S.scale=0.5, thin=50, burn.in=20000)

S.sims <- glsm.mcmc(rongelap, model=mcmc.1, mcmc.in = S.control)
lik.control <- prepare.likfit.glsm(S.sims)

##########################################################################################
## Fit 1 - kappa = 0.5 without nugget ####################################################
##########################################################################################
mc.fit1 <- likfit.glsm(lik.control, ini.phi=50, fix.nugget.rel = TRUE)
mc.fit1

##########################################################################################
## Fit 2 - kappa = 0.5 with nugget #######################################################
##########################################################################################
mc.fit2 <- likfit.glsm(lik.control, ini.phi=50, fix.nugget.rel = FALSE)
mc.fit2

##########################################################################################
## Fit 3 - kappa = 1.5 without nugget ####################################################
##########################################################################################
mc.fit3 <- likfit.glsm(lik.control, ini.phi=50, cov.model = "matern", kappa=1.5, fix.nugget.rel = TRUE)
mc.fit3

##########################################################################################
## Fit 4 - kappa = 1.5 with nugget #######################################################
##########################################################################################
mc.fit4 <- likfit.glsm(lik.control, ini.phi=50, cov.model = "matern", kappa=1.5, fix.nugget.rel = FALSE)
mc.fit4

##########################################################################################
## Fit 5 -  kappa = 2.5 without nugget ###################################################
##########################################################################################
mc.fit5 <- likfit.glsm(lik.control, ini.phi=50, cov.model = "matern", kappa=2.5, fix.nugget.rel = TRUE)
mc.fit5

##########################################################################################
## Fit 6 -  kappa = 2.5 with nugget ######################################################
##########################################################################################
mc.fit6 <- likfit.glsm(lik.control, ini.phi=50, cov.model = "matern", kappa=2.5, fix.nugget.rel = FALSE)
mc.fit6

##########################################################################################
## Fit 7 - spherical without nugget ######################################################
##########################################################################################
mc.fit7 <- likfit.glsm(lik.control, ini.phi=50, cov.model = "spherical", fix.nugget.rel = TRUE)
mc.fit7

##########################################################################################
## Fit 8 - spherical with nugget #########################################################
##########################################################################################
mc.fit8 <- likfit.glsm(lik.control, ini.phi=50, cov.model="spherical" , fix.nugget.rel = FALSE)
mc.fit8

points.mc  = data.frame(rbind(mc.fit1$parameters.summary[,2][-5],mc.fit2$parameters.summary[,2][-5],mc.fit3$parameters.summary[,2][-5],mc.fit4$parameters.summary[,2][-5],mc.fit5$parameters.summary[,2][-5],  mc.fit6$parameters.summary[,2][-5],mc.fit7$parameters.summary[,2][-5],mc.fit8$parameters.summary[,2][-5]))

points.mc$tau2 <- points.mc$X2*points.mc$X4

## beta
compara = data.frame(round(cbind(points[,1],points.mc[,1], points[,2],points.mc[,2], points[,3], points.mc[,3], points[,4], points.mc[,5]),4))
names(compara) <- c("LNR-Beta", "MC-Beta", "LNR-sigma2", "MC-sigma2", "LNR-phi", "MC-phi", "LNR-tau2", "MC-tau2")
cbind(compara,4)
round(cbind(compara,lll.poisson),2)

##########################################################################################
## The results are very similar ##########################################################
##########################################################################################

## In the second analysis we will compare the fit with the poisson distribution and Negative Binomial distribution

##########################################################################################
## Fit 1 - kappa = 0.5 without nugget ####################################################
##########################################################################################
initial = start.values.glgm(y ~ 1, family="negative.binomial", data= data, coords = data[,2:3], nugget=FALSE,offset = data$offset)
initial[3] <- log(50)
fit1.bn <- glgm(y ~ 1, cov.model = "matern", kappa = log(0.5), inits = initial, data=data, coords = data[,2:3],
                nugget=FALSE, family="negative.binomial", offset=data$offset,
                method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit1.bn[9][[1]])

##########################################################################################
## Fit 2 - kappa = 0.5 with nugget #######################################################
##########################################################################################
initial2 = start.values.glgm(y ~ 1, family="negative.binomial", data= data, coords = data[,2:3], nugget=TRUE,offset = data$offset)

fit2.bn <- glgm(y ~ 1, cov.model = "matern", kappa = log(0.5), inits = initial2, data=data, coords = data[,2:3],
                nugget=TRUE, family="negative.binomial", offset=data$offset,
                method.optim = "BFGS", method.integrate = "NR",predict=TRUE)
## point estimates
summary(fit2.bn[9][[1]])
summary.glgm(fit2.bn)


##########################################################################################
## Fit 3 - kappa = 1.5 without nugget #######################################################
##########################################################################################
fit3.bn <- glgm(y ~ 1, cov.model = "matern", kappa = log(1.5), inits = initial, data=data, coords = data[,2:3],
                nugget=FALSE, family="negative.binomial", offset=data$offset,
                method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit3.bn[9][[1]])
summary.glgm(fit3.bn)

##########################################################################################
## Fit 4 - kappa = 1.5 with nugget #######################################################
##########################################################################################
fit4.bn <- glgm(y ~ 1, cov.model = "matern", kappa = log(1.5), inits = initial2, data=data, coords = data[,2:3],
                nugget=TRUE, family="negative.binomial", offset=data$offset,
                method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit4.bn[9][[1]])
summary.glgm(fit4.bn)


##########################################################################################
## Fit 5 - kappa = 2.5 without nugget #######################################################
##########################################################################################
fit5.bn <- glgm(y ~ 1, cov.model = "matern", kappa = log(2.5), inits = initial, data=data, coords = data[,2:3],
                nugget=FALSE, family="negative.binomial", offset=data$offset,
                method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit5.bn[9][[1]])
summary.glgm(fit5.bn)

##########################################################################################
## Fit 6 - kappa = 2.5 with nugget #######################################################
##########################################################################################
fit6.bn <- glgm(y ~ 1, cov.model = "matern", kappa = log(2.5), inits = initial2, data=data, coords = data[,2:3],
                nugget=TRUE, family="negative.binomial", offset=data$offset,
                method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit6.bn[9][[1]])
summary.glgm(fit6.bn)

##########################################################################################
## Fit 7 - spherical without nugget ######################################################
##########################################################################################
fit7.bn <- glgm(y ~ 1, cov.model = "spherical", kappa = "NULL", inits = initial, data=data, coords = data[,2:3],
                nugget=FALSE, family="negative.binomial", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit7.bn[9][[1]])
summary.glgm(fit7.bn)

##########################################################################################
## Fit 8 - spherical with nugget #########################################################
##########################################################################################
fit8.bn <- glgm(y ~ 1, cov.model = "spherical", kappa = "NULL", inits = initial2, data=data,
                coords = data[,2:3], nugget=TRUE, family="negative.binomial", offset=data$offset,
             method.optim = "BFGS", method.integrate = "NR",predict=TRUE)

## point estimates
summary(fit8.bn[9][[1]])
summary.glgm(fit8.bn)

##########################################################################################
## Comparing the models ##################################################################
##########################################################################################
ll.negbin = t(data.frame("Mt0.5" = logLik(fit1.bn[9][[1]]),"Mt0.5 nug" = logLik(fit2.bn[9][[1]]),
    "Mt1.5" = logLik(fit3.bn[9][[1]]), "Mt1.5 nug" = logLik(fit4.bn[9][[1]]),
           "Mt2.5" = logLik(fit5.bn[9][[1]]), "Mt2.5 nug" = logLik(fit6.bn[9][[1]]), "Sph" = logLik(fit7.bn[9][[1]]), "Sph nug" = logLik(fit8.bn[9][[1]])))


tabela.bn <- cbind(
    c(coef(fit1.bn[[1]])[1:2],NA,coef(fit1.bn[[1]])[3:4]),
    c(coef(fit2.bn[[1]])[1:2], coef(fit2.bn[[1]])[4], coef(fit2.bn[[1]])[c(3,5)]),
    c(coef(fit3.bn[[1]])[1:2],NA,coef(fit3.bn[[1]])[3:4]),
    c(coef(fit4.bn[[1]])[1:2], coef(fit4.bn[[1]])[4], coef(fit4.bn[[1]])[c(3,5)]),
    c(coef(fit5.bn[[1]])[1:2],NA,coef(fit5.bn[[1]])[3:4]),
    c(coef(fit6.bn[[1]])[1:2], coef(fit6.bn[[1]])[4], coef(fit6.bn[[1]])[c(3,5)]),
    c(coef(fit7.bn[[1]])[1:2],NA,coef(fit7.bn[[1]])[3:4]),
    c(coef(fit8.bn[[1]])[1:2], coef(fit8.bn[[1]])[4], coef(fit8.bn[[1]])[c(3,5)]))
    
t(tabela.bn)    
round(tabela.bn, 2)
colnames(points.bn) <- c("Int", "sigma2", "phi", "tau2", "prec")
round(points.bn,8)

## Comparing Negative Binomial with Poisson
data.frame(lll.poisson,ll.negbin, "sum"=lll.poisson+ll.negbin)

## Better fit with Matern kappa = 2.5 and nugget by Poisson and Matern kappa = 2.5 without nugget by Negative Binomial
round(points,4)[6,]
round(points.bn,4)[5,]

## Profile
method.optim = "BFGS"
prof.poisson <- profile(fit6[[9]])
plot(prof.poisson)

## Profile
prof.bn.beta <- profile(fit5.bn[9][[1]], which=1)
prof.bn.sigma <- profile(fit5.bn[9][[1]], which=2)
prof.bn.phi <- profile(fit5.bn[9][[1]], which=3, prof.lower  = 1, prof.upper = 8.5)
prof.bn.prec <- profile(fit5.bn[9][[1]], which=4)
par(mfrow=c(2,2))
plot(prof.bn.beta)
plot(prof.bn.sigma)
plot(prof.bn.phi)
plot(prof.bn.prec)

summary(fit5.bn[9][[1]])
summary(fit6.bn[9][[1]])

save.image("rongelap.RData")
