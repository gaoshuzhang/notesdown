# svg to pdf
# 批量转化 svg 文件为 pdf 文件
library(rsvg)
tmp <- 'figure/Ink' # svgs 存放目录
input_paths <- paste0(tmp, '/', list.files(tmp) )
output_paths <- paste0('figure/pdf', '/', gsub('svg','pdf',list.files(tmp)) ) 

for( i in seq(length( list.files(tmp) )) ){
  rsvg_pdf(input_paths[i],file = output_paths[i])
}


