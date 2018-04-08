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

gonme 桌面需要比较好的硬件支持，用起来才不会有笨重的感觉，建议还是使用 fedora 软件比较新，很多不需要自己去编译，比较划算 

centos 7 下安装 octave 3.8.2 的依赖，如果自己编译最新版 octave 

```
GraphicsMagick.x86_64 0:1.3.28-1.el7
GraphicsMagick-c++.x86_64 0:1.3.28-1.el7
arpack.x86_64 0:3.1.3-2.el7
atlas.x86_64 0:3.10.1-12.el7
blas.x86_64 0:3.4.2-8.el7
dejavu-sans-fonts.noarch 0:2.33-6.el7
epstool.x86_64 0:3.08-4.el7
fftw-libs-double.x86_64 0:3.3.3-8.el7
fftw-libs-single.x86_64 0:3.3.3-8.el7
fltk.x86_64 0:1.3.4-1.el7
gd.x86_64 0:2.0.35-26.el7
gl2ps.x86_64 0:1.3.8-2.el7
glpk.x86_64 0:4.52.1-2.el7
gnuplot.x86_64 0:4.6.2-3.el7
gnuplot-common.x86_64 0:4.6.2-3.el7
hdf5.x86_64 0:1.8.12-10.el7
lapack.x86_64 0:3.4.2-8.el7
libaec.x86_64 0:1.0.2-1.el7
libmng.x86_64 0:1.0.10-14.el7
pciutils.x86_64 0:3.5.1-2.el7
qhull.x86_64 0:2003.1-20.el7
qrupdate.x86_64 0:1.1.2-3.el7
qscintilla.x86_64 0:2.8-1.el7
qt.x86_64 1:4.8.5-15.el7_4
qt-settings.noarch 0:19-23.5.el7.centos
qt-x11.x86_64 1:4.8.5-15.el7_4
suitesparse.x86_64 0:4.0.2-10.el7
tbb.x86_64 0:4.1-9.20130314.el7
```