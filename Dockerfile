FROM cloud2016/bookdown-chinese

MAINTAINER Xiangyun Huang <xiangyunfaith@outlook.com>

# System dependencies for required R packages
RUN yum -y update
RUN yum install -y epel-release
RUN yum -y update
RUN yum install -y pandoc \
    pandoc-citeproc \
    mesa-libGLU \
    mesa-libGLU-devel \
    librsvg2-devel \
    libsndfile-devel \
    portaudio-devel \
    mesa-libOSMesa-devel \
    librsvg2-tools \
    libXpm-devel \
    libwebp-devel \
    xz-devel \
    pcre-devel \
    glibc-headers \
    libreadline6-devel \
    readline-devel \
    libXt-devel \
    tcl \
    tcl-devel \
    tclx	

RUN Rscript -e "devtools::session_info();.packages(TRUE)"
  
RUN Rscript -e "install.packages('rstan', repos = 'https://cran.rstudio.com')"

RUN mkdir /liftrroot/
WORKDIR /liftrroot/
