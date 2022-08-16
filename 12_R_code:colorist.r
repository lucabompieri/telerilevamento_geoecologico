# this is the 11th script
# R_code_colorist.r

# upload "colorist" package
library(colorist)
# upload "ggplot2" package
library(ggplot2)

# use "data" function to read the system
data("fiespa_occ")

met1 <- metrics_pull(fiespa_occ)

# new palette trough the function "palette_timecycle"
pal<- palette_timecycle(fiespa_occ)

# build a multiple map
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

# extract a single map
map_single(met1, pal, layer = 6)

# handle the maps changing the colors
p1_custom <- palette_timecycle(12, start_hue = 60)
map_multiples(met1, p1_custom, ncol = 4, labels = names(fiespa_occ))

# Metrica
met1_distill <- metrics_distill(fiespa_occ) # we can distill the information
map_single(met1_distill, pal)
map_single(met1_distill, p1_custom)
# the most colored parts have much specifity (the specie exist in summer/utumn....)
# the grey parts are not so specific: can ben find during evry period of the year

# legend
legend_timecycle(pal, origin_label = "1 jan")

# upload new data a see it
data("fisher_ud")
fisher_ud

# buil the metric and visualize it
m2 <- metrics_pull(fisher_ud)
m2

# new time's palette non linear and visualize it
pal2 <- palette_timeline(fisher_ud)
head(pal2)

# build a multiple map
map_multiples(m2, pal2, ncol = 3, labels = names(fisher_ud))
map_multiples(m2, pal2, ncol = 3, lambda_i = -12, labels = names(fisher_ud))

# do the metric and extract a single map
m2_distill<-metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -10)

# build a new legend
legend_timeline(pal2)
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
