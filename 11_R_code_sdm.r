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
