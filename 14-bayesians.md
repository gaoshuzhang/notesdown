
# 贝叶斯计算 {#bayes}



从 WinBUGS\index{WinBUGS} 到 OpenBUGS\index{OpenBUGS}，从 JAGS\index{JAGS} 到 Stan\index{Stan}，BUGS 的发展从未停止过，Stan^[<http://mc-stan.org/>] 是一个统计建模和高性能统计计算平台。

## BUGS 软件

最大后验估计，贝叶斯分层模型

## Stan 框架




- [LOO for non-factorized normal models](https://github.com/paul-buerkner/non-factorized-loo)
- [Playing with negative binomial multilevel models in Stan](https://github.com/seananderson/negbin-stan)
- [An Introduction to Greta](https://rviews.rstudio.com/2018/04/23/on-first-meeting-greta/) tensoflow and stan


### PyStan 接口

```python
# 整合 Python 语言到 R Mrakdown 
import pystan
import numpy as np
import matplotlib.pyplot as plt

schools_code = """
data {
  int<lower=0> J; // number of schools
  real y[J]; // estimated treatment effects
  real<lower=0> sigma[J]; // s.e. of effect estimates
}
parameters {
  real mu;
  real<lower=0> tau;
  real eta[J];
}
transformed parameters {
  real theta[J];
  for (j in 1:J)
  theta[j] = mu + tau * eta[j];
}
model {
  eta ~ normal(0, 1);
  y ~ normal(theta, sigma);
}
"""

schools_dat = {'J': 8,
  'y': [28,  8, -3,  7, -1,  1, 18, 12],
  'sigma': [15, 10, 16, 11,  9, 11, 10, 18]}

sm = pystan.StanModel(model_code = schools_code)
fit = sm.sampling(data = schools_dat, iter = 1000, chains = 4)

print(fit)

eta = fit.extract(permuted=True)['eta']
np.mean(eta, axis=0)

## if matplotlib is installed (optional, not required), a visual summary and
## traceplot are available
# fit.plot()
# plt.show()
```

### RStan 接口

Stan 提供的R语言接口 rstan 包 [@R-rstan] 及其扩展 StanHeaders 包 [@R-StanHeaders] 、bayesplot包 [@R-bayesplot] 、brms 包 [@brms2017JSS]、 rstanarm 包 [@R-rstanarm]以及 rstan 的 wiki^[<https://github.com/stan-dev/rstan/wiki>] 及其在空间广义线性混合效应模型的参数估计和预测中的应用。

加载 rstan,如果你的电脑配置有多核处理器，内存也充足，那么可以考虑使用并行方式去估计你的模型参数，


```r
library(rstan)
#> Loading required package: ggplot2
#> Loading required package: StanHeaders
#> rstan (Version 2.17.3, GitRev: 2e1f913d3ca3)
#> For execution on a local, multicore CPU with excess RAM we recommend calling
#> options(mc.cores = parallel::detectCores()).
#> To avoid recompilation of unchanged Stan programs, we recommend calling
#> rstan_options(auto_write = TRUE)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
```


```r
schools_dat <- list(J = 8, 
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))
fit <- stan(file = 'data/8schools.stan', data = schools_dat, 
            iter = 1000, chains = 4)
print(fit)
plot(fit)
pairs(fit, pars = c("mu", "tau", "lp__"))

la <- extract(fit, permuted = TRUE) # return a list of arrays 
mu <- la$mu 

### return an array of three dimensions: iterations, chains, parameters 
a <- extract(fit, permuted = FALSE) 

### use S3 functions as.array (or as.matrix) on stanfit objects
a2 <- as.array(fit)
m <- as.matrix(fit)

print(fit, digits = 1)

schools_dat <- read_rdump('data/8schools.rdump')
source('data/8schools.rdump') 
fit <- stan(file = 'data/8schools.stan', iter = 1000, chains = 4)
```

1. Bayesian Data Analysis <https://github.com/avehtari/BDA_R_demos>
Bayesian Data Analysis, 3rd ed by Gelman, Carlin, Stern, Dunson, Vehtari, and Rubin (BDA3).

2. RStan Book <https://github.com/MatsuuraKentaro/RStanBook> 这是日文版

3. An Introduction to State Space Time Series Analysis <https://github.com/sinhrks/stan-statespace>
Stan models for state space time series

4. Draft introduction to probability and inference aimed at the Stan manual. <https://github.com/betanalpha/stan_intro>


5. Bayesian Modeling using Stan
<https://github.com/fonnesbeck/stan_workshop_2016>
Bayesian Modeling using Stan in R (May/June 2016)

6. Define Stan models using glmer-style (lme4) formulas <https://github.com/rmcelreath/glmer2stan>

7. Examples of working and non-working models, initially for ODCS 2016 in Boston.
<https://github.com/sakrejda/stan-workshop>

8. State space models (dynamic linear models, hidden Markov models) implemented in Stan
<https://github.com/jrnold/ssmodels-in-stan>

9. State Space Models in Stan <https://jrnold.github.io/ssmodels-in-stan/>

10. Conditional autoregressive models in Stan <https://github.com/mbjoseph/CARstan>

11. Implementation of B-Splines in Stan <https://github.com/milkha/Splines_in_Stan>

12. <https://magesblog.com/post/correlated-lognormal-chain-ladder-model/>

13. <http://xcelab.net/rm/statistical-rethinking/>
