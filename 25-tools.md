
# 软件工具 {#other-tools}



## Octave

安装新版 Octave，详情请见 <https://wiki.octave.org/Octave_for_Debian_systems>

```bash
sudo apt-add-repository -y ppa:octave/stable
sudo apt-get update
sudo apt-get install -y octave
```


```r
Sys.which("octave")
#>            octave 
#> "/usr/bin/octave"
system("octave --version")
#> GNU Octave, version 4.2.2
#> Copyright (C) 2018 John W. Eaton and others.
#> This is free software; see the source code for copying conditions.
#> There is ABSOLUTELY NO WARRANTY; not even for MERCHANTABILITY or
#> FITNESS FOR A PARTICULAR PURPOSE.
#> 
#> Octave was configured for "x86_64-pc-linux-gnu".
#> 
#> Additional information about Octave is available at http://www.octave.org.
#> 
#> Please contribute if you find this software useful.
#> For more information, visit http://www.octave.org/get-involved.html
#> 
#> Read http://www.octave.org/bugs.html to learn how to submit bug reports.
```


## Python

Python 版本和位置


```r
Sys.which("python")
#>            python 
#> "/usr/bin/python"
system2("python", args = "--version", stderr = TRUE)
#> Python 2.7.6
```


升级 Python

```bash
sudo add-apt-repository ppa:fkrull/deadsnakes-python2.7  
sudo apt-get update  
```

可用的 python 模块


```python
help('modules')
#> 
#> Please wait a moment while I gather a list of all available modules...
#> 
#> BaseHTTPServer      atexit              imp                 sets
#> Bastion             audiodev            importlib           setuptools
#> CDROM               audioop             imputil             sgmllib
#> CGIHTTPServer       axi                 inspect             sha
#> Canvas              base64              io                  shelve
#> Cheetah             bdb                 itertools           shlex
#> ConfigParser        binascii            json                shutil
#> Cookie              binhex              jsonpatch           signal
#> DLFCN               bisect              jsonpointer         site
#> Dialog              boto                keyword             sitecustomize
#> DocXMLRPCServer     bsddb               landscape           six
#> FileDialog          bz2                 lib2to3             smtpd
#> FixTk               bzrlib              linecache           smtplib
#> HTMLParser          cPickle             linuxaudiodev       sndhdr
#> IN                  cProfile            locale              socket
#> MimeWriter          cStringIO           logging             spwd
#> OpenSSL             calendar            lsb_release         sqlite3
#> PAM                 cgi                 macpath             sre
#> Queue               cgitb               macurl2path         sre_compile
#> ScrolledText        chardet             mailbox             sre_constants
#> SimpleDialog        chunk               mailcap             sre_parse
#> SimpleHTTPServer    cloudinit           markupbase          ssl
#> SimpleXMLRPCServer  cmath               marshal             stat
#> SocketServer        cmd                 math                statvfs
#> StringIO            code                matplotlib          string
#> TYPES               codecs              md5                 stringold
#> Tix                 codeop              mercurial           stringprep
#> Tkconstants         collections         mhlib               strop
#> Tkdnd               colorsys            mimetools           struct
#> Tkinter             commands            mimetypes           subprocess
#> UserDict            compileall          mimify              sunau
#> UserList            compiler            miniterm            sunaudio
#> UserString          configobj           mmap                svg_regex
#> _LWPCookieJar       contextlib          modulefinder        svg_transform
#> _MozillaCookieJar   cookielib           mpl_toolkits        symbol
#> __builtin__         copy                multifile           symtable
#> __future__          copy_reg            multiprocessing     sys
#> _abcoll             cqlsh               mutex               sysconfig
#> _ast                cqlshlib            netrc               syslog
#> _bisect             crcmod              new                 tabnanny
#> _bsddb              crypt               nis                 tarfile
#> _codecs             csv                 nntplib             telnetlib
#> _codecs_cn          ctypes              ntpath              tempfile
#> _codecs_hk          curl                nturl2path          termios
#> _codecs_iso2022     curses              numbers             test
#> _codecs_jp          datetime            numpy               textwrap
#> _codecs_kr          dateutil            oauth               this
#> _codecs_tw          dbhash              opcode              thread
#> _collections        dbm                 operator            threading
#> _csv                deb822              optparse            time
#> _ctypes             debconf             os                  timeit
#> _ctypes_test        debian              os2emxpath          tkColorChooser
#> _curses             debian_bundle       ossaudiodev         tkCommonDialog
#> _curses_panel       decimal             parser              tkFileDialog
#> _elementtree        decorator           pdb                 tkFont
#> _functools          difflib             pickle              tkMessageBox
#> _hashlib            dircache            pickletools         tkSimpleDialog
#> _heapq              dis                 pip                 toaiff
#> _hotshot            distutils           pipes               token
#> _io                 doctest             pkg_resources       tokenize
#> _json               dumbdbm             pkgutil             trace
#> _locale             dummy_thread        platform            traceback
#> _lsprof             dummy_threading     plistlib            ttk
#> _md5                easy_install        popen2              tty
#> _multibytecodec     email               poplib              turtle
#> _multiprocessing    encodings           posix               twisted
#> _osx_support        errno               posixfile           types
#> _pyio               exceptions          posixpath           unicodedata
#> _random             fcntl               pprint              unittest
#> _sha                filecmp             prettytable         urllib
#> _sha256             fileinput           profile             urllib2
#> _sha512             fnmatch             pstats              urllib3
#> _socket             formatter           pty                 urlparse
#> _sqlite3            fpectl              pwd                 user
#> _sre                fpformat            py_compile          uu
#> _ssl                fractions           pyclbr              uuid
#> _strptime           ftplib              pycurl              validate
#> _struct             functools           pydoc               virtualenv
#> _symtable           future_builtins     pydoc_data          virtualenv_support
#> _sysconfigdata      gc                  pyexpat             warnings
#> _sysconfigdata_nd   gdbm                pylab               wave
#> _testcapi           genericpath         pyparsing           weakref
#> _threading_local    getopt              pytz                webbrowser
#> _tkinter            getpass             quopri              wheel
#> _warnings           gettext             random              whichdb
#> _weakref            glob                re                  wsgiref
#> _weakrefset         google_compute_engine readline            xapian
#> _yaml               grp                 repr                xdrlib
#> abc                 gzip                requests            xml
#> aifc                hashlib             resource            xmllib
#> antigravity         heapq               rexec               xmlrpclib
#> anydbm              hgext               rfc822              xxsubtype
#> apt                 hgext3rd            rlcompleter         yaml
#> apt_inst            hmac                robotparser         yocto_css
#> apt_pkg             hotshot             rpytools            zipfile
#> aptsources          htmlentitydefs      runpy               zipimport
#> argparse            htmllib             sched               zlib
#> array               httplib             scipy               zope
#> ast                 ihooks              scour               
#> asynchat            imaplib             select              
#> asyncore            imghdr              serial              
#> 
#> Enter any module name to get more help.  Or, type "modules spam" to search
#> for modules whose descriptions contain the word "spam".
```

## Hugo

下载 <https://github.com/gohugoio/hugo/releases>

```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.40.2/hugo_0.40.2_Linux-64bit.deb
sudo dpkg -i hugo_0.40.2_Linux-64bit.deb
```

## LaTeX 

可以考虑打包自定义 TinyTeX 发行版，自定义在于最小的中文支持和最喜爱的英文字体设置 fandol 和 sourceserifpro(XeLaTeX)，mathptmx 和 inconsolata(PDFLaTeX), fibeamer, Pandoc's LaTeX 模板 

在 Windows or MacOS 下需要这行操作

```
tlmgr --repository http://www.preining.info/tlgpg/ install tlgpg
```

系统安装的字体


```r
fonts <- base::system("fc-list :lang=en | sort", intern = TRUE)
unique(do.call(rbind, strsplit(fonts, split = ":"))[, 2])
#>  [1] " DejaVu Sans"            " DejaVu Sans Mono"      
#>  [3] " DejaVu Serif"           " Liberation Mono"       
#>  [5] " Liberation Sans"        " Liberation Sans Narrow"
#>  [7] " Liberation Serif"       " URW Gothic L"          
#>  [9] " URW Bookman L"          " Century Schoolbook L"  
#> [11] " Nimbus Sans L"          " Nimbus Roman No9 L"    
#> [13] " Nimbus Mono L"          " URW Palladio L"        
#> [15] " URW Chancery L"
```

## Pandoc

pandoc 在 R Markdown 中是否可用


```r
rmarkdown::pandoc_available()
#> [1] TRUE
```

pandoc 版本


```r
Sys.which("pandoc")
#>            pandoc 
#> "/usr/bin/pandoc"
system("pandoc -v")
#> pandoc 2.2.1
#> Compiled with pandoc-types 1.17.4.2, texmath 0.11, skylighting 0.7.0.2
#> Default user data directory: /home/travis/.pandoc
#> Copyright (C) 2006-2018 John MacFarlane
#> Web:  http://pandoc.org
#> This is free software; see the source for copying conditions.
#> There is no warranty, not even for merchantability or fitness
#> for a particular purpose.
```

## Rtools

rtools 是否可用


```r
devtools::find_rtools()
#> [1] TRUE
```

算个小栗子


```r
fx <- inline::cxxfunction( signature(x = "integer", y = "numeric" ) , '
	return ScalarReal( INTEGER(x)[0] * REAL(y)[0] ) ;
' )
fx( 2L, 5 ) 
#> [1] 10
```


## 容器 {#container}

### rocker

- Dockerfile <https://docs.docker.com/develop/develop-images/dockerfile_best-practices/>
- build <https://docs.docker.com/engine/reference/builder/#usage>

### Singularity

- <https://github.com/bwlewis/r-and-singularity>
- <http://singularity.lbl.gov/>

### Kubernetes

Kubernetes 容器集群管理 <https://www.kubernetes.org.cn>
参见高策的博客 <http://gaocegege.com>

## apt

适用于 Debian 和 Ubuntu 的软件包管理器

## yum

适用于 Fedora 和 CentOS 的软件包管理器

## tlmgr

基本使用已包含在 **tinytex** \index{tinytex}包 [@R-tinytex] 内


## Git

CR (Carriage Return) 表示回车，LF (Line Feed) 表示换行，Windows 下用回车加换行表示下一行，UNIX/Linux 采用换行符 (LF) 表示下一行，MAC OS 则采用回车符 (CR) 表示下一行

```bash
git config --global core.autocrlf false
```

添加子模块

```bash
git submodule add git://github.com/jgm/pandoc-templates.git templates
```

克隆项目

```bash
git clone --depth=10 --branch=master --recursive \
    git@github.com:XiangyunHuang/pandoc4everything.git
```

配置账户

```bash
git config --global user.email "email"
git config --global user.name "username"
touch .git-credentials
echo "https://username:password@github.com" >> .git-credentials
git config --global credential.helper store
```

往空的 Github 仓库添加本地文件

```bash
git init
git remote add origin https://github.com/XiangyunHuang/notesdown.git
git add -A
git commit -m "balabala"
git push -u origin master
```

本地新建仓库推送至远程分支

```bash
git remote add origin https://github.com/XiangyunHuang/notesdown.git
git add .
git commit -m "init cos-art"
# 此时远程仓库 notesdown 还没有 cos-art 分支
git push origin master:cos-art
```

使用 zsh

```bash
sudo apt update && sudo apt install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```


## 其它

重复实现的关键是拉取一个现有的 Docker 镜像，可以免去安装和环境配置的诸多麻烦。

```bash
docker run --rm -it --name book -e \
 DISPLAY=192.168.99.100:0 -d -p 8282:8787 -e ROOT=TRUE \
 -e USER=rstudio -e PASSWORD=cloud rocker/geospatial
```

`DISPLAY=192.168.99.100:0` 用于启用 X11 设备，否则 rgl 等软件包会报显示警告，`--rm -it` 使得 主机和虚拟机时间一致，否则会有警告^[<https://github.com/rocker-org/rocker/wiki/Allowing-GUI-windows>]

```
# 两个与时间有关的警告
Warning message:
running command 'timedatectl' had status 1 
Failed to create bus connection: No such file or directory
```

<https://stackoverflow.com/questions/43907925/ubuntu-timedatectl-fails-in-docker-container>

```r
capabilities()
 jpeg         png        tiff       tcltk         X11        aqua    http/ftp     sockets      libxml 
 TRUE        TRUE        TRUE        TRUE       FALSE       FALSE        TRUE        TRUE        TRUE 
 fifo      cledit       iconv         NLS     profmem       cairo         ICU long.double     libcurl 
 TRUE        TRUE        TRUE       FALSE        TRUE        TRUE        TRUE        TRUE        TRUE 
```
主机端口号 8282，这里可以改成你自己喜欢的，虚拟机端口号 8787 对应 RStudio Server 默认端口，如果你想自己指定，就去修改 RStudio Server的配置文件。拉取的 Docker 镜像取名 book，这是方便以后启动 docker 时方便，只需

```bash
# 启动
docker start book
# 进入
docker exec -it book bash
```

由于要安装 rstan 和 rstanarm 包，编译的过程中需要比较大的内存空间，默认分配给 docker 的内存要增加到 4 Gb，也就装个软件，大一点的基于 stan 实现的模型，还是适合放在大机器上跑，笔电可以跑跑简单的模型，学习一下就可以了。

R包库存放位置


```r
.libPaths()
#> [1] "/home/travis/R/Library"           "/usr/local/lib/R/site-library"   
#> [3] "/usr/lib/R/site-library"          "/home/travis/R-bin/lib/R/library"
```

查看系统路径，环境变量


```r
strsplit(Sys.getenv("PATH"),split = .Platform$path.sep)
#> [[1]]
#>  [1] "/usr/bin"                                            
#>  [2] "/home/travis/.rvm/gems/ruby-2.4.1/bin"               
#>  [3] "/home/travis/.rvm/gems/ruby-2.4.1@global/bin"        
#>  [4] "/home/travis/.rvm/rubies/ruby-2.4.1/bin"             
#>  [5] "/home/travis/.rvm/bin"                               
#>  [6] "/home/travis/texlive/bin/x86_64-linux"               
#>  [7] "/home/travis/R-bin/bin"                              
#>  [8] "/home/travis/bin"                                    
#>  [9] "/home/travis/.local/bin"                             
#> [10] "/opt/pyenv/shims"                                    
#> [11] "/home/travis/.phpenv/shims"                          
#> [12] "/home/travis/perl5/perlbrew/bin"                     
#> [13] "/home/travis/.nvm/versions/node/v6.12.0/bin"         
#> [14] "/home/travis/.kiex/elixirs/elixir-1.3.2/bin"         
#> [15] "/home/travis/.kiex/bin"                              
#> [16] "/home/travis/gopath/bin"                             
#> [17] "/home/travis/.gimme/versions/go1.7.4.linux.amd64/bin"
#> [18] "/usr/local/phantomjs/bin"                            
#> [19] "/usr/local/phantomjs"                                
#> [20] "/usr/local/neo4j-3.2.7/bin"                          
#> [21] "/usr/local/cmake-3.9.2/bin"                          
#> [22] "/usr/local/clang-5.0.0/bin"                          
#> [23] "/usr/local/sbin"                                     
#> [24] "/usr/local/bin"                                      
#> [25] "/usr/sbin"                                           
#> [26] "/usr/bin"                                            
#> [27] "/sbin"                                               
#> [28] "/bin"                                                
#> [29] "/opt/ghc/bin"                                        
#> [30] "/home/travis/.phpenv/bin"                            
#> [31] "/opt/pyenv/bin"                                      
#> [32] "/home/travis/.yarn/bin"
```
