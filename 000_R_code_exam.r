# Hi everyone!
# this is the code i prepared for my exam, let's see it!

# this code will focus to the loss of snow of the Okjokull gòacier, in Iceland
# the pictures used have been downloaded from: https://earthobservatory.nasa.gov/images/145439/okjokull-remembered

# the code will show the following ponits:
# 1. pca calculation (principal component analysis
# 2. loss of snow cover calculation
# 3. standard deviation calculation to show the most changed points

# LET'S BEGIN!

# first of all need to download and call the packages that we need later
# install.packages ("raster")
library (raster)
# install.packages ("rasterVis")
library (rasterVis)
# install.packages ("RStoolbox") # to calcolate PCA
library (RStoolbox)
# install.packages ("ggplot2") # to plot with ggplot
library (ggplot2)
# install.packages ("gridExtra") # to plot the ggplots together
library (gridExtra)
# install.packages ("viridis") # to color the ggplots
library (viridis)

# now, one of the most important things, set the working directory!
setwd ("C:/lab/prova")

# now finaly we can call our objects, for this code we need two images of two different year, in this case 1986 - 2019
# assign to those images a name, so it's easier to call them
okjokull_1986 <- brick("okjokull_tm5_1986257_lrg.jpg")
okjokull_2019 <- brick("okjokull_oli_2019213_lrg.jpg")

# call them to see the imformation inside

okjokull_1986
# class      : RasterBrick 
# dimensions : 1974, 2182, 4307268, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 2182, 0, 1974  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : okjokull_tm5_1986257_lrg.jpg 
# names      : okjokull_tm5_1986257_lrg.1, okjokull_tm5_1986257_lrg.2, okjokull_tm5_1986257_lrg.3 
# min values :                          0,                          0,                          0 
# max values :                        255,                        255,                        255 

okjokull_2019
# class      : RasterBrick 
# dimensions : 1974, 2182, 4307268, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 2182, 0, 1974  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : okjokull_oli_2019213_lrg.jpg 
# names      : okjokull_oli_2019213_lrg.1, okjokull_oli_2019213_lrg.2, okjokull_oli_2019213_lrg.3 
# min values :                          0,                          0,                          0 
# max values :                        255,                        255,                        255 

# plot the 2 images to see the 3 bands 
plot (okjokull_1986)
plot (okjokull_2019)

# now to see the images with real color need to use "ggplot2" and "gridExtra" packages functions
# function "ggRGB" calcolate the composite raster, following the bands order "red, green, blue", using a linear stretch
p1 <- ggRGB(okjokull_1986,r=1,g=2,b=3, stretch="lin")
p2 <- ggRGB(okjokull_2019,r=1,g=2,b=3, stretch="lin")

# function "grid.arrange"  combine the two plots
grid.arrange (p1,p2,nrow=1,ncol=2)


# 1. PCA CALCULATION
# to calcolate the pca use function "rasterPCA" of "RStoolbox" package
# the programm will analyse the raster's pca and return some values
pca1986 <- rasterPCA (okjokull_1986)
plot (pca1986$map) # pca graphic visual
summary (pca1986$model)
# Importance of components:
#                             Comp.1      Comp.2       Comp.3
# Standard deviation     122.7108850 19.69613913 12.247487767
# Proportion of Variance   0.9655077  0.02487435  0.009617974
# Cumulative Proportion    0.9655077  0.99038203  1.000000000
#  - THE 79 % OF VARIANCE IS EXPALINED FROM THE FIRST COMPONENT -

# now the second picture
pca2019 <- rasterPCA (okjokull_2019)
plot (pca2019$map) # pca graphic visual
summary (pca2019$model)
# Importance of components:
#                            Comp.1      Comp.2      Comp.3
# Standard deviation     78.9975387 12.72125301 7.616503808
# Proportion of Variance  0.9659712  0.02504937 0.008979422
# Cumulative Proportion   0.9659712  0.99102058 1.000000000
#  - THE 84 % OF VARIANCE IS EXPALINED FROM THE FIRST COMPONENT -


# 2. LOSS OF SNOW
# assign a name to the 1986 picture first component
b1_1986 <- okjokull_1986$okjokull_tm5_1986257_lrg.1
# assign a name to the 2019 picture first component
b1_2019 <- okjokull_2019$okjokull_oli_2019213_lrg.1

# calcolate the difference between the 2 components
diff <- b1_1986 - b1_2019
# build a new color palette to improve the visualization
cl <- colorRampPalette(c("yellow","red","blue"))(200)
# plot the difference just calcolated
plot(diff, col=cl, main = "perdità manto nevoso")


# 3. STANDARD DEVIATION CALCULATION
# the function to use for this is "focal", compute the focal values for the adjacent focal cells using a matrix
# set the matrix size, in this case a matrix with 5 rows and 5 columns
# set the function too, in this case "sd" for standard deviation
devst <- focal(diff, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
# build a new color palette to improve the visualization
cld <- colorRampPalette(c("blue","green","yellow","magenta"))(100)
# plot it!
plot(devst, col=cld, main="deviazione standard")
