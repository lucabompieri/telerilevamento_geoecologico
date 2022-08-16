# this is the 10th script
# R_code_LiDAR.r

# upload "raster" package
library(raster) #"Geographic Data Analysis and Modeling"
# upload "RStoolbox" package
library(RStoolbox)
# upload "rgdal" package
library(rgdal) #"Geospatial Data Abstraction Library"
# upload "ggplot2" package
library(ggplot2) # for ggplot plotting
# "upload "viridis" package
library(viridis)
# install "lidR" package
# install.packages("lidR")
# upload "lidR"" package
library(lidR)

# set the working directory
setwd("C:/lab/") # Windows 

# use "raster" function to import dsm of 2013
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
# call the object to see info inside it
dsm_2013

# use "raster" function to import dtm of 2013
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
# call the object to see info inside it
dtm_2013

# plot of 2013's plot
plot(dtm_2013)

# do the 2013 chm to see the difference between the dsm and the dtm
chm_2013 <- dsm_2013-dtm_2013
# call the object
chm_2013 

# chm 2013 plot with viridis legend
# open an empty plot and add the "geom_raster" function
ggplot() + 
geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2013 San Genesio/Jenesien")

# use "raster" to import the 2004 dsm 
dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
# call the object
dsm_2004

# use the "raster" function to import 2004 dtm
dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")
# call the object
dtm_2004

# chm 2004 to see difference between dsm and dtm
chm_2004 <- dsm_2004 - dtm_2004
# call the object
chm_2004

# chm 2004 plot with viridis legend
# open an empty plot and add the "geom_raster" function
ggplot() + 
geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2004 San Genesio/Jenesien")

# change chm 2013 resolution to show tìdifference between the 2 chm
# do it through the resampled image 
chm_2013_r <- resample(chm_2013, chm_2004)

# comparison the 2 chm
diffchm <- chm_2013_r - chm_2004
# call the object
diffchm

# diffchm plot with viridis legend
# open an empty ggplot and add to it the "geom_raster" function
ggplot() + 
geom_raster(diffchm, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM difference San Genesio/Jenesien")

# use "readLAS" function to import the ponit_cloud
point_cloud <- readLAS("point_cloud.laz")

# point cloud plot
plot(point_cloud)
