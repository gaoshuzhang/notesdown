## 简单的画图流程

# 获取数据，清洗数据，数据重塑，绘图

# curl -s "https://github.com/users/XiangyunHuang/contributions" | head -n 12

html_lines <- readLines("https://github.com/users/XiangyunHuang/contributions")
data_lines <- grep('class = "day"', html_lines, value = T)

github_ctb <- matrix(data = 0, nrow = length(data_lines), ncol = 3)
for (i in seq(length(data_lines))) {
  github_ctb[i, ] <- strsplit(data_lines[i], split = '\"')[[1]][c(12, 14, 16)]
}
github_ctb_df <- as.data.frame(github_ctb, stringsAsFactors = FALSE)
colnames(github_ctb_df) <- c("color", "count", "date") # 填充色
ctb_color <- github_ctb_df$color
ctb_date <- as.Date(github_ctb_df$date) # 贡献日期
ctb_count <- rep(0, dim(github_ctb_df)[1])

for (i in seq(dim(github_ctb_df)[1])) {
  ctb_count[i] <- eval(parse(text = github_ctb_df$count[i]))
}

ctb_df <- data.frame(date = ctb_date, count = ctb_count, color = ctb_color, stringsAsFactors = FALSE)
# 寻找一个合适的方式展示
devtools::install_github("rCarto/yach")
library(yach)
calendarHeat(
  dates = ctb_df$date, values = ctb_df$count, colors = ctb_df$color,
  ncolors = length(ctb_df$color),
  title = "Number of Contributions in the Last Year"
)
