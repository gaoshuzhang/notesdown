
# 数值模拟 {#simulations}

模拟的空间广义线性混合效应模型分别是\@ref(eq:SGPSM1)和 \@ref(eq:SGPSM2)。RandomFields 可以模拟多元随机场 [@RandomFields2015]， geoR 包[@R-geoR] 的 `grf` 函数只适合模拟少量样本点（$n < 500$）， MASS 包的 `glmmPQL` 函数采用惩罚拟似然求解模型[@MASS2002]。模型参数设置为 $n=1600,\sigma^2=1,\phi=25,\tau^2=1,\kappa=1,\beta_0=1.2$，图 \@ref(fig:reg-gp) 模拟规则网格上的采样，图\@ref(fig:irreg-gp) 模拟随机采样，图 \@ref(fig:mesh-spde) 基于INLA方法模拟三角网格。每个格点上重复实验10次，得到响应变量二项分布的概率值。REML 方法图\@ref(fig:spamm-sim)，INLA 方法图 \@ref(fig:inla-simulation) ，低秩近似和 MCML 方法图 \@ref(fig:low-rank)\begin{gather}
\log\big\{\frac{p(x_i)}{1-p(x_i)}\big\} = d(x_i)'\beta + S(x_i) + Z_i (\#eq:SGPSM1)\\
\log[\lambda(x_i)] = d(x_i)'\beta + S(x_i) + Z_i (\#eq:SGPSM2)
\end{gather}

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{figures/reg-gp} 

}

\caption{模拟高斯过程：核函数分别为指数族（左图），梅隆族（右图）}(\#fig:reg-gp)
\end{figure}
\begin{figure}

{\centering \includegraphics[width=0.9\linewidth]{figures/irreg-gp} 

}

\caption{模拟高斯过程：核函数分别为指数族（左图），梅隆族（右图）}(\#fig:irreg-gp)
\end{figure}
\begin{figure}

{\centering \includegraphics[width=0.9\linewidth]{figures/simulation} 

}

\caption{低秩近似方法与精确蒙特卡罗最大似然方法}(\#fig:low-rank)
\end{figure}
\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{figures/mesh-spde} 

}

\caption{基于INLA的三角网格划分}(\#fig:mesh-spde)
\end{figure}
\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{figures/INLA-simulation} 

}

\caption{INLA方法}(\#fig:inla-simulation)
\end{figure}

\newpage

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{figures/spaMM-simulation} 

}

\caption{规则网格上预测结果（REML方法）}(\#fig:spamm-sim)
\end{figure}

Table: (\#tab:simulation-norm) 数值模拟结果

| 估计 | $\hat{\beta_{0}}$ | $\hat{\beta_{1}}$ | $\hat{\beta_{2}}$ | $\hat{\phi}$ | $\hat{\sigma^2}$ | $\hat{\tau^2}$ | CPU (s) |
| :----------------: | :----------------: | :----------------: | :----------------: | :-----------: | :---------------: | :-------------: | :----------------: |
| 真实值 | 1.200               | 1.000                 | 0.800              | 25.000           | 1.000                | 1.000              |  -   |
| RSA | 1.977             | 1.016             | 0.803             | 21.937       | 0.857            | 0.960          | 298.250 |

模拟结果如表 \@ref(tab:simulation-norm) 所示，运行环境 R 版本 3.5.0，平台 Debian GNU/Linux 9 (stretch) 64 位操作系统，CPU i7-4710MQ ， 内存 3Gb。R 包分别是 RSAgeo (1.2)、 geoR (1.7.5.2)、 PrevMap (1.4.1) ^[括号内是扩展包的版本]
