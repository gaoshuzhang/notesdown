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

# 应该使用 cairo_pdf
library(fontcm)
p <- qplot(c(1, 5), c(1, 5)) +
  xlab("Made with CM fonts") + ylab("Made with CM fonts") +
  ggtitle("Made with CM fonts")
# Equation
eq <- "italic(sum(frac(1, n*'!'), n==0, infinity) ==
       lim(bgroup('(', 1 + frac(1, n), ')')^n, n %->% infinity))"
# Without the new fonts
p1 <- p + annotate("text", x = 3, y = 3, parse = TRUE, label = eq) # fig 1
# With the new fonts
p2 <- p + annotate("text",
                   x = 3, y = 3, parse = TRUE,
                   family = "CM Roman", label = eq
) +
  theme(
    text = element_text(size = 16, family = "CM Roman"),
    axis.title.x = element_text(face = "italic"),
    axis.title.y = element_text(face = "bold")
  ) # fig 2
library(gridExtra)
cairo_pdf(file = 'figures/ggplot_cm.pdf',width = 8,height = 4)
grid.arrange(p1,p2, nrow = 1, ncol = 2)
dev.off()

# embed_fonts 只对 pdf 设备产生的图形有效
pdf(file = 'figures/ggplot_cm.pdf',width = 8,height = 4)
grid.arrange(p1,p2, nrow = 1, ncol = 2)
dev.off()
extrafont::embed_fonts("figures/ggplot_cm.pdf", outfile = "figures/ggplot_cm_embed.pdf")

# tikz 之复杂公式
library(tikzDevice)
tf <- file.path(getwd(), "figures/linear.tex")
tikz(tf, width = 6, height = 5.5, pointsize = 30, standAlone = TRUE)
x <- rnorm(10)
y <- x + rnorm(5, sd = 0.25)
model <- lm(y ~ x)
rsq <- summary(model)$r.squared
rsq <- signif(rsq, 4)
plot(x, y, main = "Hello \\LaTeX!", xlab = "$x$", ylab = "$y$", 
     sub = "$\\mathcal{N}(\\mathbf{x};\\mu,\\Sigma)$")
abline(model, col = "red")
mtext(paste("Linear model: $R^{2}=", rsq, "$"), line = 0.5)
legend("bottomright", legend = paste0("$y = ", 
                                      round(coef(model)[2], 3),
                                      "x +", 
                                      round(coef(model)[1], 3), 
                                      "$"
), 
bty = "n")

dev.off()
tinytex::latexmk(file = "figures/linear.tex")