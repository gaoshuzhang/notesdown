# 数据集很简单
# 图的效果，我要 ISLR 统计学习应用与 R 的封面或者 Stanford 统计学习课程logo那样
pairs(trees) # 先从一个简单线性回归开始，
Girth Height Volume





# help(trees) 自带的例子
require(stats); require(graphics)
pairs(trees, panel = panel.smooth, main = "trees data")
plot(Volume ~ Girth, data = trees, log = "xy")
coplot(log(Volume) ~ log(Girth) | Height, data = trees,
       panel = panel.smooth)
summary(fm1 <- lm(log(Volume) ~ log(Girth), data = trees))
summary(fm2 <- update(fm1, ~ . + log(Height), data = trees))
step(fm2)
## i.e., Volume ~= c * Height * Girth^2  seems reasonable
