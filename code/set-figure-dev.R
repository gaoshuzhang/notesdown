centre <- function(x, type) {
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = .1))
}
x <- rcauchy(10)
centre(x, "mean")
centre(x, "median")
centre(x, "trimmed")

# type 

# knitr::is_latex_output cairo_pdf
# knitr::is_html_output svg
# 如果 dev 或者 engine 已经存在则不起作用
# 其它情况 png 加上 dpi = 300

# JS 库绘出的图如何转化为 其他格式呢
# 1. 先手动转化保存，看看有没有自动转的方法

if(knitr::is_html_output()) 'svg' else if(knitr::is_latex_output()) 'cairo_pdf' else 'png'




# CJK 字体支持

cairo_pdf(file = "cjk.pdf",width=3,height=1)
svg(file = "cjk.svg",width=3,height=1)
library(grid)
grid.text("\u4F60\u597D",
          y = 2 / 3,
          gp = gpar(fontfamily = "CNS1")
)
grid.text(
  "is 'hello' in (Traditional) Chinese",
  y = 1 / 3
)
dev.off()



