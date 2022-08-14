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
install.packages ("patchnetwork")
library(patchnetwork)
# library (network)

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
plotRGB(L06, 1, 2, 3, strecth="lin")
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
cl <- coloRampPalette(c('yellow','red'))(100)
plot(L92c$map, col=cl)
dev.off()
# class 1 is for the wood, class 2 for water

# classify the second image "L06"
L06c <- unsuperClass(L06, nClasses=2)
L06c

plot(L06c$map, col=cl)
dev.off()

# frequency of the 2 classes pixels
freq(L9c$map)

# Pixel totali
tot92 <- 307202+34090
tot92
# proportion between forest and acricolture
prop_forest92 <- 307202/tot92
prop_forest92
# forest rate
perc_forest92 <- 307202*100/tot92
perc_forest92
# percentuale = 90.011
# agricolture rate
perc_agr92- 34090*100/tot92
perc_agr92
# percentuale = 9.988



