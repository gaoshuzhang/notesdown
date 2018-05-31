
# 模型介绍 {#models}

## 线性模型  

线性模型的一般形式为\begin{equation}
Y = X'\beta + \epsilon, \mathrm{E}(\epsilon) = 0, \mathrm{Cov}(\epsilon) = \sigma^2I  (\#eq:LM)
\end{equation}

其中，$Y = (y_1,y_2,\cdots,y_n)'$ 是 $n$ 维列向量，代表对响应变量 $Y$ 的 $n$ 次观测； 
$\beta = (\beta_0,\beta_1,\cdots,\beta_{p-1})'$ 是 $p$ 维列向量，代表模型自变量 $X$ 的系数，$\beta_0$ 是截距项；
$X' = (1_{(1\times n)}',X_{(1)}',X_{(2)}',\cdots,X_{(n)}')$，$1_{(1\times n)}'$ 是全1的 $n$ 维列向量，而 $X_{(i)}' = (x_{1i},x_{2i},\cdots,x_{ni})'$ 代表对第 $i$ 个自变量的 $n$ 次观测；
$\epsilon = (\epsilon_1,\epsilon_2,\cdots,\epsilon_n)'$ 是 $n$ 维列向量，代表模型的随机误差，$\mathrm{E}(\epsilon_i \epsilon_j) = 0, i \ne j$。 
求解线性模型 \@ref(eq:LM) 的 R 函数是 `lm`，近年来，高维乃至超高维稀疏线性模型成为热门的研究方向，相关的 R 包也越来越多，比较著名的有`glmnet`[@glmnet2011JSS] 和 `SIS`[@SIS2016JSS]。


## 广义线性模型

广义线性模型的一般形式\begin{equation}
g(\mu) = X'\beta,  (\#eq:GLM)
\end{equation}

其中$\mu \equiv \mathrm{E}(Y)$， $g$ 代表联系函数，特别地，当 $Y \sim N(\mu,\sigma^2)$ 时，$g(x) = x$ ；当 $Y \sim \mathrm{Binomial}(n,p)$ 时，$g(x)=\ln(\frac{x}{1-x})$；当 $Y \sim \mathrm{Possion}(\lambda)$ 时，$g(x) = \ln(x)$；此处不一一列举[@McCullagh1989]。模型 \@ref(eq:GLM) 最早由 Nelder 和 Wedderburn [@Nelder1972]提出，它弥补了模型 \@ref(eq:LM) 的两个重要缺点：一是因变量只能取连续值的情况，二是期望与自变量只能用线性关系联系 [@Chen2011]。求解广义线性模型 \@ref(eq:GLM) 的 R 函数是 `glm`，参数估计的常用方法是拟似然法。

## 广义线性混合效应模型  

广义线性混合模型的一般形式\begin{equation}
g(\mu) = X'\boldsymbol{\beta} + Z'\mathbf{b}  (\#eq:GLMM)
\end{equation}

其中， $Z'$ 是 $q$ 维随机效应的 $n \times q$ 的向量值矩阵，其它符号含义如前所述。
混合效应模型包含线性混合效应模型、广义线性混合效应模型、广义可加混合效应模型、非线性混合效应模型等，之所以称之为混合效应，是因为模型既包含固定效应 $\boldsymbol{\beta}$ 又包含随机效应 $\mathbf{b}$。 如前所述的线性和广义线性模型中的自变量就是固定效应，而随机效应是那些不能直接观察到的潜变量，但是对响应变量产生显著影响。求解模型 \@ref(eq:GLMM)的 R 包有 `nlme` [@R-nlme]，`mgcv` [@mgcv2017] 和`lme4`[@lme4JSS] 等，参数估计的方法一般有限制极大似然法。

## 空间广义线性混合效应模型

空间广义线性混合效应模型(Spatial Generalized linear mixed-effects models，简写为SGLMM)，顾名思义， 它既是对模型 \@ref(eq:LM)、\@ref(eq:GLM) 和 \@ref(eq:GLMM) 的延伸也是对空间数据的具体建模，属于空间分析的内容， 在地质统计相关的文献中也称为广义线性地统计模型(Generalized linear geostatistical models)[@Diggle2007]。\begin{equation}
g(\mu_i) = T_{i} = d(x_i)'\beta + S(x_i) + Z_i (\#eq:SGLMM)
\end{equation}

其中， $d'(x_i)$ 代表协变量对应的数据向量，$x_i \in \mathbb{R}^2$ 代表相应的空间位置，$d'(x_i)$ 即 $p$ 个协变量在第 $i$ 个位置的观察值。若响应变量 $Y_i$ 服从二项分布 $\mathrm{Bin}(n_i,p_i)$ 则 $g(\mu_i) = \log[p(x_i)/\{1-p(x_i)\}]$，若响应变量 $Y_i$ 服从泊松分布 $\mathrm{Pois}(\lambda_i)$ 则 $g(\mu_i) = \log(\lambda_i)$。此外，假定 $\mathcal{S} = \{S(x): x \in \mathbb{R}^2\}$ 是均值为0，方差为 $\sigma^2$，相关函数为 $\rho(x,x') = \mathrm{Cov}\{S(x),S(x')\}$ 的高斯过程；随机过程 $\mathcal{S}$ 平稳且各向同性，即 $\rho(x,x') = \mathrm{Corr}\{S(x),S(x')\} \equiv \rho(\|x,x'\|)$，$\|\cdot\|$ 表示距离，样本之间的位置间隔不大就用欧式距离，间隔很大就用球面距离；$S(x_i)$ 代表了与空间位置 $x_i$ 相关的随机效应，简称空间效应；这里，$Z_i$ 是相互独立且服从$N(0,\tau^2)$ 的随机变量。

### 相关函数的选择

如前所述，模型\@ref(eq:SGLMM) 包含的空间效应主要由相关函数决定，在给出相关函数之前，先计算一下空间效应的理论变差$V(x,x')$（即空间过程的协方差函数的一半，变差源于采矿术语）和线性预测的变差$V_{T}(u_{ij})$。为方便起见，记$\rho(u) \triangleq \rho(\|x,x'\|),u \equiv \|x-x'\|$ \begin{equation}
\begin{aligned}
V(x,x')&=\frac{1}{2}\mathrm{Var}\{S(x)-S(x')\}\\
&=\frac{1}{2}\mathrm{Cov}(S(x)-S(x'),S(x)-S(x'))\\
&=\frac{1}{2}\{E[S(x)-S(x')][S(x)-S(x')]-[E(S(x)-S(x'))]^2\}\\
&=\sigma^2-\mathrm{Cov}(S(x),S(x'))=\sigma^2\{1-\rho(u)\}\\
V_{T}(u_{ij})&=\frac{1}{2}\mathrm{Var}\{T_{i}(x)-T_{j}(x)\}
=\frac{1}{2}\mathrm{E}[(T_{i}-T_{j})^2]=\tau^2+\sigma^2(1-\rho(u_{ij})) (\#eq:variograms)
\end{aligned}
\end{equation}

从方程 \@ref(eq:variograms) 不难看出系数$\frac{1}{2}$的化简作用，随机向量 $T$ 的协方差矩阵如下：$$\mathrm{Cov}(T_{i}(x),T_{i}(x)) = \sigma^2+\tau^2, \mathrm{Cov}(T_{i}(x),T_{j}(x))=\sigma^2\rho(u_{ij})$$

相关函数 $\rho(u)$ 的作用和地位就显而易见了，它是既决定理论变差又决定协方差矩阵的结构。常见的相关函数族有梅隆族：\begin{equation}
\rho(u)=\{2^{\kappa -1}\Gamma(\kappa)\}^{-1}(u/\phi)^{\kappa}\mathcal{K}_{\kappa}(u/\phi),u > 0 (\#eq:matern1)
\end{equation}

一般地，通常假定 $\rho(u)$ 单调不增，即任何两样本之间的相关性应该随距离变大而减弱，尺度参数$\phi$控制函数$\rho(u)$递减到0的速率，方便起见记 $\rho(u) = \rho_{0}(u/\phi)$，则方程\@ref(eq:matern1)可记为\begin{equation}
\rho_{0}(u)=\{2^{\kappa -1}\Gamma(\kappa)\}^{-1}(u)^{\kappa}\mathcal{K}_{\kappa}(u),u > 0 (\#eq:matern2)
\end{equation}

其中，$\mathcal{K}_{\kappa}(\cdot)$ 是阶数为$\kappa$的第二类修正的贝塞尔函数，$\kappa(>0)$是平滑参数，满足这些条件的空间过程$\mathcal{S}$是$\lceil\kappa\rceil-1$次均方可微的。

值得注意的是梅隆参数族包含指数族（这里指带有参数的指数函数），即当$\kappa=0.5$时，$\rho_{0}(u)=\exp(-u)$，$S(x)$均方连续但是不可微，当$\kappa \to \infty$ 时，$\rho_{0}(u)=\exp(-u^2)$，$S(x)$无限次均方可微。要从数据中估计$\kappa$，为了节省计算，又不失一般性，经验做法是取离散的$\kappa$先验，如$\kappa=0.5,1.5,2.5$，分别对应$S(x)$均方连续、一次可微和二次可微。$S(x)$的性质实际代表了空间过程$\mathcal{S}$的曲面平滑程度。

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{figures/matern} 

}

\caption{固定尺度参数，相关函数随距离的变化（图左）；固定贝塞尔函数的阶，相关函数随距离的变化（图右）}(\#fig:matern-2d)
\end{figure}

从图\@ref(fig:matern-2d) 和图 \@ref(fig:matern-3d) 可以看出，相比于贝塞尔函数的阶 $\kappa$， 尺度参数 $\phi$ 对相关函数的影响大些，所以在实际应用中，先固定下$\kappa$是可以接受的。此外，Diggle 等人于1998年使用幂指数族$\rho_{0}(u)=\exp(-u^{\delta}), 0 < \delta \leq 2$作为相关函数[@Diggle1998]，因其形式大大简化，函数图像和性质却与梅隆族相似，即当$0<\delta<2$时，$S(x)$均方连续但不可微，当$\delta=2$时，$S(x)$无限次可微。

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{figures/matern-3d} 

}

\caption{相关函数随贝塞尔函数的阶和尺度参数的变化，横轴表示尺度参数，纵轴表示贝塞尔函数的阶（从蓝到红，相关性由弱变强）}(\#fig:matern-3d)
\end{figure}

### 模型识别

模型中$Z_{i}$与$S(x_i)$项的可识别问题：向量$T=(T_1,T_2,\cdots,T_n)$ 是协方差为矩阵 $\tau^2I+\sigma^2R$的多元高斯分布，其中 $R_{ij}=\rho(u_{ij};\phi)$，$u_ij$ 是$x_i$与$x_j$之间的距离，由\@ref(eq:variograms)知，随机过程 $T(x)$的相关函数在原点不连续。只要指定参数，使得$\rho(u)$在原点连续，则参数$\tau^2,\sigma^2,\phi$就都是可识别的，显然这依赖于抽样的位置$x_i$[@Diggle2002]。

### 先验分布

基于贝叶斯框架实现模型\@ref(eq:SGLMM)的参数估计和预测，必然使用 MCMC 算法，自然地，需要指定模型参数 $\bm{\theta} = (\beta,\tau^2,\sigma^2,\phi)$的先验分布，对于 $\beta$，选择相互独立的均匀先验，而对于参数 $\tau^2,\sigma^2,\phi$，选取如下模糊先验：
$$f(\tau^2) \propto \frac{1}{\tau^2};f(\sigma^2) \propto \frac{1}{\sigma^2};f(\phi) \propto \frac{1}{\phi^2}$$
其中，$\tau^2$ 和 $\sigma^2$ 为杰弗里斯先验，这些先验的选择是出于实用和经验的考虑（意思就是说可以取别的），如果由这些先验导出的后验不合适，则 MCMC 算法的表现就会不收敛； 通常选取不同初始值，产生多条链，如果没有出现算法不收敛的情况，则这样的先验是被合适的。这些无信息的先验分布的选择对最终结果几乎没有影响，这是贝叶斯非常棒的部分，贝叶斯推断方法也得以被广泛应用[@mao2006]。

作为模型 \@ref(eq:SGLMM) 求解和展示的首选工具 --- R 语言在空间数据分析与可视化方面呈现越来越流行的趋势，从早些年的 `lattice` 图形[@lattice2008] 到如今的 `ggplot2`图形[@ggplot22016]，操作空间数据的 `sp` 对象[@R-sp]也发展为 `sf` 对象[@R-sf]，同时整合了不少第三方软件和服务，如基于 Google Maps 的交互空间可视化 [@plotGoogleMaps2012]，基于 Google Earth 的空间可视化 [@plotKML2015]。下面就求解模型 \@ref(eq:SGLMM)的三类算法进行详细阐述，分别是贝叶斯方法、似然方法和低秩近似方法，并介绍相应的软件实现。
