# How to build TinyTeX from sketch

## 配置网络

```bash
sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s8
```

自动获取IP，只需将 ONBOOT=no 改为 ONBOOT=yes，然后重启网络

```bash
sudo service network restart
```

然后更新 yum  

```bash
sudo yum update 
sudo yum groupinstall "Development Tools" 
```

删除之前的内核

```bash
rpm -qa | grep kernel
yum remove kernel-3.10.0-693.el7.x86_64
```

配置 VBox 的网卡2的网络为 仅主机(Host-Only)网络,网卡1的配置不变 

```bash
systemctl stop firewalld # 关闭防火墙 
systemctl disable firewalld.service # 禁止启动
```

查看防火墙和 sshd 状态

```bash
firewall-cmd --state #查看默认防火墙状态
systemctl status sshd 
```

虚拟机能 ping 通主机，主机不能ping 通虚拟机，原因是 VirtualBox Host-Only Network #3 与虚拟机 ip 不在同一网段，修改 VirtualBox Host-Only Network #3 的配置为自动获取

- 安装 R

```bash
yum install epel-release
yum install -y R
```

R 包默认存放目录添加写权限，其他 R 包 放 site-library

```bash
sudo chmod -R +777 /usr/lib64/R/library
```

安装一些依赖

```bash
yum install -y libcurl-devel openssl-devel libssh2-devel libxml2-devel \
   ImageMagick-c++-devel librsvg2-devel \
   readline-devel v8-314-devel libXmu libXmu-devel\
   tclx tclx-devel mesa-libGLU mesa-libGLU-devel   
```  

- 安装 R 包

```r
install.packages(c('curl', 'openssl', 'git2r', 'xml2', 'devtools', 'ggplot2', 'magick', 'rsvg', 'bookdown'))
```

- 安装 zsh

```bash
sudo yum update && sudo yum -y install zsh git curl wget deltarpm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

- 安装 RStudio Server

```bash
wget https://download2.rstudio.org/rstudio-server-rhel-1.1.419-x86_64.rpm
sudo yum install rstudio-server-rhel-1.1.419-x86_64.rpm
```

查看文件

```bash
du -h --max-depth=2
```

- 配置 rstudio   

如果是自己编译安装 R，就需要手动这一步

```bash
/etc/rstudio/rserver.conf  
rsession-which-r=/usr/local/bin/R
```

- rstudio 手册
http://docs.rstudio.com/ide/server-pro/

- 可用的字体

CentOS 下 repo 中常见字体名字

```
dejavu-fonts-common
dejavu-sans-fonts
dejavu-sans-mono-fonts
dejavu-serif-fonts

fontawesome-fonts
fontawesome-fonts-web

dejavu-lgc-sans-fonts
dejavu-lgc-sans-mono-fonts
dejavu-lgc-serif-fonts

google-noto-cjk-fonts
google-noto-emoji-fonts
google-noto-fonts-common
google-noto-sans-cjk-fonts
google-noto-sans-fonts
google-noto-sans-simplified-chinese-fonts

stix-fonts
stix-math-fonts
wqy-zenhei-fonts
```

## 自带的 texlive

列出已经安装的 texlive\* 包，这些是随着 R 一块安装的

```bash
yum list installed | grep texlive\*
```

再安装基本的 tex 包，确保英文 pdf 文档可以在 pdflatex 引擎下编译

```bash
sudo yum install texlive-framed texlive-titling
```

## 下载 TinyTeX

- 首选

```bash
wget http://mirrors.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzvf install-tl-unx.tar.gz
cd install-tl\*
sudo ./install-tl
```

设置basic的安装，只安装 tlmgr 管理器和 basic texlive

```
<S> set installation scheme: scheme-basic
```

```
Add /usr/local/texlive/2017/texmf-dist/doc/man to MANPATH.
Add /usr/local/texlive/2017/texmf-dist/doc/info to INFOPATH.
Most importantly, add /usr/local/texlive/2017/bin/x86_64-linux
to your PATH for current and future sessions.
```

然后编译安装 R 

- 或者先安装 tinytex 包，再通过 R 包， 安装 TinyTeX，但是必然在安装 R 包的时候，因为依赖安装 200+ 个老旧的 TeX 包
- 或者通过脚本安装谢益辉的 TinyTeX （不推荐）

- tinytex 安装脚本
https://yihui.name/tinytex/ 

```bash
yum install perl-Digest-MD5 fontconfig
wget -qO- \
  "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | sh
```

- 安装 tex 包

- tlmgr 管理器手册
https://www.tug.org/texlive/doc/tlmgr.html#install-option-...-pkg

```bash
tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
tlmgr install fontspec ctex tex inconsolata cjk zhnumber \
  fandol xecjk environ ulem trimspaces sourcesanspro sourcecodepro \
  appendix metalogo realscripts xltxtra ms beamer etoolbox translator ec
```

## 编译 R

- 下载 R 源码包

```bash
wget https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/base/R-3/R-3.4.3.tar.gz
tar -xzvf R-3.4.3.tar.gz
```

- 安装必要的 inconsolata 包

```bash
su root
tlmgr install inconsolata ctex l3kernel l3packages ms zapfding fancyvrb booktabs
```

配置 R 的命令

```bash
./configure --enable-long-double --enable-nls --enable-long-double \
  --enable-largefile --enable-R-shlib --enable-byte-compiled-packages \
  --enable-openmp --enable-BLAS-shlib --enable-memory-profiling --with-x=yes \
  --with-blas --with-lapack --with-tcltk --with-cairo --with-libpng --with-jpeglib --with-libtiff
```

- 安装 R

```bash
make 
sudo make install
```
- 安装 sf

```bash
sudo yum install netcdf-devel hdf5-devel armadillo-devel freexl-devel unixODBC-devel geos-devel
```

- 配置 rgdal

```
./configure --with-armadillo=yes
make 
sudo make install
```

```bash
yum install gdal-devel proj-devel proj-epsg proj-nad geos-devel udunits2-devel \
```   
