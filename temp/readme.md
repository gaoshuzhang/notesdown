# 压缩和解压缩

1. sudo yum install lzip

用于解压 *.tar.lz

```bash
wget https://ftp.gnu.org/gnu/octave/octave-4.2.2.tar.lz
lzip -d octave-4.2.2.tar.lz
tar -xvf octave-4.2.2.tar

xz -d octave-4.2.2.tar.xz
tar -xvf octave-4.2.2.tar


tar -xzvf file.tar.gz //解压tar.gz
tar -xjvf file.tar.bz2   //解压 tar.bz2
```

压缩力度 tar.gz < tar.xz < tar.lz

- CentOS 7  wifi

```bash
git clone https://github.com/oblique/create_ap
cd create_ap
sudo make install
sudo yum install hostapd dnsmasq
sudo create_ap wlp8s0 enp7s0 cloud cloud2016
```

拉取 docker

```bash
sudo docker run -d -p 8787:8787 -e ROOT=TRUE \
-e USER=rstudio -e PASSWORD=cloud \
rocker/geospatial
```

```bash
qhull-devel gperf glpk-devel
```

## 用 snap 安装软件

<https://docs.snapcraft.io/core/install>

```bash
sudo snap install inkscape
```

## 安装 pandoc

Change to the pandoc source directory and issue the following commands:

```bash
yum install stack
stack upgrade
stack setup
stack install
```

查看字体

```bash
fc-list :lang=zh
fc-list :lang=en
```

## snap 安装

目前 CentOS7 不受支持
<https://docs.snapcraft.io/core/install>

## hugo

Hugo 下载网站 <https://copr.fedorainfracloud.org/coprs/daftaupe/hugo/>

```bash
cd /etc/yum.repos.d
wget https://copr.fedorainfracloud.org/coprs/daftaupe/hugo/repo/epel-7/daftaupe-hugo-epel-7.repo
sudo yum update && sudo yum install hugo
```

```bash
git submodule update --init --recursive
```

解压 zip 文件

```bash
unzip *.zip
```

安装 VS Code <https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions>

```bash
sudo docker run -d -p 8787:8787 -e ROOT=TRUE \
-e USER=rstudio -e PASSWORD=cloud \
rocker/geospatial
```

安装 clickhouse

```bash
sudo apt-get install software-properties-common
sudo apt-add-repository "deb http://repo.yandex.ru/clickhouse/deb/stable/ main/"
sudo apt-get install -y clickhouse-client
```

安装 octave 的依赖

```bash
sudo yum install perl-Digest-MD5 fontconfig glibc-headers libreadline6-devel readline-devel wget libXt-devel fonts-chinese tcl tcl-devel tclx tk tk-devel mesa-libGLU mesa-libGLU-devel  bzip2-devel xz-devel.x86_64 pcre-devel  libcurl  libcurl-devel
libpng libpng-devel libtiff libtiff-devel libjpeg-turbo libjpeg-turbo-devel cairo-devel lapack-devel scalapack-mpich-devel scalapack-openmpi-devel automake autoconf  bison byacc

sudo yum install  stack hugo code hostapd dnsmasq ntfs-3g qbittorrent wine yum-utils docker-ce inkscape make cmake htop ibus ibus-libpinyin lzip epstool icoutils texinfo

ImageMagick-devel GraphicsMagick gnuplot gmp-devel gperftools-devel qhull-devel qhull-devel gperf glpk-devel GraphicsMagick++ GraphicsMagick-c++ arpack-devel fltk-devel gl2ps gl2ps-devel mesa-libOSMesa-devel mesa-libOSMesa qrupdate-devel arpack arpack-devel arpack-static suitesparse suitesparse-devel libsndfile-devel libsndfile GraphicsMagick-devel GraphicsMagick GraphicsMagick-c++ GraphicsMagick-c++-devel hdf5-devel hdf5 portaudio-devel portaudio qt-devel qscintilla-devel arpack fftw fftw-devel
```