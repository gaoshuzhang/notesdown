FROM rocker/geospatial:latest

MAINTAINER Xiangyun Huang <xiangyunfaith@outlook.com>

# System dependencies for required R packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    imagemagick \
    optipng \
    curl \
    dieharder \
    libdieharder3 \
    libdieharder-dev \
    libpoppler-cpp-dev \
    python-dev \
    python-pip \
    python-tk \
    octave \
    proj-bin \
    libpaper-utils \
    libatlas3-base \
    build-essential \
    python-wheel \
    pstoedit \
  && pip install numpy \
    matplotlib

# TinyTeX for PDF
RUN mkdir ~/.fonts \
  && curl -o ~/.fonts/Inconsolata-Bold.ttf https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Bold.ttf \
  && curl -o ~/.fonts/Inconsolata-Regular.ttf https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Regular.ttf \
  && fc-cache -fv ~/.fonts \
  && git clone --depth=1 --branch=master https://github.com/XiangyunHuang/bookdown-chinese.git \
  && cd bookdown-chinese \
  && tlmgr update --all --self \
  && tlmgr install $(cat TeXLive.pkgs | tr '\n' ' ') || true \
  && Rscript -e "devtools::install_github('leonawicz/mapmate')" \
  && Rscript -e "devtools::install_github('dgrtwo/gganimate')" \
  && Rscript -e "bookdown::render_book('index.Rmd')"

RUN mkdir /liftrroot/
WORKDIR /liftrroot/
