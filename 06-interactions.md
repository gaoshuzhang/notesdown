
# 动态图形




基于 JS 动态库的 R 包 leaflet [@R-leaflet]，ggvis ， rbokeh [@R-rbokeh] 和 plotly [@R-plotly] ，我比较喜欢 highcharter [@R-highcharter]，美观高效，还活跃开发中。


```r
library("highcharter")
data(diamonds, mpg, package = "ggplot2")
hchart(mpg, "scatter", hcaes(x = displ, y = hwy, group = class))
```



```r
library(rbokeh)
figure(width = 600, height = 400) %>%
  ly_hist(eruptions, data = faithful, breaks = 40, freq = FALSE) %>%
  ly_density(eruptions, data = faithful)
```



```r
library(plotly)
plot_ly(z = ~volcano, type = "surface")
```

## ECharts

基于 ECharts 4 开发的 R 包 [@R-echarts4r] 和 [@R-recharts]


```r
# install.packages("devtools")
devtools::install_github("JohnCoene/echarts4r")
devtools::install_github('cosname/recharts')
```

## D3

R Interface to D3 Visualizations [@R-r2d3]

```r
devtools::install_github("rstudio/r2d3")
```



