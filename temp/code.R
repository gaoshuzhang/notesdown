library(ggplot2)
library(extrafont)
library(xkcd)
# 渲染不出 xkcd 风
pdf(file = 'figures/xkcd.pdf',width = 6,height = 4)
ggplot(aes(mpg, wt), data = mtcars) + geom_point() +
  theme_xkcd()
dev.off()
# Good
cairo_pdf(file = 'figures/xkcd.pdf',width = 6,height = 4)
ggplot(aes(mpg, wt), data = mtcars) + geom_point() +
  theme_xkcd()
dev.off()

