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

sm = pystan.StanModel(model_code=schools_code)
fit = sm.sampling(data=schools_dat, iter=1000, chains=4)

print(fit)

eta = fit.extract(permuted=True)['eta']
np.mean(eta, axis=0)

# if matplotlib is installed (optional, not required), a visual summary and
# traceplot are available


# plt.show() # 查看
fit.plot()
# 保存图片
fig = plt.gcf() 
fig.set_size_inches(9,15) # 设置图片宽、高
# 去掉边空
fig.savefig('test.pdf',bbox_inches='tight')

# 保存为 png  dpi 越大图片越清晰 
fig.savefig('test.png',bbox_inches='tight',dpi = 150)

# ----------------------------------------
# 输出
>>> import pystan
>>> import numpy as np
>>> import matplotlib.pyplot as plt
>>> schools_code = """
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
>>> schools_dat = {'J': 8,
               'y': [28,  8, -3,  7, -1,  1, 18, 12],
               'sigma': [15, 10, 16, 11,  9, 11, 10, 18]}
>>> sm = pystan.StanModel(model_code=schools_code)
INFO:pystan:COMPILING THE C++ CODE FOR MODEL anon_model_0fe254f3c524d4153537de9712f3f235 NOW.
>>> fit = sm.sampling(data=schools_dat, iter=1000, chains=4)
>>> print(fit)
Inference for Stan model: anon_model_0fe254f3c524d4153537de9712f3f235.
4 chains, each with iter=1000; warmup=500; thin=1; 
post-warmup draws per chain=500, total post-warmup draws=2000.

           mean se_mean     sd   2.5%    25%    50%    75%  97.5%  n_eff   Rhat
mu         7.94    0.15   4.85  -1.65   4.82   7.95  11.07   17.6   1005    1.0
tau        6.51    0.23   5.44   0.26   2.51   5.25    8.9  20.35    553    1.0
eta[0]     0.41    0.02   0.96  -1.57  -0.21   0.44   1.05   2.19   1619    1.0
eta[1]    -0.03    0.02   0.86   -1.8  -0.57  -0.04   0.53   1.68   1847    1.0
eta[2]     -0.2    0.02   0.89  -1.93  -0.78  -0.24   0.38   1.61   1718    1.0
eta[3]    -0.04    0.02   0.88  -1.71  -0.62  -0.04   0.55    1.8   2000    1.0
eta[4]    -0.34    0.02   0.87  -1.93  -0.92  -0.33   0.22   1.47   1711    1.0
eta[5]    -0.19    0.02   0.91  -2.01   -0.8  -0.22    0.4   1.63   1761    1.0
eta[6]     0.32    0.02   0.87  -1.42  -0.24   0.35   0.87   2.02   1603    1.0
eta[7]     0.07    0.02   0.94  -1.69  -0.58   0.02   0.71   1.97   1774    1.0
theta[0]  11.56    0.22   8.15  -1.44   6.31  10.29  15.79  31.91   1325    1.0
theta[1]   7.84    0.13   5.92  -3.85   4.16   7.78  11.57  20.43   2000    1.0
theta[2]   6.03     0.2   7.65 -11.13   2.01   6.49  10.68  20.63   1427    1.0
theta[3]   7.71    0.14   6.43  -5.81   3.63   7.68  11.72  21.07   2000    1.0
theta[4]   5.16    0.15   6.26  -8.81   1.37   5.76   9.25  15.97   1829    1.0
theta[5]    6.2    0.15   6.57  -8.39   2.43   6.59  10.46  18.85   2000    1.0
theta[6]  10.47    0.15   6.54  -1.17    6.2   9.74  14.18  24.87   2000    1.0
theta[7]   8.66    0.19    7.7  -6.39   4.04   8.58  12.97  25.15   1581    1.0
lp__      -4.77    0.12   2.71  -10.8  -6.29  -4.59  -2.89  -0.08    556    1.0

Samples were drawn using NUTS at Mon Mar  5 12:11:38 2018.
For each parameter, n_eff is a crude measure of effective sample size,
and Rhat is the potential scale reduction factor on split chains (at 
convergence, Rhat=1).
>>> eta = fit.extract(permuted=True)['eta']
>>> np.mean(eta, axis=0)
array([ 0.4106853 , -0.03400279, -0.20396589, -0.03645027, -0.33739926,
       -0.19065388,  0.32350718,  0.06739128])
>>> fit.plot()
<matplotlib.figure.Figure object at 0x000000471CAAE2E8>
>>> plt.show()   
# ----------------------------------------------------------------------------

# code from https://github.com/stan-dev/pystan

