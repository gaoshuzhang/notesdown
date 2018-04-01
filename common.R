library(methods)

set.seed(2018)
options(digits = 3)

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = TRUE,
  # cache = TRUE,
  out.width = "70%",
  fig.align = 'center',
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold"
)
# library(knitr)
# knitr::knit_hooks$set(optipng = hook_optipng, pdfcrop = hook_pdfcrop)
library(knitr)
# https://github.com/yihui/knitr-examples/blob/master/085-pdfcrop.Rnw
knitr::knit_hooks$set(crop = hook_pdfcrop)
options(
  tikzDefaultEngine = "xetex",
  tikzXelatexPackages = c(
    getOption("tikzXelatexPackages"),
    "\\usepackage[colorlinks, breaklinks]{hyperref}",
    "\\usepackage{color}",
    "\\usepackage{tikz}",
    "\\usepackage[active,tightpage,xetex]{preview}",
    "\\PreviewEnvironment{pgfpicture}",
    "\\usepackage{amsmath}",
    "\\usepackage{amsfonts}",
    "\\usepackage{mathrsfs}"
  ))
# https://github.com/yihui/knitr-examples/blob/master/047-tikz-png.Rnw
# knitr::knit_hooks$set(tikz2png = function(before, options, envir) {
#   # use this hook only for dev='tikz' and externalized tikz graphics
#   if (before || options$dev != 'tikz' || !options$external || options$fig.num == 0) return()
#   figs = knitr:::all_figs(options, ext = 'pdf')  # all figure names
#   # note the tikz2png option is the extra parameters passed to 'convert'
#   for (fig in figs) {
#     system(sprintf('convert %s %s %s', options$tikz2png, fig, sub('\\.pdf$', '.png', fig)))
#   }
# })
