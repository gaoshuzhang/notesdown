library(spaMM)
data(Loaloa)
lfit <- corrHLfit(cbind(npos, ntot - npos) ~
elev1 + elev2 + elev3 + elev4 + maxNDVI1 + seNDVI
  + Matern(1 | longitude + latitude),
HLmethod = "HL(0,1)", data = Loaloa,
family = binomial(), ranFix = list(nu = 0.5, rho = 2.255197, lambda = 1.075)
)

summary(lfit)

library(maps)

pdf(file = "spaMM-loaloa.pdf", width = 6, height = 4, pointsize = 10)
par(mar = c(4, 4, 2, 0), family = "Times")

filled.mapMM(lfit,
  key.title = title(main = "ratio"), key.axes = axis(4, seq(0, .5, by = .1)),
  color.palette = colorRampPalette(rev(RColorBrewer::brewer.pal(11, name = "Spectral"))),
  map.asp = 1, gridSteps = 61, var.contour.args = list(add = TRUE),
  add.map = TRUE, plot.axes = quote({
    axis(1)
    axis(2)
  }),
  decorations = quote(points(pred[, coordinates], pch = 16, cex = 0.5)),
  plot.title = title(
    main = "Inferred prevalence, North Cameroon",
    xlab = "longitude", ylab = "latitude"
  )
)
dev.off()
