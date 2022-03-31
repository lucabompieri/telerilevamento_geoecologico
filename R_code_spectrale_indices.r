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
plot(dvl1992, col=cl)

# DVI Difference Vegetation Index 2006
dvi2006 = l2006[[1]] - l2006[[2]]
# dvi2006 = l2006[[4]] - l2006[[3]]
dvi2006
plot(dvi2006, col=cl)

# DVI Difference in time 1992 - 2006
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100)
dev.off()
plot(dvi_dif, col=cld)

