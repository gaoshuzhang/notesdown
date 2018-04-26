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

extrafont::fonts() # registered with pdfFonts()
sysfonts::font_families() # List available font families

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = TRUE,
  cache = TRUE,
  citation.bibtex.max=999,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  # fig.showtext = TRUE, # too danger
  fig.asp = 0.618 # 1 / phi
  # fig.show = "hold", # not for python matplotlib
)

options(
  repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/",
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
