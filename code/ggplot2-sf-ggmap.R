# https://stackoverflow.com/questions/49626233/plotting-static-base-map-underneath-a-sf-object
# sf geom_sf ggmap

library(sf)
# > Linking to GEOS 3.5.1, GDAL 2.1.3, proj.4 4.9.2
# devtools::install_github("r-lib/rlang")
# devtools::install_github("tidyverse/ggplot2")
library(ggplot2)
library(ggmap)

nc <- st_read(system.file("shape/nc.shp", package = "sf"))
# > Reading layer `nc' from data source `/home/gilles/R/x86_64-pc-linux-gnu-library/3.4/sf/shape/nc.shp' using driver `ESRI Shapefile'
# > Simple feature collection with 100 features and 14 fields
# > geometry type:  MULTIPOLYGON
# > dimension:      XY
# > bbox:           xmin: -84.32385 ymin: 33.88199 xmax: -75.45698 ymax: 36.58965
# > epsg (SRID):    4267
# > proj4string:    +proj=longlat +datum=NAD27 +no_defs
nc_map <- get_map(location = "North Carolina, NC", zoom = 7)
# > Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=North+Carolina,+NC&zoom=7&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
# > Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=North%20Carolina,%20NC&sensor=false
nc_centers <- st_centroid(nc)
# > Warning in st_centroid.sfc(st_geometry(x), of_largest_polygon =
# > of_largest_polygon): st_centroid does not give correct centroids for
# > longitude/latitude data

ggmap(nc_map) +
  geom_sf(
    data = nc_centers,
    aes(color = SID79, size = BIR74),
    show.legend = "point", inherit.aes = FALSE
  ) +
  coord_sf(datum = NA) +
  theme_minimal()
# > Coordinate system already present. Adding new coordinate system, which will replace the existing one.
