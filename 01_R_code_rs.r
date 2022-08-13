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

https://we.tl/t-XywrBNg13C
