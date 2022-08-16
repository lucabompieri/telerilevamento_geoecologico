# first work in r (for windows)
# install raster packages
# install.packages("raster")
library(raster)

# get the working directory (wd)
setwd("C:/lab/")

# import .grd data end name it l2011
l2011 <- brick("p224r63_2011.grd") 
# we use this "" for work/data out of r
l2011 
# we see which data there are inside the file

# plot the data
plot(l2011)

# change the color of the just imported map
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) # 100 is for the number of graduation
plot(l2011, col=cl) # plot with the new colors

# dev.off() = close window

# Landsat ETM+
# b1 = blue
# b2 = green
# b3 = red
# b4 = infrarosso vicino NIR

# Plot blue B1_sre
plot (l2011$B1_sre)
# our, another type of plot, we give indication of the number of colore, in this case 1 for blue
plot (l2011[[1]])

# change color to grey of l2011$B1_sre
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl)

# plot B1 form dark blue to blue to lught blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

# export the image in pdf with "pdf" function
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off() # close the function pdf

# export the image in pgn with "png" function
png("banda1.png")
plot(l2011$B1_sre, col=clb)
dev.off() # close the function png

# plot B2 from dark green to green to light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

# multiframe image (mf) [right - left]
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

#export multiframe plot
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# revert the multiframe [top - bottom]
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# plot 4 multiframe
# set the other two color palette
clr <- colorRampPalette(c("violet", "red", "pink")) (100)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
par(mfrow=c(2,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)
dev.off()

# plot RGB palette
# overalay red, green and blue layers
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
# use NIR layer (for infrared resolution)
# add 1 to all layers, infrared in red. 
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# change the combination of value-color, map will be florescent
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# focus on soil, nir in the blue layer
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

# build a multiframe 
# on top RGB palette map (linear stretch)
# on bottom NIR layer added to RGB palette (histogram streatch)
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# upload the map-image from 1988
l1988 <- brick("p224r63_1988.grd")
# call object to check information inside
l1988
# Plot hte map "l1988"
plot(l1988)

# build a multiframe 
# on top 1988 map (linear stretch)
# on bottom 2011 map (linear stretch)
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

#---------------------------------------------------------------

library (raster)
# set the raster package
setwd("C:/lab")
# working directory setting for Windows
# in this case, the folder is located in "C"

# Exercise_1: import the first file -> defor1_.jpg -> nominate it "l1992"
l1992 <- brick("defor1_.jpg")
l1992 
# to see which information are inside the object
# l1992 <- brick("p224r63_1988.grd")
# plot the 1992's image with RGB color palette
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
# plot the 1992's image with RGB + NIR color palette
# plotRGB(l1992, r=4, g=3, b=2, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green
 
# Exercise_2: import the second file -> defor2_.jpg -> nominate it "l2006"
l2006 <- brick("defor2_.jpg")
l2006
# to see which information are inside the object
# l2006 <- brick("p224r63_2011.grd")
# plot the 2006's image with RGB color palette
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")
# plot the 2006's image with RGB + NIR color palette
# plotRGB(l2006, r=4, g=3, b=2, stretch="lin")


# Exercise_3: plot in a multiframe the 2 images.
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index 1992
dvi1992 = l1992[[1]] - l1992[[2]]
# dvi1992 = l1992[[4]] - l1992[[3]]
dvi1992
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black'))(100)
# specifyng the color scheme
plot(dvi1992, col=cl)

# DVI Difference Vegetation Index 2006
dvi2006 = l2006[[1]] - l2006[[2]]
# dvi2006 = l2006[[4]] - l2006[[3]]
dvi2006
plot(dvi2006, col=cl)

# DVI Difference in time 1992 - 2006
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100)
dev.off()
plot(dvi_dif, col=cld, main="Difference between 1992's and 2006's dvi")

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1
# NDVI  can be use with images too.

#-------------------------------------------

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
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst-2015.tif")

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
cl <- colorRampPalette(c('blue','light blue','pink','red'))(100)
par(mfrow=c(2,2))
plot(lst_2000, col=cl)
plot(lst_2005, col=cl)
plot(lst_2010, col=cl)
plot(lst_2015, col=cl)
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

#----------------------------------------------

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

#--------------------------------------------------------

# 5th script
# R_code_classification.r

# upload the "raster" package
library(raster)
# upload the "RStollbox" package
library(RStollbox)

# set the working directory
setwd("C:/lab/")

# use the "brick" function to import the image and assign in to an object
# use this function because the image is a RGB
SO <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# call the object to see the information
SO

# RGB image -> RGB plot 
# use linear and histogram stretch
plotRGB(SO, 1, 2, 3, stretch="lin")
plotRGB(SO, 1, 2, 3, stretch="hist")
dev.off()

# classify the image for the pixels layout 
# to make it, "unsuperClass" function indicating the classes number
SOc <- sunuperClass(SO, nClasses=3)
# call the object to see the information inside it
SOc
# plot the classify image adding it to the map created during the classification
# build a new color palette to improve the visual
cl <-(colorRampPalette(c('yellow','black','red'))(1009
plot(SOc$map, col=cl)
dev.off()

# import a new image.
# use the "brick" function to import the image and assign in to an object
# use this function because the image is a RGB
GC <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
# call the object to see the info
GC

# being a RGB image plot a RGB plot
plotRGB(GC, 1, 2, 3, stretch="lin")
plotRGB(GC, 1, 2, 3, stretch="hist")
dev.off()

# classify the image for the pixels layout 
# to make it, "unsuperClass" function indicating the classes number
GCc2 <- unsuperClass(GC, nClasses=2)
# call th object to see the infos
GCc2
# plot the classiflied image created during the classification
plot(GCc2$map)
dev.off()

# new classification increasing the the class number
# to keep the same classes everytime use "set.seed()" function
set.seed(1)
GCc4 <- unsuperClass(GC, nClasses=4)
# call the object to see the infos
GCc4
# plot the classify image adding it to the map created during the classification
# build a new color palette to improve the visual
cl2 <-(colorRampPalette(c('yellow','black','red'))(1009
plot(GCc4$map, col=cl2)
dev.off()

# compare the classified image with the original
par(mfrow=c(2,1))
plot(GCc4, col=cl12)
plotRGB(GC, 1, 2, 3, stretch="hist")
dev.off()

#---------------------------------------------------------------

# this is the 6th code
# R_code_land_cover.r

# upload "raster" package
library(raster)
# upload "RStoolbox" package
library(RStoolbox)
# download the "ggplot2" raster
install.packages ("ggplot2")
# upload the package
library(ggplot2)
# upload "gridExtra" package
install.packages ("gridExra")
library(gridExtra)
# upload "patchnetwork" package
install.packages ("patchwork")
library(patchwork)

# set the working directory
setwd("C:/lab/")

# function "brick" to upload an RGB image
L92 <- brick("defor1_.jpg")
# call the object to see the information
L92

# plot the object lin-hist RGB plot
plotRGB(L92, 1, 2, 3, stretch="lin")
plotRGB(L92, 1, 2, 3, stretch="hist")
dev.off()

# ulpoad the second RGB image
L06 <- brick("defor2_.jpg")
L06

# plot the 2 images in the same window
par(mfrow=c(2,1))
plotRGB(L92, 1, 2, 3, stretch="lin")
plotRGB(L06, 1, 2, 3, stretch="lin")
dev.off()

# build a RGB plot with the "ggplot2" function
ggRGB(L92, 1, 2, 3, stretch="lin")
ggRGB(L06, 1, 2, 3, stretch="lin")
dev.off()

# build a multiframe using "ggplot2" and "patchnetwork" packages
p1 <- ggRGB(L92, 1, 2, 3, stretch="lin")
p2 <- ggRGB(L06, 1, 2, 3, stretch="lin")
# view the image on the same raw
p1+p2
dev.off()
# view the images on the same column
p1/p2
dev.off()

# classify L92 for pixel layout, to do it "unsuperClass"
L92c <- unsuperClass(L92, nClasses=2)
L92c

# plot the classified image and build a new color palette to improve the visual
cl <- colorRampPalette(c("yellow","red"))(100)
plot(L92c$map, col=cl)
dev.off()
# class 1 is for the wood, class 2 for water

# classify the second image "L06"
L06c <- unsuperClass(L06, nClasses=2)
L06c

plot(L06c$map, col=cl)
dev.off()

# frequency of the 2 classes pixels
freq(L92c$map)

# Pixel totali
tot92 <- 307202+34090
tot92
# proportion between forest and acricolture
prop_forest92 <- 307202/tot92
prop_forest92
# forest rate
perc_forest92 <- 307202*100/tot92
perc_forest92
# percentuale foreste = 90.01
# agricolture rate
perc_agr92- 34090*100/tot92
perc_agr92
# percentuale agricoltura = 9.99

# frequency for 06 data
freq(L06c$map)
# pixel totali
tot06 <- 179331+163395
tot06
# hood rate
perc_forest06 <- 179331*100/tot06
perc_forest06
# percentuale foreste = 52.33
# agricolture rate
perc_agr06 <- 163395*100/tot06
perc_agr06
# percentuale agricoltura = 47.67

# build a data frame with three columns 
# first one will be the class, second trappresent the forest data, and the third is for the agricolture value from 1992 and 2006
class <- c("Forest","Agricolture")
percent_1992 <- c(90.01, 9.99)
percent_2006 <- c(52.33, 47.67)
multitemporal <- data.frame(class, percent_1992, percent_2006)
multitemporal

# plot the data frame building a histogram image
PL1 <- ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) + geom_bar(stat="identity", fill="black")
PL2 <- ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) + geom_bar(stat="identity", fill="white")
grid.arrange(PL1, PL2, nrow=1)

# save the file as pdf in the working directory
pdf("data_frame06")
grid.arrange(PL1, PL2, nrow=1)
dev.off()

#------------------------------------------------

# this is the 7th script
# R_code_variability.r

# upload "raster" package
library(raster)
# upload "ggplo2"
library(ggplot2)
# upload "patchwork"
library(patchwork)
# install "viridis" package
install.package("viridis")
library(viridis)

# set working directory
setwd("C:/lab/")

# use the function brick to import the RGB image
sen <- brick("sentinel.png")
sen

# plot the image with the function "ggRGB"
ggRGB(sen, 1, 2, 3, stretch="lin")
# this function put stretch = lin  in auto
ggRGB(sen, 1, 2, 3)
dev.off()
ggRGB(sen, 2, 1, 3)

g1 <- ggRGB(sen, 1, 2, 3)
g2 <, ggRGB(sen, 2, 1, 3)
g1+g2

# calculate the variability oth the image
# calculate it on NIR, the first element
nir <- sen[[1]]
# to make the calc, use the function "focal" on a 3*3 pixel window
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)

# plot the variability image with an appropriate Color Palette
clsd <- colorRampPalette(c("blue","green","pink","magenta","orange","brown","red","yellow"))(100)
plot(sd3, col=clsd)
dev.off()

# plot with "ggplot" function
# open an empty plot and add to it the function "geom_raster"
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))

# # From now the plot will be reloaded 3 times, with the 3 different legends extracted from the "viridis" package.

# build a plot with v viridis legend
# open an empty ggplot and add the "geom_raster" function
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# build a plot with cividis legend
# open an empty ggplot and add the "geom_raster" function
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# build a plot with magma legend
# open an empty ggplot and add the "geom_raster" function
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# Calcolate the variability with the "focal" function using a 7*7 window
# Calcolate in NIR (first element)
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd) # function based on deviation standard

# plot the variability image using a new color palette
plot(sd7, col=clsd)
dev.off()

#-----------------------------------------------------------

# This is the 8th code
# R_code_multivariate_analysis.r

# upload raster package
library(raster)
# uplaod RStoolbox pavkage
library(RStoolbox)
# upload ggplot2 package
library(ggplot2) # for ggplot plotting
# upload patchnetwork package
library(patchwork) # multiframe with ggplot2 graphs

# set the working directory
setwd("C:/lab/") 

# use the brick function to import a RGB image
I11 <- brick("p224r63_2011_masked.grd")
I11

# plot it!
plot(I11)

# befor beginning multivariate analysis to resampling the image
# to do it use aggregate
I11res <- aggregate(I11, fact=10)

# being RGB images, plot them using ggRGB function and one over the other
g1 <- ggRGB(I11, 4, 3, 2)
g2 <- ggRGB(I11res, 4, 3, 2)
g1/g2 # Thanks to patchwork!

# new resampling, more aggressive
I11res2 <- aggregate(I11, fact=100)

# new plot withe the 3 imgaes in column
g1 <- ggRGB(I11, 4, 3, 2)
g2 <- ggRGB(I11res, 4, 3, 2)
g3 <- ggRGB(I11res2, 4, 3, 2)
g1/g2/g3

# PCA analysis
# PCA on the object just resampled
# to do it use rasterPCA function and assign to an object
I11respca <- rasterPCA(I11res)

# summary's object using summary function
summary(I11respca$model)

# PCA's plot
plot(I11respca$map)

# a series of ggplot using two PCA's different elements from the rasampled image

g4 <- ggplot()+
geom_raster(I11respca$map, mapping =aes(x=x, y=y, fill=PC1))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g5 <-ggplot()+
geom_raster(I11respca$map, mapping =aes(x=x, y=y, fill=PC7))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

g4+g5

g6 <-ggplot()+
geom_raster(I11res, mapping =aes(x=x, y=y, fill=B4_sre))+
scale_fill_viridis(option = "inferno") +
ggtitle("NIR")

g4+g6

g7 <- ggRGB(I11res, 2, 3, 4, stretch="hist")

g4+g7

# Build two different RGB plot of 3 PCA's layers
plotRGB(I11respca$map, 1, 2, 3, stretch="lin")
plotRGB(I11respca$map, 5, 6, 7, stretch="lin")

#---------------------------------------------------------------------------

# this is the 9th script
# R_code_variability2.r

# upload "raster" package
library(raster)
# upload "RStoolbox" package
library(RStoolbox)
# upload "ggplot2" package
library(ggplot2)
# upload "patchwork" package
library(patchwork) 
# upload "viridis" package
library(viridis)

# set the working directory
setwd("C:/lab/") 

# use function "brick" to import an RGB image
sen <- brick("sentinel.png")
sen
# band1 = NIR
# band2 = red
# band3 = green

# plot the image with ggRGB 
# can avoid the "stretch" function, it is automaticaly
ggRGB(sen, 1, 2, 3)
dev.off()
# NIR as green component
ggRGB(sen, 2, 1, 3)

# multivariate analysis
sen_pca <- rasterPCA(sen)
# call it to see the infos
sen_pca

# PCA's summery
summary(sen_pca$model)

# plot the PCA
plot(sen_pca$map)

# arrange the images for the plot
pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

# ggplot of PC1
# open an empty ggplot and add the "geom_raster" function
g1 <- ggplot() + 
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

# ggplot of PC2
# open an empty ggplot and add the "geom_raster" function
g2 <- ggplot() + 
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

# ggplot of PC3
# open an empty ggplot and add the "geom_raster" function
g3 <- ggplot() + 
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))

# in the same window the 3 images, thanks to "patchwork" package
g1+g2+g3

# PC1 variability
# to calcolate it use a 3*3 window and the "focal" function
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) # la funzione è basata sulla deviazione standard

# ggplot of PC1 with the viridis legend
# open a ggplot and add to it the "geom_raster" function
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()

# ggplot of PC1 with the cividis legend
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis")

# ggplot of PC1 with the inferno legend
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")

# plot, usign patchwork, of the 3 image analysis's phases
im1 <- ggRGB(sen, 2, 1, 3)
im2 <- ggplot() + 
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
im3 <- ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im1 + im2 + im3

# variability of PC1
# to calcolate it use a 5*5 window and the "focal" function
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd) # function based on standard deviation

# ggplot of PC1 with the inferno legend
im4 <- ggplot() + 
geom_raster(sd5, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im4

# plot, using patchwork, of the 3*3 and 5*5 image
im3 + im4

# variability of PC1
# to calcolate it use a 7*7 window and the "focal" function
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd) # function based on standard deviation

# ggplot of PC1 with the inferno legend
im5 <- ggplot() + 
geom_raster(sd7, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im5

# plot, using patchwork, of the 3 image (3*3, 5*5, 7*7)
im3 + im4 + im5

#--------------------------------------------------------------------

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

#------------------------------------------

# this is the 11th script
# R_code_sdm.r

# istall "sdm" package
# install.packages("sdm")

# upload "sdm" package
library(sdm)
# upload "raster" package
library(raster) # predictors
# upload "rgdal" package
library(rgdal) # species

# In questo caso non faccio il settaggio della working directory perché useremo un file di sistema
# no working directory set because going to use a system file
# "system.file" to read the system
file <- system.file("external/species.shp", package="sdm") 
# call the object
file
# Utilizzo la funzione "shapefile" per creare uno shapefile
# "shapefile" fucntion to create a shapefile
species <- shapefile(file)
# call the object
species

# species plot
plot(species, pch=19)

# assign the species's occurence to an object and call it
occ <- species$Occurrence
occ

# shoew only poitns where the occcurance is equal to 1
plot(species[occ == 1,],col='blue',pch=19)
# add some points to the graphic trough "points" function
points(species[occ == 0,],col='red',pch=19)

# use "path" function to upload the predictors files
path <- system.file("external", package="sdm")
# list of this predictors
lst <- list.files(path=path,pattern='asc$',full.names = T)
# see the list
lst

# list stack
preds <- stack(lst)
# see the stack
preds 

# predictors plot
# buil a new colorpalette to improve the visual
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# assign shorter names to the predictors
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

# plot for every predictors overlying the stack
plot(elev, col=cl)
points(species[occ == 1,], pch=19)

plot(prec, col=cl)
points(species[occ == 1,], pch=19)

plot(temp, col=cl)
points(species[occ == 1,], pch=19)

plot(vege, col=cl)
points(species[occ == 1,], pch=19)

# begin to build my model

# use "sdmData" to declare the data
datasdm <- sdmData(train=species, predictors=preds)
# call it
datasdm

# use "sdm" fucntion
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# call it
m1

# Utilizzo la funzione "predict" per fare la previosione della mappa finale
# use "predict" function to  forecast the final map
p1 <- predict(m1, newdata=preds) 
# call the object
p1

# Faccio il plot di questa previsione aggiungendo anche i punti della distribuzione della specie
# plot the forecast adding to it the distribution's points from the species
plot(p1, col=cl)
points(species[occ == 1,], pch=19)

# stack of the previous stack and oft prevision
s1 <- stack(preds,p1)

# new stack plot
plot(s1, col=cl)

# want to change the stacks plot names
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')

# replotting the last stack
plot(s1, col=cl)

# otherwise  can make a "par" with 5 different images
par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(vege, col=cl)

#-----------------------------------------------

# this is the 11th script
# R_code_colorist.r

# upload "colorist" package
library(colorist)
# upload "ggplot2" package
library(ggplot2)

# use "data" function to read the system
data("fiespa_occ")

met1 <- metrics_pull(fiespa_occ)

# new palette trough the function "palette_timecycle"
pal<- palette_timecycle(fiespa_occ)

# build a multiple map
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

# extract a single map
map_single(met1, pal, layer = 6)

# handle the maps changing the colors
p1_custom <- palette_timecycle(12, start_hue = 60)
map_multiples(met1, p1_custom, ncol = 4, labels = names(fiespa_occ))

# Metrica
met1_distill <- metrics_distill(fiespa_occ) # we can distill the information
map_single(met1_distill, pal)
map_single(met1_distill, p1_custom)
# the most colored parts have much specifity (the specie exist in summer/utumn....)
# the grey parts are not so specific: can ben find during evry period of the year

# legend
legend_timecycle(pal, origin_label = "1 jan")

# upload new data a see it
data("fisher_ud")
fisher_ud

# buil the metric and visualize it
m2 <- metrics_pull(fisher_ud)
m2

# new time's palette non linear and visualize it
pal2 <- palette_timeline(fisher_ud)
head(pal2)

# build a multiple map
map_multiples(m2, pal2, ncol = 3, labels = names(fisher_ud))
map_multiples(m2, pal2, ncol = 3, lambda_i = -12, labels = names(fisher_ud))

# do the metric and extract a single map
m2_distill<-metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -10)

# build a new legend
legend_timeline(pal2)
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About

#------------------------------------------------------------

# this is the 13th script
# R_code_functions.r

library(raster)
# set the working directory
setwd("C:/lab/") # Windows

# do a series of function

# function 1
# build a function, once called, greet the inserted name
cheer_me <- function(your_name) {
cheer_string <- paste("Hello", your_name, sep = " ")
print(cheer_string)
}   

cheer_me("luca")

# function2 
# Creo una funzione che, una volta chiamata, "saluta" il nome inserito n volte, dove "n" lo scelgo io
# build a function, once called, greet the inserted name, but "n" will be set by the user
cheer_me_n_times <- function(your_name, n) {
cheer_string <- paste("Hello", your_name, sep = " ")

for(i in seq(1, n)) {
print(cheer_string)
}
}

cheer_me_n_times("luca", 5)


# fucntion 3
# build a function, where a called image from the working directory, can decide to plot it with a new palette or leave the one default 
dato <- raster("sentinel.png")

plot(dato)

plot_raster <- function(r, col = NA){
if(!is.na(col)) {
pal <- colorRampPalette(col) (100)
plot(r, col = pal)
} else {
plot(r)
}

}

plot_raster(dato, c("brown", "yellow", "green"))
plot_raster(dato)
