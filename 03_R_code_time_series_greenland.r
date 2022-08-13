# R_code_time _series_greenland.r
# Third script

# Time series analysis of Greenland increase LST data (temperature)

# upload/install packages series for the script
# upload raster package
library(raster)
# upload rgdal package
library(rgdal)
# install rasterVis package
install.packages ("rasterVis")
# ulpload the last package
library(rasterVis)

# set the working directory
setwd("C:/lab/greenland") # for windows

# assign to object the "raster" function to import the images
Lst_2000 <- raster("lst_2000.tif")
Lst_2005 <- raster("lst_2005.tif")
Lst_2010 <- raster("lst_2010.tif")
Lst_2015 <- raster("lst-2015.tif")

# call the obiects to see their information
lst_2000
lst_2005
lst_2010
lst_2015

# plot the 2000 image
plot(Lst_2000)
dev.off()

# build a multiframe with 4 images
# create a new color palete to improve the visual
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
par(mfrow=c(2,2))
plot(Lst_2000, col=cl)
plot(Lst_2005, col=cl)
plot(Lst_2010, col=cl)
plot(Lst_2015, col=cl)
dev.off()

# metod to import all the images
# create a file list with the function "list.files" and assign it to an object
# "pattern" search inside the working directory all the files with similar part in the name ("in this case "lst")
rlist <- list.files(pattern="lst")
# visualize the files inside the list
rlist

# apply the "raster" function to the list using another function "lapply" and assign it to an object
import <- lapply(rlist,raster)
# visualize the imported files
import

# create a file, joining images, usign the "stack" function and assign it to an object 
TGr <- stack (import)
# new file
TGr

# new file plot
plot(TGr, col=cl)
dev.off()

# plot only an image
plot(TGr[[3]], col=cl)
dev.off()

# plot TGr in RGB using several overlaps
plotRGB(TGr, 1, 2, 3, strecth="Lin")
plotRGB(TGr, 2, 3, 4, strecth="Lin")
plotRGB(TGr, 4, 3, 2, strecth="Lin")
