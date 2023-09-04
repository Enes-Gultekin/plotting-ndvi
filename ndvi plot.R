library(raster)
library(dplyr)
library(ggplot2)
#import coordinates: 850 points
coor = read.csv("coordinates.csv")
coor = as.data.frame(coor)
#create random ndvi values
ndvi = runif(850,min=0,max=0.7 )
ndvi =as.data.frame(ndvi)

#create a new dataframe with x and y coordinates
df=data.frame(coor$x,coor$y)
colnames(df)=c("x","y")
head(df)

#create an extent
ext=extent(min(df$x),min(df$y),max(df$x),max(df$y))

#create a new raster
new_raster=raster(ext,resolution=1)

#assign a coordinate system
crs(new_raster)=CRS(" +datum=ETRS89 ")

#create an ndvi raster
ndvi_raster=rasterize(df,new_raster,field=ndvi)

#plot the raster
plot(ndvi_raster,xlim=c(min(df$x),max(df$x)),
     ylim=c(min(df$y),max(df$y)),xlab="X",ylab="Y",main="NDVI",
     )

#make an output of NDVI map
writeRaster(ndvi_raster,overwrite=TRUE,filename = "NDVI_raster.tif",extent=min(df$x),min(df$y),max(df$x),max(df$y))
