
#------------------------------------------------------------------------#
# TITLE:        crime_index_calc.R
#
#
# AUTHOR:       Erich Seamon
#
# INSTITUITON:  College of Natural Resources
#               University of Idaho
#
# DATE:         August 2015
#
# STAGE:        crime_index_calc.R
#
# COMMENTS:     this script calculates a crime index for each sample from
# the provided dataset.  The input dataset in an output from an ArcGIS model that 
# organizes crime data 1000 feet from a set of participant observations.
#                
#
#--Setting the working directory an d clearing the workspace-----------

library(foreign)
library(plyr)

#--read in the file

x <- read.dbf("/nethome/erichs/go1_addresses_Seattle_out3.dbf")

#--convert to a data frame
x <- data.frame(x)

#--create the sum of distrank for all values within OBJECTID_1 that are the same.
#--this total goes into the crime index calculation

x2 <- ddply(x, .(OBJECTID_1), summarise, X2=sum(distrank))

x_oneeach <- x[order(-x$FREQUENCY),]
#x_oneeach2 <- x[order(-x$IN_FID),]
x_oneeach_agg <- aggregate(x_oneeach,by=list(key=x_oneeach$OBJECTID_1),FUN=function(OBJECTID_1){OBJECTID_1[1]})
xfreq <- data.frame(x_oneeach_agg$FREQUENCY)

xfinal <- cbind(x2$OBJECTID_1,x2$X2,xfreq$x_oneeach_agg.FREQUENCY)
colnames(xfinal) <- c("OBJECTID_1", "NEAR_DIST", "FREQUENCY")



x_freq <- data.frame(x$FREQUENCY)
x_freq_unique <- unique(x$OBJECTID_1)




obs <- c(1:122)
indexmatrix <- matrix(NA, nrow = 122, ncol = 1)

for (i in obs) {
  
  apply(x, i, sum)
  crimes <- sum(x$OBJECTID_1==i)
  for (j in crimes) {
  x[i,4] * x[i,36]
}
  indexmatrix[i,] <- (x[i,4] * x[i,36])/x[i,12]
}


