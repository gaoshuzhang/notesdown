FROM centos

MAINTAINER Xiangyun Huang <xiangyunfaith@outlook.com>

# System dependencies for required R packages
RUN yum update \
  && yum install -y --no-install-recommends \
    epel-release
  && yum update \
  && yum install -y --no-install-recommends \
    R \
    libcurl-devel \
    openssl-devel \
    libssh2-devel \
    libxml2-devel \
    ImageMagick-c++-devel \
    librsvg2-devel \
    readline-devel \
    v8-314-devel \
    libXmu \
    libXmu-devel \
    tclx \
    tclx-devel \
    mesa-libGLU \
    mesa-libGLU-devel \
  
# TinyTeX for PDF
RUN Rscript -e "install.packages('rstan')"

RUN mkdir /liftrroot/
WORKDIR /liftrroot/
