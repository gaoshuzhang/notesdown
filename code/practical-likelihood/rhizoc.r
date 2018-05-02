##########################################################################################
## Data analysis 1 - Rizhoctonia root rot data set #######################################
## Binomial spatial generalized linear mixed models ######################################
## Author: Wagner Hugo Bonat LEG/IMADA ###################################################
## Date: 18/06/2014 ######################################################################
##########################################################################################
## Results from Evangelos et. al. (2011)

trans <- c(-1.7601,0.1254,0.6360,151.2)
LA1 <- c(-1.7248,0.0818,0.4901,149.1)
LA2a <- c(-1.7188,0.1021,0.4723,148.6)
LA2b <- c(-1.7185,0.1065,0.4681,148.8)
SML <- c(-1.7187,0.1048,0.4716,148.3)
MCEM <- c(-1.6152,0.1754,0.3451,145.11)
## Loading extra packages
require(geoR)
require(geoRglm)
require(Matrix)
require(bbmle)

## Loading extra functions
#source("functions.R")
source("functionssglmm.R")
## Loading the data set
load("Rhizoc.RData")

## Change the names
names(Rhizoc) <- c("coord.X","coord.Y", "N.trials", "Y", "Yield")

## Get initial values
initial = start.values.glgm(Y ~ 1, family="binomial", data= Rhizoc, coords = Rhizoc[,1:2],nugget=TRUE, ntrial=Rhizoc$N.trials)
data.geo <- as.geodata(data.frame(Rhizoc[,1:2],res))
plot(variog(data.geo)) ## Look here a big nugget effect, so in this case my initial point is not good, because the nugget is bigger than partial sill.
initial[4] <- 1.1*initial[2]

## Fitting Binomial SGLMM
fit1 <- glgm(Y ~ 1, cov.model = "spherical", kappa = log(0.5), inits = initial, data=Rhizoc, coords = Rhizoc[,1:2],
             nugget=TRUE, family="binomial", ntrial = Rhizoc$N.trials,
             method.optim = "BFGS", method.integrate = "NR")
fit1[[9]]
LAPLACE <- coef(fit1[[1]])[,1]

## Extended analysis
## Profile likelihood
method.optim = "BFGS"
# Intercept
perf.b0 <- profile(fit1[[9]], which = 1, alpha = 0.10)
plot(perf.b0,plot.confstr=TRUE,show.points=TRUE)
## Partial sill
perf.sigma <- profile(fit1[[9]], which = 2, zmax = 2)
plot(perf.sigma,plot.confstr=TRUE,show.points=TRUE)

## Nugget
perf.nugget <- profile(fit1[[9]], which = 4, zmax = 2)
plot(perf.nugget,plot.confstr=TRUE,show.points=TRUE)

## Range
perf.range <- profile(fit1[[9]], which = 3, zmax = 2)
plot(perf.range,plot.confstr=TRUE,show.points=TRUE)



##################################################################################################
## Evaluating the approximated log-likelihood function using the estimates from different methods#
##########################################################################################
formula <- Y ~ 1
formula <- as.formula(formula)
mf <- model.frame(formula,data=Rhizoc)
Y <- model.response(mf)
X <- model.matrix(formula, data=Rhizoc)
mat.dist <- dist(Rhizoc[,1:2])
##########################################################################################
## Trans #################################################################################
##########################################################################################
trans.log <- c(trans[1], log(trans[2]), log(trans[4]), log(trans[3]))
ll.trans <- nlikGLGM(par = trans.log, Y = Y, X = X, kappa = log(0.5), nugget = TRUE, mat.dist = mat.dist, cov.model = "spherical",
         family = "binomial", metodo = "NR", ntrial = Rhizoc$N.trials)
##########################################################################################
## LA1 ###################################################################################
##########################################################################################
LA1.log <- c(LA1[1], log(LA1[2]), log(LA1[4]), log(LA1[3]))
ll.la1 <- nlikGLGM(par = LA1.log, Y = Y, X = X, kappa = log(0.5), nugget = TRUE, mat.dist = mat.dist, cov.model = "spherical",
         family = "binomial", metodo = "NR", ntrial = Rhizoc$N.trials)

##########################################################################################
## LA2a ##################################################################################
##########################################################################################
LA2a.log <- c(LA2a[1], log(LA2a[2]), log(LA2a[4]), log(LA2a[3]))
ll.la2a <- nlikGLGM(par = LA2a.log, Y = Y, X = X, kappa = log(0.5), nugget = TRUE, mat.dist = mat.dist, cov.model = "spherical",
         family = "binomial", metodo = "NR", ntrial = Rhizoc$N.trials)

##########################################################################################
## LA2b ##################################################################################
##########################################################################################
LA2b.log <- c(LA2b[1], log(LA2b[2]), log(LA2b[4]), log(LA2b[3]))
ll.la2b <- nlikGLGM(par = LA2b.log, Y = Y, X = X, kappa = log(0.5), nugget = TRUE, mat.dist = mat.dist, cov.model = "spherical",
         family = "binomial", metodo = "NR", ntrial = Rhizoc$N.trials)

##########################################################################################
## SML ###################################################################################
##########################################################################################
SML.log <- c(SML[1], log(SML[2]), log(SML[4]), log(SML[3]))
ll.sml <- nlikGLGM(par = SML.log, Y = Y, X = X, kappa = log(0.5), nugget = TRUE, mat.dist = mat.dist, cov.model = "spherical",
         family = "binomial", metodo = "NR", ntrial = Rhizoc$N.trials)

##########################################################################################
## MCEM###################################################################################
##########################################################################################
MCEM.log <- c(MCEM[1], log(MCEM[2]), log(MCEM[4]), log(MCEM[3]))
ll.mcem <- nlikGLGM(par = MCEM.log, Y = Y, X = X, kappa = log(0.5), nugget = TRUE, mat.dist = mat.dist, cov.model = "spherical",
         family = "binomial", metodo = "NR", ntrial = Rhizoc$N.trials)


## Table to compare the results
tabela <- cbind(trans, LA1, LA2a, LA2b, SML, MCEM, LAPLACE[c(1,2,4,3)])
LL <- c(-ll.trans,-ll.la1,-ll.la2a,-ll.la2b, -ll.sml, -ll.mcem, logLik(fit1[[9]])[1])
tabela <- rbind(tabela,LL)
colnames(tabela) <- c("trans", "LA1", "LA2a", "LA2b", "SML", "MCEM", "LAPLACE")
rownames(tabela) <- c("Intercept", "Partiall sill", "Nugget", "Range", "LogLik")
round(tabela,2)

##########################################################################################
## Graphics profile likelihood ###########################################################
##########################################################################################
par(mfrow = c(1,4), mar=c(3,3.2,1,0.6),mgp=c(1.8,0.8,0))
plot(perf.b0,plot.confstr=TRUE,show.points=TRUE)
plot(perf.sigma,plot.confstr=TRUE,show.points=TRUE)
plot(perf.nugget,plot.confstr=TRUE,show.points=TRUE)
plot(perf.range,plot.confstr=TRUE,show.points=TRUE)

save.image("ResultsRhizoc180614.RData")
