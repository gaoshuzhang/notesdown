
pdf(file = 'plot.pdf',width=10,height=6)
layout(matrix(seq(6), 2, 3, byrow = TRUE))
op <- par(mar=c(2,2,.5,.5))
# 分类散点图
plot(Sepal.Length~Sepal.Width,data=iris,col = Species,pch=16 )
legend('topright',legend = unique(iris$Species),box.col = "gray",
       pch=16,col = unique(iris$Species) )
box(col="gray")
# 气泡图
plot(Volume~Height,data = trees,pch =16,cex = Girth/8,
     col = rev(terrain.colors(nrow(trees), alpha = .5)))
box(col="gray")
# 折线图
plot(AirPassengers)
box(col="gray")

# 柱形图
set.seed(123456)
barPois <- table(stats::rpois(1000, lambda = 5))
plot(barPois,col = "lightblue",type = 'h',lwd=10,main = "")
box(col="gray")

# 马赛克图
# par(mar=c(2,2,.5,.5))
plot(HairEyeColor,col = "lightblue",border = 'white',main = '')
# box(col="gray")

## 直方图
set.seed(1234)
n <- 2^24
x <- runif(n,0,1)
delta <- 0.01
len <- diff(c(0,which(x < delta),n+1))-1
ylim <- seq( 0, 1800, by = 300)
xlim <- seq( 0, 100, by = 20)

p <- hist(len[len < 101], breaks = -1:100+0.5,plot = FALSE)
plot(p,ann = FALSE,axes = FALSE,col="lightblue",border = "white",main = "")	 
axis( 1, labels = xlim, at = xlim, las = 1) # x 轴
axis( 2, labels = ylim, at = ylim, las = 0) # y 轴
box(col="gray")
par(op)
dev.off()

# 矩阵图 自带 layout 
plot(iris[,-5],col = iris$Species)

