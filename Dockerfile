FROM rocker/geospatial:latest

MAINTAINER Xiangyun Huang <xiangyunfaith@outlook.com>

# System dependencies for required R packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ghostscript \
    imagemagick \
    optipng \
    libwebp-dev \
    libgsl-dev \
    dieharder \
    libdieharder3 \
    libdieharder-dev \
    libpoppler-cpp-dev \
    libv8-3.14-dev \
    python-dev \
    python-pip \
    python-tk \
    octave \
    proj-bin \
    libpaper-utils \
    libatlas3-base \
    libopenblas-base \
    pstoedit

RUN sudo -H pip install numpy matplotlib

# TinyTeX for PDF
RUN mkdir ~/.fonts

RUN curl -o ~/.fonts/Inconsolata-Bold.ttf https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Bold.ttf
RUN curl -o ~/.fonts/Inconsolata-Regular.ttf https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Regular.ttf
RUN fc-cache -fv ~/.fonts

RUN tlmgr update --all --self
RUN tlmgr install $(cat TeXLive.pkgs | tr '\n' ' ') || true

RUN Rscript -e "devtools::install_github('leonawicz/mapmate')"

RUN Rscript -e "devtools::install_github('dgrtwo/gganimate')"

RUN Rscript -e "bookdown::render_book('index.Rmd', output_format = 'all')"

RUN mkdir /liftrroot/
WORKDIR /liftrroot/
