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

# Calcolo la variabilità dell'immagine attraverso la funzione focal ed utilizzo una finestra 7x7
# Calcolate in NIR (first element)
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd) # function based on deviation standard

# plot the variability image using a new color palette
plot(sd7, col=clsd)
dev.off()



