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
