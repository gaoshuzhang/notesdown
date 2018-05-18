
# 数值优化 {#optimation}

## 测试函数

$$f(x,y) = 3*(1-x)*\mathrm{e}^{-x^2 - (y+1)^2} - 10*(\frac{x}{5} - x^3 - y^5)*\mathrm{e}^{-x^2-y^2} - \frac{1}{3}*\mathrm{e}^{-(x+1)^2-y^2}$$
多元函数求导

符号微分，表达式微分
符号求导，表达式求导


```r
peaks_fun <- expression(3*(1-x)*exp^(-x^2 - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp^(-x^2-y^2) -1/3*exp^(-(x+1)^2-y^2))
```


```r
D(peaks_fun, "x")
#> -(3 * (1 - x) * (exp^(-x^2 - (y + 1)^2) * (log(exp) * (2 * x))) + 
#>     3 * exp^(-x^2 - (y + 1)^2) + (10 * (1/5 - 3 * x^2) * exp^(-x^2 - 
#>     y^2) - 10 * (x/5 - x^3 - y^5) * (exp^(-x^2 - y^2) * (log(exp) * 
#>     (2 * x)))) - 1/3 * (exp^(-(x + 1)^2 - y^2) * (log(exp) * 
#>     (2 * (x + 1)))))
D(peaks_fun, "y")
#> -(3 * (1 - x) * (exp^(-x^2 - (y + 1)^2) * (log(exp) * (2 * (y + 
#>     1)))) - (10 * (x/5 - x^3 - y^5) * (exp^(-x^2 - y^2) * (log(exp) * 
#>     (2 * y))) + 10 * (5 * y^4) * exp^(-x^2 - y^2)) - 1/3 * (exp^(-(x + 
#>     1)^2 - y^2) * (log(exp) * (2 * y))))
```

- [An R package for optimization using genetic algorithms](https://github.com/luca-scr/GA)

