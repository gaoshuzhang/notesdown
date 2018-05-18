
---
title: "R 语言学习笔记"
subtitle: "Notes on R, Octave, Python, Graphics, Models and Others/The Box of R for Data Science"
author: "黄湘云"
date: "2018-05-18 22:23:30 CST"
site: bookdown::bookdown_site
geometry: margin=1.18in
documentclass: ctexbook
bibliography: [book.bib, packages.bib]
biblio-style: apalike
lof: yes
lot: yes
graphics: yes
tables: yes
link-citations: yes
links-as-notes: no
colorlinks: yes
toccolor: magenta
classoption: "hyperref, a4paper, UTF8, zihao = -4, linespread = 1.3, table"
description: "这是一个R语言学习笔记"
url: 'https\://notesdown.netlify.com/'
github-repo: "xiangyunhuang/notesdown"
cover-image: "images/dragon.png"
apple-touch-icon: "images/dragon.png"
apple-touch-icon-size: 120
favicon: "favicon.ico"
---



# 前言 

> 荃者所以在鱼，得鱼而忘荃；蹄者所以在兔；得兔而忘蹄；言者所以在意，得意而忘言。吾安得夫忘言之人而与之言哉！

\BeginKnitrBlock{flushright}<p class="flushright">--- 摘自 《庄子·杂篇·物》</p>\EndKnitrBlock{flushright}

> The fish trap exists because of the fish; once you've gotten the fish, you can forget the trap. The rabbit snare exists because of the rabbit; once you've gotten the rabbit, you can forget the snare. Words exist because of meaning; once you've gotten the meaning, you can forget the words. Where can I find a man who has forgotten words so I can have a word with him ? ^[Translated by [Eric D. Kolaczyk](http://math.bu.edu/people/kolaczyk/teach.html)]

\BeginKnitrBlock{flushright}<p class="flushright">--- Chuang Tzu</p>\EndKnitrBlock{flushright}


1. 把平时遇到的问题分类汇总形成一本笔记，用以时常查看和更新。
2. 网罗精美的案例，学习之，应用之
3. 挑选感兴趣的新技能，钻研之
4. 学习心得和体会，尤其是那些年的淌坑经历
5. 从使用者到开发者蜕变，先啃一下 Hadley Wickham 的几本书：
    + The tidyverse style guide/A style guide for the R language <http://style.tidyverse.org/>
    + Advanced R <https://adv-r.hadley.nz/>
    + R packages <http://r-pkgs.had.co.nz/>
    + R for Data Science <http://r4ds.had.co.nz/>
6. 要写书搭网站，先看一下 Yihui Xie 的书
    + bookdown: Authoring Books and Technical Documents with R Markdown <https://bookdown.org/yihui/bookdown/>
    + blogdown: Creating Websites with R Markdown <https://bookdown.org/yihui/blogdown/>
    + R Markdown: The Definitive Guide <https://bookdown.org/yihui/rmarkdown/>



## 致谢 {-}

虚位以待壮士

Thanks go to all contributers in alphabetical order: .

非常感谢谁谁以及谁谁对我的帮助。

\BeginKnitrBlock{flushright}<p class="flushright">黄湘云  
于矿大宝源公寓</p>\EndKnitrBlock{flushright}

## 结构 {-}

第一章：数学符号说明
第二章：基础知识

- R语言基础、高级技巧

你好，世界。我写了一本书。这本书是这样的，第 \@ref(install-setup) 章介绍了啥啥，第 \@ref(math-operator) 章说了啥啥，然后是啥啥……

## 后记 {-}

这本书是在 [RStudio](https://www.rstudio.com/products/rstudio/download/) 内用 [R Markdown](https://rmarkdown.rstudio.com/) 写的， [Git](https://git-scm.com/) 控制版本， [bookdown](https://bookdown.org/yihui/bookdown/) 组织章节， [knitr](https://yihui.name/knitr/) 将 R Markdown 源文件转化为 Markdown 文件， [Pandoc](http://pandoc.org) \index{Pandoc} 再将 Markdown 文件转化为 HTML 文档，而要转化为 PDF 文档则另外需要 TinyTeX\index{TinyTeX} 发行版^[<https://yihui.name/tinytex/>] 和来自 **rticles** [@R-rticles] 包的模板（一个基于 Pandoc 的 LaTeX 模板，两个美元符号包含的就是变量，变量基本上是 LaTeX 包的设置选项）。这个网站是通过 [Travis-CI](https://travis-ci.org/) 把编译结果（即 `_book` 目录）推送到 [Netlify](https://www.netlify.com/)，实现部署。在 Travis-CI 和 Netlify 都与 Github 绑定的情况下，源代码一发生改变就会触发编译和部署，即持续集成和连续部署，你正在阅读的是 2018-05-18 在 [Travis](https://travis-ci.org/XiangyunHuang/notesdown) 上构建的。

如果编译和部署成功，你会看到一个绿色的指示器，否则指示器显示红色。[![Build Status](https://travis-ci.org/XiangyunHuang/notesdown.svg?branch=master)](https://travis-ci.org/XiangyunHuang/notesdown)

[sourceserifpro](https://ctan.org/pkg/sourceserifpro) 设为默认英文字体，[inconsolata](http://levien.com/type/myfonts/inconsolata.html) 用于代码显示，R 包名称在文中以粗体显示，代码块输出用 `#>` 表示，以区分普通的代码注释 `#`

我用了两个 R 包编译这本书，分别是 **knitr**\index{knitr} [@Dynamic2015CRC] 和 **bookdown**\index{bookdown} [@bookdown2016CRC]。绘图使用的中文字体是思源宋体和思源黑体， **showtext**\index{showtext} 包安装和调用，**tikzDevice**\index{tikzDevice} 和 **fontcm**\index{fontcm} 处理其中的数学公式，**xkcd**\index{xkcd} 设置漫画手写体风格，以下是我的 R 进程信息：


```r
sessionInfo()
#> R version 3.4.4 (2017-01-27)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 14.04.5 LTS
#> 
#> Matrix products: default
#> BLAS: /home/travis/R-bin/lib/R/lib/libRblas.so
#> LAPACK: /home/travis/R-bin/lib/R/lib/libRlapack.so
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
#> 
#> attached base packages:
#> [1] methods   stats     graphics  grDevices utils     datasets  base     
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_0.12.16     bookdown_0.7     codetools_0.2-15 sysfonts_0.7.2  
#>  [5] digest_0.6.15    showtextdb_2.0   rprojroot_1.3-2  Rttf2pt1_1.3.6  
#>  [9] backports_1.1.2  magrittr_1.5     evaluate_0.10.1  stringi_1.2.2   
#> [13] extrafontdb_1.0  rmarkdown_1.9    extrafont_0.17   tools_3.4.4     
#> [17] stringr_1.3.1    xfun_0.1         yaml_2.1.19      compiler_3.4.4  
#> [21] htmltools_0.3.6  knitr_1.20
```


\BeginKnitrBlock{rmdwarning}<div class="rmdwarning">本书采用 [知识共享署名-非商业性使用-禁止演绎 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/) 许可，请君自重，别没事儿拿去传个什么新浪爱问、百度文库以及 XX 经济论坛，项目中代码使用 [MIT 协议](https://github.com/XiangyunHuang/notesdown/blob/master/LICENSE) 开源</div>\EndKnitrBlock{rmdwarning}
<img src="images/by-nc-nd.svg" width="15%" style="display: block; margin: auto auto auto 0;" />



