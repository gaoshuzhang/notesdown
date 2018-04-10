library(methods)
set.seed(2018)
options(digits = 3)

Pkgs <- c(
  "reticulate",
  "showtext", "sysfonts", "showtextdb",
  "fontcm",
  "tikzDevice", "filehash", "png",
  "xkcd", "extrafontdb", "Rttf2pt1", "extrafont"
)
if (length(setdiff(Pkgs, .packages(TRUE))) > 0) {
  install.packages(setdiff(Pkgs, .packages(TRUE)))
}

if (!all(c("source-han-sans-cn", "source-han-serif-cn") %in% showtextdb::font_installed())) {
  showtextdb::font_install(showtextdb::source_han_serif("CN"))
  showtextdb::font_install(showtextdb::source_han_sans("CN"))
}
extrafont::font_install("fontcm")
extrafont::loadfonts()

if (!"xkcd" %in% extrafont::fonts()) {
  if (!file.exists("~/.fonts")) {
    system("mkdir ~/.fonts")
  }
  download.file("http://simonsoftware.se/other/xkcd.ttf", dest = "~/.fonts/xkcd.ttf", mode = "wb")
  extrafont::font_import(paths = "~/.fonts", pattern = "[X/x]kcd", prompt = FALSE)
  extrafont::loadfonts()
}
extrafont::fonts() # registered with pdfFonts()
sysfonts::font_families() # List available font families

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = TRUE,
  cache = TRUE,
  # citation.bibtex.max=999,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  # fig.showtext = TRUE, # too danger
  fig.asp = 0.618, # 1 / phi
  fig.show = "hold",
  fig.ext = if (knitr::is_latex_output()) "pdf" else "png",
  dev = if (knitr::is_latex_output()) "cairo_pdf" else "png",
  engine.path = list(
    octave = "/usr/bin/octave-cli",
    python = "/usr/bin/python"
  )
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
  )
)
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


# devtools::install_github('rmcelreath/glmer2stan')
# names(knitr::knit_engines$get())
# create a bib file for the R packages used in this document

# pkgs <- c('base', 'rmarkdown', 'rstan', 'knitr', 'rstan', 'brms','glmer2stan','loo',
#          'bayesplot', 'rstanarm', 'StanHeaders','shinystan','rstantools')
# knitr::write_bib(pkgs, file = 'skeleton.bib')

# citeFun <- function(x){
#  knitcitations::write.bibtex(citation(x), 
#                            file = 'skeleton.bib', append = TRUE)
# }
# invisible(lapply(pkgs,citeFun))
