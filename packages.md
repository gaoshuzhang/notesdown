
# 重现 {#reproduce}

- R


```r
sessionInfo("bookdown")
#> R version 3.4.4 (2017-01-27)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 14.04.5 LTS
#> 
#> Matrix products: default
#> BLAS: /home/travis/R-bin/lib/R/lib/libRblas.so
#> LAPACK: /home/travis/R-bin/lib/R/lib/libRlapack.so
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
#> 
#> attached base packages:
#> character(0)
#> 
#> other attached packages:
#> [1] bookdown_0.7
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_0.12.16    grDevices_3.4.4 sysfonts_0.7.2  digest_0.6.15  
#>  [5] showtextdb_2.0  rprojroot_1.3-2 Rttf2pt1_1.3.6  backports_1.1.2
#>  [9] magrittr_1.5    evaluate_0.10.1 datasets_3.4.4  stringi_1.2.2  
#> [13] utils_3.4.4     extrafontdb_1.0 graphics_3.4.4  rmarkdown_1.9  
#> [17] base_3.4.4      extrafont_0.17  tools_3.4.4     stringr_1.3.1  
#> [21] xfun_0.1        yaml_2.1.19     compiler_3.4.4  stats_3.4.4    
#> [25] htmltools_0.3.6 knitr_1.20      methods_3.4.4
```


```r
pkg <- .packages(all.available = TRUE)
pkgInfo <- lapply(pkg, packageDescription,
  fields = c("Package", "Version", "Maintainer", "Title")
)
knitr::kable(data.frame(
  Package = sapply(pkgInfo, `[[`, 1),
  Version = sapply(pkgInfo, `[[`, 2),
  # Maintainer = sapply(pkgInfo, "[[", 3),
  Title = sapply(pkgInfo, "[[", 4)
),
caption = "R包信息列表",
booktabs = TRUE,
longtable = TRUE
)
```

- LaTeX 


```r
base::system('xelatex --version', intern = TRUE)
#>  [1] "XeTeX 3.14159265-2.6-0.99999 (TeX Live 2018)"                    
#>  [2] "kpathsea version 6.3.0"                                          
#>  [3] "Copyright 2018 SIL International, Jonathan Kew and Khaled Hosny."
#>  [4] "There is NO warranty.  Redistribution of this software is"       
#>  [5] "covered by the terms of both the XeTeX copyright and"            
#>  [6] "the Lesser GNU General Public License."                          
#>  [7] "For more information about these matters, see the file"          
#>  [8] "named COPYING and the XeTeX source."                             
#>  [9] "Primary author of XeTeX: Jonathan Kew."                          
#> [10] "Compiled with ICU version 61.1; using 61.1"                      
#> [11] "Compiled with zlib version 1.2.11; using 1.2.11"                 
#> [12] "Compiled with FreeType2 version 2.9.0; using 2.9.0"              
#> [13] "Compiled with Graphite2 version 1.3.11; using 1.3.11"            
#> [14] "Compiled with HarfBuzz version 1.7.6; using 1.7.6"               
#> [15] "Compiled with libpng version 1.6.34; using 1.6.34"               
#> [16] "Compiled with poppler version 0.63.0"                            
#> [17] "Compiled with fontconfig version 2.11.0; using 2.11.0"
```


```r
base::system('tlmgr info --list --only-installed --data name,size', intern = TRUE)
#>   [1] "a4wide,4096"                      
#>   [2] "adjustbox,90112"                  
#>   [3] "ae,643072"                        
#>   [4] "algorithm2e,167936"               
#>   [5] "algorithms,16384"                 
#>   [6] "amscls,323584"                    
#>   [7] "amsfonts,7696384"                 
#>   [8] "amsmath,196608"                   
#>   [9] "animate,110592"                   
#>  [10] "apacite,774144"                   
#>  [11] "appendix,12288"                   
#>  [12] "babel,3268608"                    
#>  [13] "babel-english,36864"              
#>  [14] "babelbib,856064"                  
#>  [15] "bbm-macros,16384"                 
#>  [16] "beamer,1032192"                   
#>  [17] "biblatex,2084864"                 
#>  [18] "bibtex,208896"                    
#>  [19] "bibtex.x86_64-linux,167936"       
#>  [20] "blkarray,73728"                   
#>  [21] "booktabs,8192"                    
#>  [22] "boondox,401408"                   
#>  [23] "breakurl,12288"                   
#>  [24] "caption,212992"                   
#>  [25] "carlisle,45056"                   
#>  [26] "ccaption,24576"                   
#>  [27] "changepage,16384"                 
#>  [28] "chemgreek,49152"                  
#>  [29] "cite,73728"                       
#>  [30] "cleveref,331776"                  
#>  [31] "cm,1392640"                       
#>  [32] "collectbox,12288"                 
#>  [33] "collection-basic,0"               
#>  [34] "collection-latex,0"               
#>  [35] "colortbl,12288"                   
#>  [36] "comment,12288"                    
#>  [37] "courier,1191936"                  
#>  [38] "csquotes,94208"                   
#>  [39] "ctable,12288"                     
#>  [40] "datetime,270336"                  
#>  [41] "diagbox,12288"                    
#>  [42] "doi,4096"                         
#>  [43] "doublestroke,237568"              
#>  [44] "draftwatermark,4096"              
#>  [45] "dvipdfmx,163840"                  
#>  [46] "dvipdfmx.x86_64-linux,20480"      
#>  [47] "dvips,380928"                     
#>  [48] "dvips.x86_64-linux,376832"        
#>  [49] "dvisvgm,0"                        
#>  [50] "dvisvgm.x86_64-linux,5492736"     
#>  [51] "ec,5918720"                       
#>  [52] "enctex,253952"                    
#>  [53] "enumitem,45056"                   
#>  [54] "environ,8192"                     
#>  [55] "eso-pic,16384"                    
#>  [56] "etex,45056"                       
#>  [57] "etex-pkg,20480"                   
#>  [58] "etoolbox,49152"                   
#>  [59] "euenc,57344"                      
#>  [60] "eurosym,294912"                   
#>  [61] "everypage,4096"                   
#>  [62] "fancybox,28672"                   
#>  [63] "fancyhdr,20480"                   
#>  [64] "fancyvrb,73728"                   
#>  [65] "fix2col,8192"                     
#>  [66] "float,8192"                       
#>  [67] "floatrow,90112"                   
#>  [68] "fmtcount,290816"                  
#>  [69] "fontspec,307200"                  
#>  [70] "footmisc,28672"                   
#>  [71] "fp,151552"                        
#>  [72] "fpl,737280"                       
#>  [73] "framed,24576"                     
#>  [74] "geometry,45056"                   
#>  [75] "glyphlist,98304"                  
#>  [76] "graphics,126976"                  
#>  [77] "graphics-cfg,8192"                
#>  [78] "graphics-def,86016"               
#>  [79] "gsftopk,8192"                     
#>  [80] "gsftopk.x86_64-linux,94208"       
#>  [81] "hardwrap,12288"                   
#>  [82] "harvard,225280"                   
#>  [83] "helvetic,2433024"                 
#>  [84] "hyperref,962560"                  
#>  [85] "hyph-utf8,102400"                 
#>  [86] "hyphen-base,98304"                
#>  [87] "ifluatex,8192"                    
#>  [88] "ifmtarg,4096"                     
#>  [89] "iftex,4096"                       
#>  [90] "ifxetex,4096"                     
#>  [91] "inconsolata,1302528"              
#>  [92] "jknapltx,77824"                   
#>  [93] "kastrup,4096"                     
#>  [94] "kerkis,3112960"                   
#>  [95] "knuth-lib,192512"                 
#>  [96] "knuth-local,212992"               
#>  [97] "koma-script,23203840"             
#>  [98] "kpathsea,208896"                  
#>  [99] "kpathsea.x86_64-linux,163840"     
#> [100] "l3experimental,286720"            
#> [101] "l3kernel,1146880"                 
#> [102] "l3packages,155648"                
#> [103] "lastpage,16384"                   
#> [104] "latex,1675264"                    
#> [105] "latex-bin,0"                      
#> [106] "latex-bin.x86_64-linux,16384"     
#> [107] "latex-fonts,249856"               
#> [108] "latexconfig,40960"                
#> [109] "lineno,245760"                    
#> [110] "lipsum,106496"                    
#> [111] "listings,479232"                  
#> [112] "lm,43601920"                      
#> [113] "logreq,12288"                     
#> [114] "ltxmisc,69632"                    
#> [115] "lua-alt-getopt,4096"              
#> [116] "luatex,151552"                    
#> [117] "luatex.x86_64-linux,26660864"     
#> [118] "makeindex,36864"                  
#> [119] "makeindex.x86_64-linux,151552"    
#> [120] "manfnt,4096"                      
#> [121] "marvosym,208896"                  
#> [122] "mathabx,880640"                   
#> [123] "mathpazo,167936"                  
#> [124] "mathspec,45056"                   
#> [125] "mathtools,114688"                 
#> [126] "mdwtools,126976"                  
#> [127] "memoir,487424"                    
#> [128] "metafont,147456"                  
#> [129] "metafont.x86_64-linux,696320"     
#> [130] "metalogo,8192"                    
#> [131] "mflogo,16384"                     
#> [132] "mfnfss,32768"                     
#> [133] "mfware,16384"                     
#> [134] "mfware.x86_64-linux,593920"       
#> [135] "mhchem,446464"                    
#> [136] "microtype,430080"                 
#> [137] "morefloats,40960"                 
#> [138] "mptopdf,176128"                   
#> [139] "mptopdf.x86_64-linux,4096"        
#> [140] "ms,49152"                         
#> [141] "multirow,16384"                   
#> [142] "natbib,135168"                    
#> [143] "newtx,8867840"                    
#> [144] "nextpage,4096"                    
#> [145] "ntgclass,299008"                  
#> [146] "ntheorem,49152"                   
#> [147] "oberdiek,2879488"                 
#> [148] "palatino,1589248"                 
#> [149] "paralist,16384"                   
#> [150] "parskip,4096"                     
#> [151] "pbox,4096"                        
#> [152] "pdfcrop,40960"                    
#> [153] "pdfcrop.x86_64-linux,8192"        
#> [154] "pdfpages,98304"                   
#> [155] "pdftex,266240"                    
#> [156] "pdftex.x86_64-linux,2191360"      
#> [157] "pgf,5386240"                      
#> [158] "picinpar,16384"                   
#> [159] "pict2e,73728"                     
#> [160] "placeins,4096"                    
#> [161] "plain,1376256"                    
#> [162] "preprint,36864"                   
#> [163] "preview,57344"                    
#> [164] "pslatex,36864"                    
#> [165] "psnfss,450560"                    
#> [166] "pspicture,8192"                   
#> [167] "realscripts,8192"                 
#> [168] "relsize,16384"                    
#> [169] "rsfs,143360"                      
#> [170] "sauerj,32768"                     
#> [171] "scheme-basic,0"                   
#> [172] "scheme-infraonly,0"               
#> [173] "scheme-minimal,0"                 
#> [174] "sectsty,24576"                    
#> [175] "setspace,24576"                   
#> [176] "shadethm,32768"                   
#> [177] "siunitx,323584"                   
#> [178] "soul,24576"                       
#> [179] "stmaryrd,401408"                  
#> [180] "subfig,32768"                     
#> [181] "subfigure,20480"                  
#> [182] "symbol,102400"                    
#> [183] "tabu,118784"                      
#> [184] "tabulary,16384"                   
#> [185] "tetex,516096"                     
#> [186] "tetex.x86_64-linux,77824"         
#> [187] "tex,0"                            
#> [188] "tex-ini-files,32768"              
#> [189] "tex.x86_64-linux,385024"          
#> [190] "tex4ht,33177600"                  
#> [191] "tex4ht.x86_64-linux,299008"       
#> [192] "texlive-common,0"                 
#> [193] "texlive-docindex,1105920"         
#> [194] "texlive-en,0"                     
#> [195] "texlive-msg-translations,1167360" 
#> [196] "texlive-scripts,282624"           
#> [197] "texlive-scripts.x86_64-linux,8192"
#> [198] "texlive.infra,987136"             
#> [199] "texlive.infra.x86_64-linux,270336"
#> [200] "textcase,4096"                    
#> [201] "threeparttable,20480"             
#> [202] "thumbpdf,77824"                   
#> [203] "thumbpdf.x86_64-linux,4096"       
#> [204] "times,1372160"                    
#> [205] "tipa,4489216"                     
#> [206] "titlesec,122880"                  
#> [207] "titling,8192"                     
#> [208] "tocbibind,12288"                  
#> [209] "tocloft,36864"                    
#> [210] "todonotes,20480"                  
#> [211] "tools,368640"                     
#> [212] "trimspaces,4096"                  
#> [213] "tufte-latex,110592"               
#> [214] "txfonts,2285568"                  
#> [215] "ucs,2883584"                      
#> [216] "ulem,24576"                       
#> [217] "underscore,12288"                 
#> [218] "unicode-data,2277376"             
#> [219] "updmap-map,19132416"              
#> [220] "upquote,4096"                     
#> [221] "url,16384"                        
#> [222] "varwidth,12288"                   
#> [223] "vmargin,8192"                     
#> [224] "wrapfig,28672"                    
#> [225] "xargs,16384"                      
#> [226] "xcolor,81920"                     
#> [227] "xcomment,12288"                   
#> [228] "xdvi,36864"                       
#> [229] "xdvi.x86_64-linux,1282048"        
#> [230] "xetex,24576"                      
#> [231] "xetex.x86_64-linux,27086848"      
#> [232] "xetexconfig,4096"                 
#> [233] "xifthen,8192"                     
#> [234] "xkeyval,114688"                   
#> [235] "xltxtra,8192"                     
#> [236] "xstring,61440"                    
#> [237] "xtab,20480"                       
#> [238] "xunicode,208896"                  
#> [239] "zapfchan,241664"                  
#> [240] "zapfding,98304"
# or tinytex::tlmgr(c("info", "--list", "--only-installed", "--data", "name,size"))
```
