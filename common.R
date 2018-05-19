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
  path <- path.expand("~/.fonts")
  if (!file.exists(path)) {
    dir.create(path = path.expand("~/.fonts"))
  }
  download.file("http://simonsoftware.se/other/xkcd.ttf", dest = path.expand("~/.fonts/xkcd.ttf"), mode = "wb")
  extrafont::font_import(paths = path.expand("~/.fonts"), pattern = "[X/x]kcd", prompt = FALSE)
  extrafont::loadfonts()
}

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
  fig.asp = 0.618, # 1 / phi
  # fig.show = "hold", # not for python matplotlib
  fig.ext = if (knitr::is_html_output()) "svg" else if (knitr::is_latex_output()) "pdf" else "png",
  dev = if (knitr::is_html_output()) "svg" else if (knitr::is_latex_output()) "pdf" else "png",
  engine.path = list(
    octave = "/usr/bin/octave-cli"
  )
)
ext <- if (knitr::is_html_output()) ".svg" else if (knitr::is_latex_output()) ".pdf" else ".png"

knitr::knit_hooks$set(optipng = knitr::hook_optipng, pdfcrop = knitr::hook_pdfcrop)

# https://github.com/yihui/knitr-examples/blob/master/085-pdfcrop.Rnw
# knitr::knit_hooks$set(crop = hook_pdfcrop)
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
# https://github.com/yihui/knitr-examples/blob/master/047-tikz-png.Rnw
knitr::knit_hooks$set(tikz2png = function(before, options, envir) {
  # use this hook only for dev='tikz' and externalized tikz graphics
  if (before || options$dev != "tikz" || !options$external || options$fig.num == 0) return()
  figs <- knitr:::all_figs(options, ext = "pdf") # all figure names
  # note the tikz2png option is the extra parameters passed to 'convert'
  for (fig in figs) {
    system(sprintf("convert %s %s %s", options$tikz2png, fig, sub("\\.pdf$", ".png", fig)))
  }
})


is_on_travis = identical(Sys.getenv("TRAVIS"), "true")
is_online = curl::has_internet()

library(reticulate)
if(is_on_travis) use_python("/opt/pyenv/shims/python") else use_python("/usr/bin/python", required = FALSE)
# Python 环境的描述在附录
# required = FALSE 默认值，如果按照指定的位置没有找到 Python 就会扫描其它版本

# use_virtualenv("shims")

# 设置环境变量 RSTUDIO_CONNECT_SERVER 由 travis-ci 设置
connectServer <- Sys.getenv("RSTUDIO_CONNECT_SERVER") # https://bookdown.org
apiKey <- Sys.getenv("RSTUDIO_CONNECT_API_KEY")
