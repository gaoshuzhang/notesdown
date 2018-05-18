
# 性能提升 {#performance}

- [C++ 编程风格指南](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines) 
- <https://github.com/isocpp/CppCoreGuidelines>

- 如何充分利用 Rcpp 包
- 设个目标，锻炼一下编码能力，关于统计计算和可视化尽可能提供两个方案，至少包含基础 R 包的实现


```r
Pkgs <- sapply(list.files(R.home("library")), function(x)
  packageDescription(pkg = x, fields = "Priority"))
names(Pkgs[Pkgs == "base" & !is.na(Pkgs)])
#>  [1] "base"      "compiler"  "datasets"  "graphics"  "grDevices"
#>  [6] "grid"      "methods"   "parallel"  "splines"   "stats"    
#> [11] "stats4"    "tcltk"     "tools"     "utils"
```

计算程序运行时间


```r
.proctime00 <- proc.time()
s <- 0
for (i in seq(1000)) {
  s <- s + i
}
proc.time() - .proctime00
#>    user  system elapsed 
#>   0.008   0.000   0.007
```

## Rcpp



### RcppOctave

混合编程


### RcppGSL


### RcppArmadillo

### RcppParallel

### RcppNumerical


### RcppAlgos



```r
devtools::session_info(pkgs = c("Rcpp","RcppOctave"))
#> Session info -------------------------------------------------------------
#>  setting  value                       
#>  version  R version 3.4.4 (2017-01-27)
#>  system   x86_64, linux-gnu           
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  tz       UTC                         
#>  date     2018-05-15
#> Packages -----------------------------------------------------------------
#>  package    * version date       source                             
#>  codetools    0.2-15  2016-10-05 CRAN (R 3.4.4)                     
#>  digest       0.6.15  2018-01-28 CRAN (R 3.4.3)                     
#>  glue         1.2.0   2017-10-29 CRAN (R 3.4.2)                     
#>  graphics   * 3.4.4   2018-03-15 local                              
#>  grDevices  * 3.4.4   2018-03-15 local                              
#>  magrittr     1.5     2014-11-22 CRAN (R 3.1.2)                     
#>  methods    * 3.4.4   2018-03-15 local                              
#>  pkgmaker     0.22    2014-05-14 cran (@0.22)                       
#>  Rcpp         0.12.16 2018-03-13 CRAN (R 3.4.4)                     
#>  RcppOctave   0.19    2018-05-15 Github (renozao/RcppOctave@fcf4d02)
#>  registry     0.5     2017-12-03 cran (@0.5)                        
#>  stats      * 3.4.4   2018-03-15 local                              
#>  stringi      1.2.2   2018-05-02 CRAN (R 3.4.4)                     
#>  stringr      1.3.1   2018-05-10 CRAN (R 3.4.4)                     
#>  tools        3.4.4   2018-03-15 local                              
#>  utils      * 3.4.4   2018-03-15 local                              
#>  xtable       1.8-2   2016-02-05 CRAN (R 3.2.4)
```

