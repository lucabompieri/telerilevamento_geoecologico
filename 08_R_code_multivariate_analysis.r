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
