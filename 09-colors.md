
# 配色 {#color}



君子爱色，取之有道：有些人功力深厚，黑白灰几乎打遍天下无敌手，如科波拉执导的《教父》、沃卓斯基执导的《黑客帝国》等等，但我还是要说，好色乃人之本性也，花花世界，岂能都是法印眼中的白骨！再说《红楼梦》里，芍药丛中，桃花树下，滴翠亭边，栊翠庵里，处处都是湘云、黛玉、宝钗、妙玉留下的诗歌。

黑西装、黑领带和白衬衫，让人一下子想到了电影《黑客帝国》，构建了整幅画轴，黑领带换黑领结和红玫瑰，转而又想到电影《教父》的主角维托·唐·科莱昂，黑白灰就占了电影的主色调。这么素的颜色怎么就能这么丰富呢？这就是配色的技艺了！

## 调色板

首先选择一组合适的颜色，比如从桃色到梨色，选择6种颜色，以此为基础，可以借助`grDevices::colorRampPalette`函数扩充至想要的数目


```r
# Colors from https://github.com/johannesbjork/LaCroixColoR
color_vec <- c("#FF3200", "#E9A17C", "#E9E4A6", "#1BB6AF", "#0076BB", "#172869")
n <- 20
more_colors <- (grDevices::colorRampPalette(color_vec))(n)
```

这里用 `graphics::rect` 函数展示这组颜色


```r
# 代码来自 ?colorspace::rainbow_hcl
pal <- function(colorname, border = "light gray", ...) {
  n <- length(colorname)
  plot(0, 0,
    type = "n", xlim = c(0, 1), ylim = c(0, 1),
    axes = FALSE, ...
  )
  rect(0:(n - 1) / n, 0, 1:n / n, 1, col = colorname, border = border)
}
par(mar = rep(0, 4))
pal(more_colors, xlab = "Colors from Peach to Pear", ylab = "")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/unnamed-chunk-3-1.svg" alt="桃色至梨色的渐变" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-3)桃色至梨色的渐变</p>
</div>

早些时候我在统计之都论坛上发帖 -- R语言绘图用调色板大全 <https://d.cosx.org/d/419378-r>

阐述色理 HCL RGB CMYK 
Adobe RGB  sRGB   P3广色域  
2K 4K 5K  视网膜屏  普清  高清 超高清 全高清 显示器 
打印机  照相机 

为什么需要这么多颜色模式

知道颜色模式及其之间的转化
颜色空间及其区别 HCL and HSV color spaces
基于网页、人眼、打印机使用不同的颜色模式为何



哪里可以获取颜色

grDevices [@R-base] colorspace [@R-colorspace] RColorBrewer [@R-RColorBrewer]
基本够用

取之有道 拿人家的颜色 一定要记得引用啊，我这里要是还有哪里没有引用到的一定要提出来

18个R包 所谓降龙十八掌 要想降住色魔，非得十八掌不可


## 颜色空间

确定一种颜色，我们需要知道 色相 饱和度 明度 颜色的三个属性， 

### RGB

红(red)、绿(green)、蓝(blue)是三原色

```r
rgb(red, green, blue, alpha, names = NULL, maxColorValue = 1)
```

函数参数说明：

- __red, blue, green, alpha__ 取值范围[0,M]，M 是 *maxColorValue*
- __names__ 字符向量，给这组颜色值取名
- __maxColorValue__ 红，绿，蓝三色范围的最大值 

The colour specification refers to the standard sRGB colorspace (IEC
standard 61966).

rgb 产生一种颜色，如 `rgb(255, 0, 0, maxColorValue = 255)` 的颜色是 `"#FF0000"` ，这是一串16进制数，每两个一组，那么一组有 $16^2 = 256$ 种组合，整个一串有 $256^3 = 16777216$ 种组合，这就是RGB表达的所有颜色。用色轮示意，如图 \@ref(fig:RGBwheel)


```r
par(mar = rep(0,4))
pie(rep(1, times = 255), labels = "", col = rainbow(255), border = FALSE)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/RGBwheel-1.svg" alt="RGB 色轮" width="70%" />
<p class="caption">(\#fig:RGBwheel)RGB 色轮</p>
</div>

colorRampPalette 自制调色板


```r
op <- par(mfrow = c(3, 1), mar = c(0.1, 0.1, 0.5, 0.1), xaxs = "i", yaxs = "i")
n <- 1000
mycolors <- colorRampPalette(c("blue", "orangeRed"))(n)
barplot(rep(1, times = n), col = mycolors, border = mycolors, axes = FALSE)
mycolors <- colorRampPalette(c("darkgreen", "yellow", "orangered"))(n)
barplot(rep(1, times = n), col = mycolors, border = mycolors, axes = FALSE)
mycolors <- colorRampPalette(c("blue", "white", "orangered"), bias = 1.2)(n)
barplot(rep(1, times = n), col = mycolors, border = mycolors, axes = FALSE)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/custom-1.svg" alt="colorRampPalette自制调色板" width="70%" />
<p class="caption">(\#fig:custom)colorRampPalette自制调色板</p>
</div>

### HSL

色相饱和度亮度 hue–saturation–luminance (HSL)

### HSV 

Create a vector of colors from vectors specifying hue, saturation and value.	色相饱和度值

```r	
hsv(h = 1, s = 1, v = 1, alpha)
```

This function creates a vector of colors corresponding to the given values in HSV space.
rgb and rgb2hsv for RGB to HSV conversion;


hsv函数通过设置色调、饱和度和亮度获得颜色，三个值都是0-1的相对量


```r
par(mfcol = c(11, 121), mar = c(0, 0, 0, 0), xaxs = "i", yaxs = "i")
x <- seq(0, 10) / 10
ndx <- expand.grid(x, x, x)
mycolor <- hsv(ndx[, 3], ndx[, 2], ndx[, 1])
for (i in 1:nrow(ndx)) {
  barplot(1, col = mycolor[i], border = mycolor[i], axes = FALSE)
}
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/hsv-1.svg" alt="色相、饱和度和亮度" width="70%" />
<p class="caption">(\#fig:hsv)色相、饱和度和亮度</p>
</div>

RGB HSV HSL 都是不连续的颜色空间，缺点

### HCL 

基于感知的颜色空间替代RGB颜色空间

通过指定色相(hue)，色度(chroma)和亮度(luminance/lightness)，创建一组（种）颜色

```r			
hcl(h = 0, c = 35, l = 85, alpha, fixup = TRUE)
```

函数参数说明：

- __h__ 颜色的色调，取值范围为[0,360]，0、120、240分别对应红色、绿色、蓝色

- __c__ 颜色的色度，其上界取决于色调和亮度

- __l__ 颜色的亮度，取值范围[0,100]，给定色调和色度，只有一部分子集可用

- __alpha__ 透明度，取值范围[0,1]，0 和1分别表示透明和不透明

This function corresponds to polar coordinates in the CIE-LUV color space


### CMYK

印刷三原色：青 (cyan)、品红 (magenta)、黄 (yellow)

- 颜色模式转化

`col2rgb` 、`rgb2hsv` 和 `rgb` 函数 [@R-base] 
`hex2RGB` 函数 [@R-colorspace] 
*col2hcl*函数 [@R-scales] 
*col2HSV*  [@R-colortools]
*col2hex* [@R-palr]

这里应该有个思维导图


```r
col2rgb("lightblue")  # color to  RGB
#>       [,1]
#> red    173
#> green  216
#> blue   230
scales::col2hcl("lightblue") # color to HCL
#> [1] "#ADD8E6FF"
palr::col2hex("lightblue") # color to HEX
#> [1] "#ADD8E6FF"
colortools::col2HSV("lightblue") # color to HSV
#> [1] "#ADD8E6"
```


```r
rgb(173,216,230,maxColorValue = 255) # RGB to HEX
#> [1] "#ADD8E6"
colorspace::hex2RGB("#ADD8E6")  # HEX to RGB
#>          R     G     B
#> [1,] 0.678 0.847 0.902
rgb(.678,.847,.902,maxColorValue = 1) # RGB to HEX
#> [1] "#ADD8E6"
rgb2hsv(173,216,230,maxColorValue = 255) # RGB to HSV
#>    [,1]
#> h 0.541
#> s 0.248
#> v 0.902
```

选色为什么这么难


```r
op <- par(mar = c(1, 2, 1, 0), mfrow = c(3, 2))
set.seed(1234)
barplot(sample(seq(8), 8, replace = FALSE), col = palette(), border = "white")
set.seed(1234)
barplot(sample(seq(8), 8, replace = FALSE), col = heat.colors(8), border = "white")
set.seed(1234)
barplot(sample(seq(8), 8, replace = FALSE), col = gray.colors(8), border = "white")
set.seed(1234)
barplot(sample(seq(8), 8, replace = FALSE), col = "lightblue", border = "white")
barplot(sample(seq(8), 8, replace = FALSE), col = colorspace::sequential_hcl(8), border = "white")
barplot(sample(seq(8), 8, replace = FALSE),
  col = colorspace::diverge_hcl(8, h = c(130, 43), c = 100, l = c(70, 90)), border = "white"
)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/select-color-1.svg" alt="源起" width="70%" />
<p class="caption">(\#fig:select-color)源起</p>
</div>

```r
par(op)
```





色相与阴影相比是无关紧要的，色相对于标记和分类很有用，但表示（精细的）空间数据或形状的效果较差。颜色是改善图形的好工具，但糟糕的配色方案 (color schemes) 可能会导致比灰度调色板更差的效果。[@meteorological2009]


黑、白、灰，看似有三种颜色，其实只有一种颜色，黑和白只是灰色的两极，那么如何设置灰色梯度，使得人眼比较好区分它们呢？这样获得的调色板适用于什么样的绘图环境呢？

R预置的灰色有224种，挑出其中的调色板


```r
grep( "^gr(a|e)y" , grep("gr(a|e)y" , colors() ,value = TRUE),value = TRUE,invert = TRUE)
#>  [1] "darkgray"       "darkgrey"       "darkslategray"  "darkslategray1"
#>  [5] "darkslategray2" "darkslategray3" "darkslategray4" "darkslategrey" 
#>  [9] "dimgray"        "dimgrey"        "lightgray"      "lightgrey"     
#> [13] "lightslategray" "lightslategrey" "slategray"      "slategray1"    
#> [17] "slategray2"     "slategray3"     "slategray4"     "slategrey"
```


```r
gray_colors <- paste0(rep(c("slategray", "darkslategray"), each = 4), seq(4))
op <- par(mar = c(0, 0, 3, 0))
pal(gray_colors, main = toString(gray_colors), cex.main = .9)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/gray1-1.svg" alt="灰度调色板" width="100%" />
<p class="caption">(\#fig:gray1)灰度调色板</p>
</div>

```r
par(op)
```

gray 与 grey 是一样的，类似 color 和 colour 的关系，可能是美式和英式的差别，且看


```r
all.equal( col2rgb( paste0("gray",seq(100) ) ), col2rgb( paste0( "grey", seq(100) ) ) )
#> [1] TRUE
```

`gray100` 代表白色，`gray0` 代表黑色，提取灰色调色板，去掉首尾部分是必要的


```r
op <- par(mfrow = c(2,1), mar=c(0,0,2,0))
n <- 10 # 提取 n 种灰色
pal(paste0("gray", round( seq( from = 29, to = 89, length.out = n ) ) ), main = "custom color palette")
pal(gray.colors(10, start = .3, end = .9), main = "gray.colors function")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/gray2-1.svg" alt="提取10种灰色做调色板" width="70%" />
<p class="caption">(\#fig:gray2)提取10种灰色做调色板</p>
</div>

```r
par(op)
```

比较 viridis 和 Spectral 两块调色板，如图 \@ref(fig:pickcolor) 所示，可见 Spectral 的可识别性高些


```r
dat <- as.data.frame(cbind(rep(1948 + seq(12), each = 12), rep(seq(12), 12), AirPassengers))
colnames(dat) <- c("year", "month", "passengers")
library(ggplot2)
library(colormap)
library(gridExtra)
viridis <- ggplot(data = dat, aes(as.factor(year), as.factor(month))) +
  geom_point(pch = 15, size = 8, aes(color = passengers)) +
  scale_color_colormap(colormap = colormaps$viridis) +
  labs(x = "Year", y = "Month", colour = "Passengers") +
  theme_minimal()
Spectral <- ggplot(data = dat, aes(as.factor(year), as.factor(month))) +
  geom_point(aes(colour = passengers), pch = 15, size = 8) +
  scale_colour_distiller(palette = "Spectral") +
  labs(x = "Year", y = "Month", colour = "Passengers") +
  theme_minimal()
grid.arrange(viridis, Spectral, ncol = 2)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/pickcolor-1.svg" alt="viridis 和 Spectral对比" width="100%" />
<p class="caption">(\#fig:pickcolor)viridis 和 Spectral对比</p>
</div>

再举栗子，图\@ref(fig:faithfuld)是正负例对比，其中好在哪里呢？这张图要表达美国黄石国家公园的老忠实泉间歇喷发的时间规律，那么好的标准就是层次分明，以突出不同颜色之间的时间差异。这个差异，还要看起来不那么费眼睛，越一目了然越好。


```r
erupt <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() +
  scale_x_continuous(NULL, expand = c(0, 0)) +
  scale_y_continuous(NULL, expand = c(0, 0)) +
  theme(legend.position = "none")
erupt1 <- erupt + scale_fill_gradientn(colours = gray.colors(7))
erupt2 <- erupt + scale_fill_distiller(palette = "Spectral")
erupt3 <- erupt + scale_fill_gradientn(colours = terrain.colors(7))
erupt4 <- erupt + scale_fill_colormap(colormap = colormaps$RdBu)
grid.arrange(erupt1, erupt2, erupt3, erupt4, ncol = 2)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/faithfuld-1.svg" alt="美国黄石国家公园的老忠实泉" width="70%" />
<p class="caption">(\#fig:faithfuld)美国黄石国家公园的老忠实泉</p>
</div>

RColorBrewer 包 提供了有序 (Sequential) 、定性 (Qualitative) 和发散 (Diverging)  三类调色板，一般来讲，分别适用于连续或有序分类变量、无序分类变量、两类分层对比变量的绘图。再加上强大的 ggplot2 包内置的对颜色处理的函数，如 `scale_alpha_*` 、 `scale_colour_*` 和 `scale_fill_*` 等，详见：


```r
ls("package:ggplot2",pattern = "scale_col(ou|o)r_")
#>  [1] "scale_color_brewer"      "scale_color_continuous" 
#>  [3] "scale_color_discrete"    "scale_color_distiller"  
#>  [5] "scale_color_gradient"    "scale_color_gradient2"  
#>  [7] "scale_color_gradientn"   "scale_color_grey"       
#>  [9] "scale_color_hue"         "scale_color_identity"   
#> [11] "scale_color_manual"      "scale_color_viridis_c"  
#> [13] "scale_color_viridis_d"   "scale_colour_brewer"    
#> [15] "scale_colour_continuous" "scale_colour_date"      
#> [17] "scale_colour_datetime"   "scale_colour_discrete"  
#> [19] "scale_colour_distiller"  "scale_colour_gradient"  
#> [21] "scale_colour_gradient2"  "scale_colour_gradientn" 
#> [23] "scale_colour_grey"       "scale_colour_hue"       
#> [25] "scale_colour_identity"   "scale_colour_manual"    
#> [27] "scale_colour_ordinal"    "scale_colour_viridis_c" 
#> [29] "scale_colour_viridis_d"
ls("package:ggplot2",pattern = "scale_fill_")
#>  [1] "scale_fill_brewer"     "scale_fill_continuous"
#>  [3] "scale_fill_date"       "scale_fill_datetime"  
#>  [5] "scale_fill_discrete"   "scale_fill_distiller" 
#>  [7] "scale_fill_gradient"   "scale_fill_gradient2" 
#>  [9] "scale_fill_gradientn"  "scale_fill_grey"      
#> [11] "scale_fill_hue"        "scale_fill_identity"  
#> [13] "scale_fill_manual"     "scale_fill_ordinal"   
#> [15] "scale_fill_viridis_c"  "scale_fill_viridis_d"
```


除之前提到的 grDevices 包[@R-base] 、colorspace 包 [@R-colorspace]和 RColorBrewer 包 [@R-RColorBrewer] 之外，此处还收录 yarrr 包[@R-yarrr] 、dichromat 包[@R-dichromat] 、colormap 包[@R-colormap]、viridis 包[@R-viridis]、pals 包[@R-pals] 、ColorPalette 包[@R-ColorPalette]、colorRamps包 [@R-colorRamps]、colortools包[@R-colortools] ，此外还有 palr 包[@R-palr] 就不一一收录了


```r
# 代码来自 ?palettes
demo.pal <-
  function(n, border = if (n < 32) "light gray" else NA,
           main = paste("color palettes: alpha = 1,  n=", n),
           ch.col = c("rainbow(n, start=.7, end=.1)", "heat.colors(n)",
                      "terrain.colors(n)", "topo.colors(n)",
                      "cm.colors(n)","gray.colors(n, start = 0.3, end = 0.9)"))
{
    nt <- length(ch.col)
    i <- 1:n; j <- n / nt; d <- j/6; dy <- 2*d
    plot(i, i+d, type = "n", axes = FALSE, ylab = "",xlab = "", main = main)
    for (k in 1:nt) {
        rect(i-.5, (k-1)*j+ dy, i+.4, k*j,
             col = eval(parse(text = ch.col[k])), border = border)
        text(2*j,  k * j + dy/4, ch.col[k])
    }
}
n <- if(.Device == "postscript") 64 else 16
# Since for screen, larger n may give color allocation problem
op <- par(mar=c(0,0,2,0))
demo.pal(n)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/palettes-1.svg" alt="grDevices调色板1" width="70%" />
<p class="caption">(\#fig:palettes)grDevices调色板1</p>
</div>

```r
par(op)
```


```r
op <- par(mfrow =c(33,1),mar=c(0,0,.8,0))
 for( i in seq(32)) {
	  pal( colors()[ (1+20*(i-1)) : (20*i) ] ,main = paste(1+20*(i-1),"to", 20*i))
}
pal( colors()[ 641 : 657 ], main = "641 to 657") 
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/democolors-1.svg" alt="grDevices调色板2" width="100%" />
<p class="caption">(\#fig:democolors)grDevices调色板2</p>
</div>

```r
par(op)
```



```r
library(ColorPalette)
op <- par(mfrow=c(4,1),mar=c(0,0,2,0))
pal(generateMonochromaticColors("lightblue", 16),main = "generateMonochromaticColors")
pal(complementColors("lightblue", 16),main = "complementColors")
pal(tetradicColors("lightblue",16),main = "tetradicColors")
pal(triadicColors("lightblue",16), main = "triadicColors")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/ColorPalette-1.svg" alt="ColorPalette调色板" width="70%" />
<p class="caption">(\#fig:ColorPalette)ColorPalette调色板</p>
</div>

```r
par(op)
```


```r
library(colorRamps)
op <- par(mfrow=c(6,1),mar=c(0,0,2,0))
n <- 16
pal(matlab.like(n),main = "matlab.like")
pal(matlab.like2(n),main = "matlab.like2")
pal(blue2green2red(n),main = "blue2green2red")
pal(primary.colors(n), main = "primary.colors")
pal(ygobb(n), main = "ygobb")
pal(rgb.tables(n), main = "rgb.tables")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/colorRamps-1.svg" alt="colorRamps调色板" width="70%" />
<p class="caption">(\#fig:colorRamps)colorRamps调色板</p>
</div>

```r
par(op)
```


```r
library(viridisLite)
n <- 16
op <- par(mfrow=c(4,1),mar=c(0,0,2,0))
pal(magma(n, alpha = 1, begin = 0, end = 1))
pal(inferno(n, alpha = 1, begin = 0, end = 1))
pal(plasma(n, alpha = 1, begin = 0, end = 1))
pal(viridis(n, alpha = 1, begin = 0, end = 1))
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/viridis-1.svg" alt="viridis调色板" width="70%" />
<p class="caption">(\#fig:viridis)viridis调色板</p>
</div>

```r
par(op)
```



```r
op <- par(mfrow=c(2,1),mar=c(0,3,2,0))
library(pals)
pals::pal.bands(coolwarm, parula, ocean.haline, cubicl, kovesi.rainbow,
          ocean.phase, brewer.paired(12), stepped,
          main="Colormap suggestions")

# Qualtitative
pals::pal.bands(brewer.accent(8), brewer.dark2(8), brewer.paired(12), brewer.pastel1(9),
          brewer.pastel2(8), brewer.set1(9), brewer.set2(8), brewer.set3(10),
          labels=c("brewer.accent", "brewer.dark2", "brewer.paired", "brewer.pastel1",
                   "brewer.pastel2", "brewer.set1", "brewer.set2", "brewer.set3"),
          main="Brewer qualitative")
par(op)
```


```r
op <- par(mfrow=c(2,1),mar=c(0,3,2,0))
# Sequential
pals::pal.bands(brewer.blues, brewer.bugn, brewer.bupu, brewer.gnbu, brewer.greens,
          brewer.greys, brewer.oranges, brewer.orrd, brewer.pubu, brewer.pubugn,
          brewer.purd, brewer.purples, brewer.rdpu, brewer.reds, brewer.ylgn,
          brewer.ylgnbu, brewer.ylorbr, brewer.ylorrd,
          main="Brewer sequential")

# Diverging
pals::pal.bands(brewer.brbg, brewer.piyg, brewer.prgn, brewer.puor, brewer.rdbu,
          brewer.rdgy, brewer.rdylbu, brewer.rdylgn, brewer.spectral,
          main="Brewer diverging")
par(op)
```


```r
colortools::pals()
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/colortools1-1.svg" alt="colortools调色板1" width="70%" />
<p class="caption">(\#fig:colortools1)colortools调色板1</p>
</div>


```r
colortools::wheel(colortools::pals("fish")[1], bg = "white")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/colortools2-1.svg" alt="colortools调色板2" width="70%" />
<p class="caption">(\#fig:colortools2)colortools调色板2</p>
</div>



```r
library(colorspace)
## a few useful diverging HCL palettes
op <- par(mar = c(0,0,2,0), mfrow = c(16, 2))

pal(diverge_hcl(16), main = "diverging HCL palettes")
pal(diverge_hcl(16, h = c(246, 40), c = 96, l = c(65, 90)))
pal(diverge_hcl(16, h = c(130, 43), c = 100, l = c(70, 90)))
pal(diverge_hcl(16, h = c(180, 70), c = 70, l = c(90, 95)))

pal(diverge_hcl(16, h = c(180, 330), c = 59, l = c(75, 95)))
pal(diverge_hcl(16, h = c(128, 330), c = 98, l = c(65, 90)))
pal(diverge_hcl(16, h = c(255, 330), l = c(40, 90)))
pal(diverge_hcl(16, c = 100, l = c(50, 90), power = 1))

## sequential palettes
pal(sequential_hcl(16), main= "sequential palettes")
pal(heat_hcl(16, h = c(0, -100), l = c(75, 40), c = c(40, 80), power = 1))
pal(terrain_hcl(16, c = c(65, 0), l = c(45, 95), power = c(1/3, 1.5)))
pal(heat_hcl(16, c = c(80, 30), l = c(30, 90), power = c(1/5, 1.5)))

## compare base and colorspace palettes
## (in color and desaturated)
## diverging red-blue colors
pal(diverge_hsv(16), main = "diverging red-blue colors")
pal(diverge_hcl(16, c = 100, l = c(50, 90)))
pal(desaturate(diverge_hsv(16)))
pal(desaturate(diverge_hcl(16, c = 100, l = c(50, 90))))

## diverging cyan-magenta colors
pal(cm.colors(16), main = "diverging cyan-magenta colors")
pal(diverge_hcl(16, h = c(180, 330), c = 59, l = c(75, 95)))
pal(desaturate(cm.colors(16)))
pal(desaturate(diverge_hcl(16, h = c(180, 330), c = 59, l = c(75, 95))))

## heat colors
pal(heat.colors(16), main = "heat colors")
pal(heat_hcl(16))
pal(desaturate(heat.colors(16)))
pal(desaturate(heat_hcl(16)))

## terrain colors
pal(terrain.colors(16), main = "terrain colors")
pal(terrain_hcl(16))
pal(desaturate(terrain.colors(16)))
pal(desaturate(terrain_hcl(16)))

pal(rainbow_hcl(16, start = 30, end = 300), main = "dynamic")
pal(rainbow_hcl(16, start = 60, end = 240), main = "harmonic")
pal(rainbow_hcl(16, start = 270, end = 150), main = "cold")
pal(rainbow_hcl(16, start = 90, end = -30), main = "warm")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/colorspace-1.svg" alt="colorspace调色板" width="70%" />
<p class="caption">(\#fig:colorspace)colorspace调色板</p>
</div>

```r

par(op)
```


```r
op <- par(mar=c(0,4,0,0))
RColorBrewer::display.brewer.all()
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/RColorBrewer-1.svg" alt="RColorBrewer调色板" width="70%" />
<p class="caption">(\#fig:RColorBrewer)RColorBrewer调色板</p>
</div>

```r
par(op)
```


```r
yarrr::piratepal(palette = "all")
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/yarrr-1.svg" alt="yarrr调色板" width="70%" />
<p class="caption">(\#fig:yarrr)yarrr调色板</p>
</div>


```r
library(dichromat) 
op <- par(mar=c(0,0,2,0),mfrow = c(9,2))
for(i in seq(17)){
	pal(colorschemes[[i]], main =  names(colorschemes)[i])
} 
par(op)
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/dichromat-1.svg" alt="dichromat调色板适用于色盲人群" width="70%" />
<p class="caption">(\#fig:dichromat)dichromat调色板适用于色盲人群</p>
</div>


```r
library(colormap)
color_map <- function(colorname, border = "light gray"){ 
	col <- colormap_pal(colormap=colorname)(25)
	n <- length(col)
	plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
		axes = FALSE, xlab = "", ylab = "")
	rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
	text(.5,.5,labels = colorname)
}
op <- par(mfrow = c(22,2),mar = c(0, 0, 1, 0))
invisible( lapply(unlist(colormaps),color_map) )
```

<div class="figure" style="text-align: center">
<img src="09-colors_files/figure-html/colormap-1.svg" alt="colormap调色板" width="70%" />
<p class="caption">(\#fig:colormap)colormap调色板</p>
</div>

```r
par(op)
```
