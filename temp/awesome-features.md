
- Syntax highlight R code in the terminal <https://github.com/r-lib/prettycode> 在终端中R代码语法高亮
- A 21 century R console (previously known as rice) <https://github.com/randy3k/rtichoke> 21 世纪的R终端：语法高亮和自动补全

- 代码自动换行

```tex
% \includegraphics{images/peaks-inc.pdf} # 文件太大 eps latex 专用
% \includegraphics{images/base.pdf} % 单独设计一页，可以考虑用 tikz/rgl 从某个多元复杂分布
```

- 附录：揭秘如何写这本书，knitr 、 Pandoc 、 R Markdown

1. 介绍 rticles::ctex 模板然后 pandoc 的 latex 模板，主要是其中的 tex 包需要搞清楚关系和用法

```r
# rticles::ctex_template() 文档类
cat(readLines(rticles::ctex_template()) ,sep = "\n") 
```

2. 如何基于 ctexart 写新的文档类，如 [Rob J Hyndman](https://github.com/robjhyndman) 莫纳什大学博士学位论文模板 <https://github.com/robjhyndman/MonashThesis>

- 附录：学习心得，knitr 、 Pandoc 、 R Markdown

0. 掌握 bookdown 相关工具
1. 书籍大纲
2. 添加内容
3. 梳理参考文献，索引
4. 图文混排的排版格式控制（这个一定是最后考虑的）