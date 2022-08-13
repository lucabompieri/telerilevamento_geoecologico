# This is the fourth script
# R_code_time_series_lockdown.r

# R code for the chemical cycling study
# time series of NO2 change in Europe during the lockdown
# https://www.esa.int/Applications/Observing_the_Earth/Copernicus/Sentinel-5P/Coronavirus_lockdown_leading_to_drop_in_pollution_across_Europe
# https://acp.copernicus.org/preprints/acp-2020-995/acp-2020-995.pdf

# upload the "raster" package
library (raster)

# set the working directory
setwd("C:/lab/EN") #for windows

# use "raster" function to import the first image of the time series and assing it to an object
EN01 <- raster("EN_0001.png") 29/01/20
# call the object to view the information
EN01

# plot the NO2 values of january with an appropiate color palette
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN01, col=cl)
dev.off()

# import the image of the march NO2 values (13° data) and plot it
EN13 <- raster("EN_0013.png")
plot(EN13, col=cl)
dev.off()

# to upload and view all the files, creat a list "list.files" and assign it to an object
# pattern search inside the working directory the files with same part of the name
rlist <- list.files(pattern='EN')
# view the files inside the list
rlist

# apply the "raster" function to the list using another function "lapply" and assign it to an oject
rimp <- lapply(rlist,raster)
# view the imported files
rimp

# create a single file, using the 13 images, usign the "stack" function and assign it to an object
ENs <- stack(rimp)
# Visualizzo il nuovo file
ENs

# plot the new file
# creat a new color palette to improve the visualization
cls <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(ENs, col=cls)
dev.off()

# WANT TO PLOT THE 1st AND THE 13th IMAGES TOGETHER, 3 methods

# method 1
# build a multiframe calling the object created at the begginig of the script
par(mfrow=c(2,1))
plot(EN01, col=cl)
plot(EN13, col=cl)
dev.off()

# method 2
# plot the stack's images calling the interested objects
par(mfrow=c(2,1))
plot(ENs$EN_001, col=cl)
plot(ENs$EN_013, col=cl)
dev.off()

# method 3
# stack with the 2 elemtns that i need and plot them
EN113 <- stack(ENs[[1]], ENs[[13]])
plot(EN113, col=cl)
dev.off()

# difference between the 1st and the 13th element
# so can catch the variation of NO2 durig the lockdown
difEN <- ENs[[1]] -ENs[[13]]
# build a new color palette
cldif <- colorRampPalette(c('blue','white','red'))(100)
# plot the difference
plot(difEN, col=cldif)
# red is january, blue is march
dev.off()

# build a RGB plot with the 3 images (jan, feb, march)
plotRGB(ENs, r=1, g=7, b=13, stretch="lin")
plotRGB(ENs, r=1, g=7, b=13, stretch="hist")
dev.off()

# the "source" function recall an external code from the present script
source("R_inputcode.r")
