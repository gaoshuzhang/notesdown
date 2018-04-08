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
