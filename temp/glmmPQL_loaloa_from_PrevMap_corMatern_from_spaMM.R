
library(spaMM) # corMatern 函数
# data("Loaloa")
# head(Loaloa)
# str(Loaloa)
library(MASS)
library(nlme)

library(PrevMap)
data(loaloa, package = "PrevMap")
LoaloaD <- cbind(loaloa, dummy = 1) 

# 幂指数族 
exp.fit <- glmmPQL(fixed = cbind(NO_INF, NO_EXAM - NO_INF) ~ ELEVATION + MEAN9901 + MAX9901 + MIN9901 + STDEV9901, 
              data = LoaloaD, random = ~ 1 | dummy, family = binomial, 
              correlation = corExp(form = ~ LONGITUDE + LATITUDE | dummy))
summary(exp.fit)			  
			  
exp.fit <- glmmPQL(fixed = cbind(NO_INF, NO_EXAM - NO_INF) ~ ELEVATION + MEAN9901 + MAX9901 + MIN9901 + STDEV9901, 
              data = LoaloaD, random = ~ 1 | dummy, family = binomial, 
              correlation = corExp(form = ~ LONGITUDE + LATITUDE | dummy, nugget = TRUE, metric = "euclidean"))
			  
			  
plot(Variogram(fit, resType="normalized"))

#------------------------二项分布---------------------------------------
# REMLE 估计 spaMM
spaMM.fit <- corrHLfit(cbind(NO_INF, NO_EXAM - NO_INF) ~ ELEVATION + MEAN9901 + MAX9901 + MIN9901 + STDEV9901
              + Matern(1 | LONGITUDE + LATITUDE), data = LoaloaD, family = binomial())

summary(spaMM.fit)

# PQL 估计 MASS
glmmPQL.fit <- glmmPQL(fixed = cbind(NO_INF, NO_EXAM - NO_INF) ~ ELEVATION + MEAN9901 + MAX9901 + MIN9901 + STDEV9901, 
              data = LoaloaD, random = ~ 1 | dummy, family = binomial, 
              correlation = corMatern(form = ~ LONGITUDE + LATITUDE | dummy))
summary(glmmPQL.fit)

#-------------------------高斯分布-----------------------------------------
## 空间线性混合效应模型
# REML gls 估计 nlme
gls.fit <- gls(cbind(NO_INF, NO_EXAM - NO_INF) ~ ELEVATION + MEAN9901 + MAX9901 + MIN9901 + STDEV9901,
           data = LoaloaD, method = "REML", 
           correlation = corMatern(form = ~ LONGITUDE + LATITUDE | dummy))

summary(gls.fit)

# REML 估计 nlme
# 与 gls 相差无几 # dummy 虚拟变量  random = ~ 1 | dummy 就是没有其他随机效应
lme.fit <- lme(cbind(NO_INF, NO_EXAM - NO_INF) ~ ELEVATION + MEAN9901 + MAX9901 + MIN9901 + STDEV9901,
               data = LoaloaD, random = ~ 1 | dummy, method = "REML", 
			   correlation = corMatern(form = ~ LONGITUDE + LATITUDE | dummy))

summary(lme.fit)


# MCMC geoR




#------------------------二项分布---------------------------------------

# MCML PrevMap



# MCMC  geoRglm



# geoCount





















library(MASS)
library(nlme)

data(lasrosas.corn, package = "agridat")

fit <- glmmPQL(fixed = yield ~ nitro + topo + bv + rep + nf, 
              # subset = year == "1999",
              data = lasrosas.corn, random = list(year = ~ 1), family = gaussian, 
              correlation = corExp(form = ~ long + lat | year, nugget = TRUE, metric = "euclidean"))

plot(Variogram(fit, resType="normalized"))










