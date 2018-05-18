
# R Markdown {#pandoc-markdown}




- 图片引用



![工作流程图](diagrams/00-workflow.png){#fig:id1 width=70% }

gitbook 这样网页又该如何引用这张图片呢？

<div class="figure" style="text-align: center">
<img src="diagrams/00-workflow.svg" alt="两种编译方式及过程" width="70%" />
<p class="caption">(\#fig:00-workflow)两种编译方式及过程</p>
</div>

如图 \@ref(fig:00-workflow) 展示了两种编译方式


- 表格交叉引用

- 参考文献交叉引用


## bookdown

在指定目录创建 Book 项目，

```r
bookdown:::bookdown_skeleton("~/book")
```

项目根目录的文件列表

```markdown
directory/
├──  index.Rmd
├── 01-intro.Rmd
├── 02-literature.Rmd
├── 03-method.Rmd
├── 04-application.Rmd
├── 05-summary.Rmd
├── 06-references.Rmd
├── _bookdown.yml
├── _output.yml
├──  book.bib
├──  preamble.tex
├──  README.md
└──  style.css
```

broom 和 pixiedust 制作表格 Tables So Beautifully Fine-Tuned You Will Believe It's Magic. <https://github.com/nutterb/pixiedust>


## 复杂表格制作 {#kableExtra}

- kableExtra

借助 kableExtra 包 [@R-kableExtra] 可以制作复杂的统计图表，更多的例子请看 <https://github.com/haozhu233/kableExtra> ，我喜欢这个图标设计，如图 \@ref(fig:kableExtra)

<div class="figure" style="text-align: center">
<img src="diagrams/kableExtra.svg" alt="kableExtra 的徽标" width="30%" />
<p class="caption">(\#fig:kableExtra)kableExtra 的徽标</p>
</div>


```r
library(knitr)
library(kableExtra)
dt <- mtcars[1:5, 1:4]

# HTML table
kable(dt, format = "html", caption = "kableExtra 制作") %>%
  kable_styling(bootstrap_options = "striped",
                full_width = F) %>%
  add_header_above(c(" ", "Group 1" = 2, "Group 2[note]" = 2)) %>%
  add_footnote(c("table footnote"))
```

<table class="table table-striped" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-2)kableExtra 制作</caption>
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="1"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Group 1</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Group 2<sup>a</sup></div></th>
</tr>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:right;"> 22.8 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 93 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 258 </td>
   <td style="text-align:right;"> 110 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:right;"> 18.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 175 </td>
  </tr>
</tbody>
<tfoot>
<tr>
<td style = 'padding: 0; border:0;' colspan='100%'><sup>a</sup> table footnote</td>
</tr>
</tfoot>
</table>



1. 如何将表格横向或者纵向展示


2. 添加短标题


```r
library(dplyr)
library(knitr)
library(kableExtra) # 这个必须加载

df <- data.frame( X = sample(letters, 10), y = runif(10), z = sample(10:20, 10))

kable(df,
      booktabs = TRUE,
      caption = "This caption is way too long and doesnt look good when formatted in the Table of Contents.  What you really need here is a much shorter caption so that your eyes dont go crazy trying to figure out what information the author is trying to convey.  Often there is too much information in the caption anyway so why not shorten it?.",
      escape = FALSE,
      format = 'latex') %>%
  kable_styling(latex_options = c("striped", "hold_position"))
```




```r
kable(df,
      booktabs = TRUE,
      caption = "This caption is way too long and doesnt look good when formatted in the Table of Contents.  What you really need here is a much shorter caption so that your eyes dont go crazy trying to figure out what information the author is trying to convey.  Often there is too much information in the caption anyway so why not shorten it?.",
      caption.short = "This is a shorter caption.",
      escape = FALSE,
      format = 'latex') %>%
  kable_styling(latex_options = c("striped", "hold_position"))
```

