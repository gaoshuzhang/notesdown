FROM centos

MAINTAINER "Xiangyun Huang" <xiangyunfaith@outlook.com>

# System dependencies for required R packages
RUN yum -y update
RUN yum install -y epel-release
RUN yum -y update
RUN yum install -y R \
    libcurl-devel \
    openssl-devel \
    libssh2-devel \
    libxml2-devel

RUN Rscript -e "install.packages(c('devtools', 'bookdown', 'rticles', 'tinytex'), repos = 'https://cran.rstudio.com');.packages(TRUE)"

RUN mkdir /liftrroot/
WORKDIR /liftrroot/
