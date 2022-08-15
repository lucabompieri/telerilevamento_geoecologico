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
