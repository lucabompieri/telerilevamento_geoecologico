
> # primo script
> 
> #importaiamo packages
> install.packages("raster")

Caricamento del pacchetto richiesto: sp
Messaggi di avvertimento:
1: il pacchetto ‘raster’ è stato creato con R versione 4.1.3 
2: il pacchetto ‘sp’ è stato creato con R versione 4.1.2 
> 
> #settiamo cartella di lavoro:
> setwd("C:/lab") # per windows
> 
> #imporiamo file grd
> l2011 <- brick ("p224r63_2011.grd")
> l2011
class      : RasterBrick 
dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
resolution : 30, 30  (x, y)
extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
source     : p224r63_2011.grd 
names      :      B1_sre,      B2_sre,      B3_sre,      B4_sre,      B5_sre,       B6_bt,      B7_sre 
min values :         0.0,         0.0,         0.0,         0.0,         0.0,       295.1,         0.0 
max values :   1.0000000,   0.2563655,   0.2591587,   0.5592193,   0.4894984, 305.2000000,   0.3692634 

> #plottiamo il dato appena importato
> plot(l2011)
> # https://r-graph-gallery.com/
> # impostiamo un nuovo colore al dato plottato
> cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
> #100 valore di gradazione del colore
> > plot(l2011,col=cl)
> # dev.off()
