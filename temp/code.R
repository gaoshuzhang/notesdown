

# 更新R包最多的日子
table(as.Date(pdb$Published))[which.max(table(as.Date(pdb$Published)))]

# ctv  列出 所有 taskviews

对网络中的顶点颜色分类标记

cv[[1]]$packagelist$name

cv[[1]]$name

length(cv)	



split_ctb_df <- split(ctb_df, ctb_df$to_id)

tidy_ctb_df <- function(n){
  data.frame(from_id = as.character( unique(split_ctb_df[[n]]$from_id) ),
             to_id = as.character( rep( unique(split_ctb_df[[n]]$to_id), length(unique(split_ctb_df[[n]]$from_id))) ),
             degree = rep( unique(split_ctb_df[[n]]$degree), length(unique(split_ctb_df[[n]]$from_id)) ) )
}

tidy_ctb <- data.table::rbindlist( lapply(seq(length(split_ctb_df)), tidy_ctb_df) )

tidy_ctb[tidy_ctb$from_id == 'Facebook, Inc',]


