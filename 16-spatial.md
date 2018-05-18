
# 空间数据 {#spatial}



## 分析与可视化

Here is a review of existing methods.


## sf


```r
library(sf)
#> Linking to GEOS 3.5.0, GDAL 2.2.2, proj.4 4.8.0
```


- Intro to Geospatial Data with R <http://www.datacarpentry.org/r-raster-vector-geospatial/>

## PrevMap


```r
library(PrevMap)
#> Loading required package: geoR
#> Warning: no DISPLAY variable so Tk is not available
#> --------------------------------------------------------------
#>  Analysis of Geostatistical Data
#>  For an Introduction to geoR go to http://www.leg.ufpr.br/geoR
#>  geoR version 1.7-5.2 (built on 2016-05-02) is now loaded
#> --------------------------------------------------------------
#> Loading required package: maxLik
#> Loading required package: miscTools
#> 
#> Please cite the 'maxLik' package as:
#> Henningsen, Arne and Toomet, Ott (2011). maxLik: A package for maximum likelihood estimation in R. Computational Statistics 26(3), 443-458. DOI 10.1007/s00180-010-0217-1.
#> 
#> If you have questions, suggestions, or comments regarding the 'maxLik' package, please use a forum or 'tracker' at maxLik's R-Forge site:
#> https://r-forge.r-project.org/projects/maxlik/
#> Loading required package: raster
#> Loading required package: sp
#> Loading required package: pdist
#> Loading required package: Matrix
```


案例


```r
library(HSAR)

data(Beijingdistricts)

library(spdep)
plot(Beijingdistricts,border="light grey")
# extract the area of each district
library(rgeos)
library(classInt)
library(RColorBrewer)

Beijingdistricts$geo.area <- gArea(Beijingdistricts,byid=TRUE) / 1000000
x <- Beijingdistricts$geo.area
breaks <- classIntervals(x,4,"fisher")$brks
groups <- cut(x,breaks,include.lowest=TRUE,labels=FALSE)
palette <- brewer.pal(4, "Blues")
plot(Beijingdistricts,col=palette[groups],border="grey")

# extract the district level spatial weights matrix
nb.list <- poly2nb(Beijingdistricts,queen=FALSE)
mat.list <- nb2mat(nb.list,style="W")
M <- as(mat.list,"dgCMatrix")
```



空间数据分析

to think about, not sure if needed but then this would be a good place to point out why our book might have advantages over other books. Compare with:
- Bivand, R., Pebesma, E., Gomez-Rubio, V. (2013): Applied spatial data analysis with R.
- Blangiardo, M. & Cameletti, M. (2015): Spatial and spatio-temporal Bayesian models with R - INLA.
- Brunsdon, C. & Comber, L. (2015): An introduction to R for spatial analysis and mapping.
- Dorman, M. (2014): Learning R for geospatial analysis.
- Hijmans, R. (2016): Spatial data analysis and modeling with R.  http://rspatial.org/intr/index.html (haven't read it but might be more suitable for beginners, however, it does not consider sf; additionally, it provides more code than text, and hence, probably less explanations than our book) 
- Quiang, S. (2016): Environmental and Ecological Statistics with R (not really a competitor, I have ordered a copy, this book is really about modeling, and I would rather prefer the Zuur et al. books over it)
- Wegmann, M., Leutner, B., Dech, S. (2016): Remote Sensing and GIS for ecologists: Using Open Source Software.
- Zuur, A., Ieno, E., Saveliev, A. (2017): Beginner's guide to spatial, temporal and spatial-temporal ecological data analysis with R-INLA.

Put the competing books into categories, e.g., introduction to spatial analysis (Brundsdon, Dorman, Hijmans), advanced spatial analysis (Bivand), topical spatial analysis (Quiang, Wegmann),  (mainly) spatial modeling (Bivand, Blangiardo, Hijmans, Quiang, Zuur).
Point out where our book fits in and which gap it is filling -> somewhere between advanced (but not that hard) and spatial modeling with a broad range of topics (not just one like ecology).
We try to address a broad audiecence with an interest in spatial data, and how things can be **get done**, not just theoretically but in an applied way.
On the other hand, we embed the shown methods into the bigger field of GIScience, provide context and refer to further literature for the interested reader.
