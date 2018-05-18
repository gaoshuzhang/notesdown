
# 数据操作

## 集合运算


## 正则匹配

字符串处理 [Handling Strings with R](http://www.gastonsanchez.com/r4strings/) Gaston Sanchez 著

正则表达式 is ervrywhere，is 高级/hacker's skill 技能

- [正则表达式速查表 -- Python3](https://www.dataquest.io/blog/large_files/python-regular-expressions-cheat-sheet.pdf)
- [Online regex tester and debugger](https://regex101.com/)
- [Regular expression operations](https://docs.python.org/3/library/re.html)

以 CRAN 日志数据为例

- R 包开发者


```r
library(magrittr)
gsub(
  " <([^<>]*)>", "",
  lapply(.packages(TRUE), maintainer)
  %>%
    unlist()
) %>% 
  unique() %>% 
  sort() %>% 
  tail(10)
#>  [1] "Stefan Milton Bache"  "Stefan Widgren"       "Terry M Therneau"    
#>  [4] "Thomas Lumley"        "Vincent Arel-Bundock" "William Revelle"     
#>  [7] "Winston Chang"        "Yang Zhou"            "Yihui Xie"           
#> [10] "Yixuan Qiu"
```

```r
# 网上有多少 R 包
pkg_repos <- c("https://mirrors.tuna.tsinghua.edu.cn/CRAN/","https://inla.r-inla-download.org/R/stable","http://r-forge.r-project.org/")

pkg <- utils::available.packages(repos = pkg_repos)

pkg <- as.data.frame(pkg, stringsAsFactors = FALSE)

pkg$Package
download.packages("Rbooks", destdir = "~/",repos = "http://r-forge.r-project.org/")
```


Github 活动记录 <https://github.com/jonocarroll/butteRfly>

```r
# install.packages("devtools")
devtools::install_github("jonocarroll/butteRfly")
my_socials <- collate_socials(user = c("jonocarroll", "carroll_jono", 4168169), 
                              socials = c("GitHub", "Twitter", "StackOverflow"))
```

## 排序

### order 

### sort


## 索引

### which

向量和矩阵中的操作

### `[[`

## 分组

by


with 和 within


## apply 

### lapply

### sapply
 
### parallel


 
## 合并 

### aggregate

## 映射 

### Map  

### Reduce

openxlsx 
拆分、映射计算，合并

```r
## Load dependencies
if (!require('openxlsx')) install.packages('openxlsx')
library('openxlsx')
 
## Split data apart by a grouping variable;
##   makes a named list of tables
dat <- split(mtcars, mtcars$cyl)
dat
 
 
## Create a blank workbook
wb <- createWorkbook()
 
## Loop through the list of split tables as well as their names
##   and add each one as a sheet to the workbook
Map(function(data, name){
 
    addWorksheet(wb, name)
    writeData(wb, name, data)
 
}, dat, names(dat))
 
 
## Save workbook to working directory
saveWorkbook(wb, file = "example.xlsx", overwrite = TRUE)
```


## 拆分

### split 

### cut

- findInterval
- embed

## 数据库

RMariaDB: Implements a 'DBI'-compliant interface to 'MariaDB' (<https://mariadb.org/>) and 'MySQL' (<https://www.mysql.com/>) databases. <https://github.com/r-dbi/RMariaDB>

- rio <https://github.com/leeper/rio>


