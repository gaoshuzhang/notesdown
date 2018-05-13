
library(spaMM)
spamm_fit <- fitme(cbind(npos, ntot - npos) ~ elev1 + elev2 + elev3 + elev4 +
                     maxNDVI1 + seNDVI + Matern(1 | longitude + latitude),
                   data = Loaloa, family = binomial()
)

library(geoRglm) # MCMC

library(glmmTMB) # 与 spaMM 比较



library(spaMM)
data(Loaloa)
lfit <- corrHLfit(cbind(npos, ntot - npos) ~
elev1 + elev2 + elev3 + elev4 + maxNDVI1 + seNDVI
  + Matern(1 | longitude + latitude),
HLmethod = "HL(0,1)", data = Loaloa,
family = binomial()
)

summary(lfit)

library(maps)

pdf(file = "spaMM-loaloa.pdf", width = 6, height = 4, pointsize = 10)
par(mar = c(4, 4, 2, 0), family = "Times")

filled.mapMM(lfit,
  key.title = title(main = "ratio"), key.axes = axis(4, seq(0, .5, by = .1)),
  color.palette = colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral"))),
  map.asp = 1, gridSteps = 61, var.contour.args = list(add = TRUE),
  add.map = TRUE, plot.axes = quote({
    axis(1)
    axis(2)
  }),
  decorations = quote(points(pred[, coordinates], pch = 16, cex = 0.5)),
  plot.title = title(
    main = "Inferred prevalence, North Cameroon",
    xlab = "longitude", ylab = "latitude"
  )
)
dev.off()


##---------------------Gambia ----------------------------------
library(spaMM)
library(geoR)
head(gambia)

# 按坐标分组即按照村庄分组
# 每个村庄有 green phc pos non-pos number/人数 蚊帐比例 杀虫比例 平均年龄
library(dplyr)
gambia_dat <- gambia %>% group_by(x,y) %>% summarise(
  avg_age = mean(age),
  npos = as.integer(sum(pos)),   # 样本里 感染疟疾的人数
  ntotal = length(pos), # 样本里 村子的人数
  netuse = sum(netuse), # 使用蚊帐数
  treated = sum(treated),  # 蚊帐杀虫的数
  green = unique(green), # 村庄周围的绿植
  phc = unique(phc) # 健康中心
)
# tibble to data.frame
gambia_dat <- as.data.frame.data.frame(gambia_dat)
gambia_dat$x <- gambia_dat$x/1000
gambia_dat$y <- gambia_dat$y/1000

gambia.fit <- corrHLfit(cbind(npos, ntotal - npos) ~ avg_age + netuse + treated + green + phc + Matern(1 | x + y),
                  HLmethod = "HL(0,1)", data = gambia_dat,
                  family = binomial())
summary(gambia.fit)

gambia.fit <- corrHLfit(cbind(npos, ntotal - npos) ~ avg_age + netuse + treated + green + phc + Matern(1 | x + y),
                        HLmethod = "HL(0,1)", data = gambia_dat,
                        family = binomial(), ranFix = list(nu = 0.5, rho = 2.255197, lambda = 1.075)
)
summary(gambia.fit)

# formula: cbind(npos, ntotal - npos) ~ avg_age + netuse + treated + green + 
#   phc + Matern(1 | x + y)
# Estimation of corrPars by Laplace REML approximation (p_bv).
# Estimation of fixed effects by h-likelihood approximation.
# Family: binomial ( link = logit ) 
# ------------ Fixed effects (beta) ------------
#   Estimate Cond. SE t-value
# (Intercept) -5.618580 2.240196 -2.5081
# avg_age      0.004620 0.002171  2.1284
# netuse      -0.027865 0.011999 -2.3223
# treated     -0.002172 0.013271 -0.1637
# green        0.021253 0.020866  1.0186
# phc         -0.480058 0.357685 -1.3421
# --------------- Random effects ---------------
#   Family: gaussian ( link = identity ) 
# --- Correlation parameters:
#   1.rho     1.nu 
# 2.255197 0.500000 
# --- Variance parameters ('lambda'):
#   lambda = var(u) for u ~ Gaussian; 
# x + y  :  1.075 [fixed] 
# # of obs: 65; # of groups: x + y, 65 
# ------------- Likelihood values  -------------
#   logLik
# h-likelihood: -197.0101
# p_v(h) (marginal L): -198.0842
# p_beta,v(h) (ReL): -214.7044


pdf(file = "spaMM-gambia.pdf", width = 6, height = 4, pointsize = 10)
par(mar = c(4, 4, 2, 0), family = "Times")

filled.mapMM(gambia.fit,
             key.title = title(main = "ratio"),
             color.palette = colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral"))),
             map.asp = 1, gridSteps = 61, var.contour.args = list(add = TRUE),
             add.map = FALSE, plot.axes = quote({
               axis(1)
               axis(2)
             }),
             decorations = quote(points(pred[, coordinates], pch = 16, cex = 0.5)),
             plot.title = title(
               main = "Inferred prevalence, Gambia",
               xlab = "longitude", ylab = "latitude"
             )
)
dev.off()




















