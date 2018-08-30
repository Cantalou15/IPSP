#"R" Code for the Interpolated Penetrometr Soil Profile
#Under GNU-gpl 3 Licence
#Original code by Olivier SUC - Chambre d'agriculture de la Somme - France

#Set the workspace
setwd("Path/to/the/workspace")

#Here set the name of the CSV file to treat
fichier<-"file.csv"

#Store the name of the file to use it as a title
titre<-substr(fichier,1,nchar(fichier)-4)

#Import the data
P1<- read.csv2(fichier)

#Load the "akima" library for interpolation
library(akima)

#Interpolation (non-linear) of the data every 0.125m width and 0.5cm depth
#Y values are inverted (*-1)
P1.interp<-interp(x=P1$x, y=-1*(P1$y), z=P1$Mesure, xo=seq(1,12,by=0.125), yo=seq(-80,0, by=0.5), linear =FALSE, extrap=TRUE, duplicate = "median", dupfun = NULL)

#Creation of the color ramp
mycol<-colorRampPalette(c("Blue", "green","yellow","red"))

#Set the size of graph window (inches)
X11(12,7)

#Heatmap graph an labels
image (P1.interp, col= mycol(200),xlab= "ID of the measure on the width", ylab = "depth in cm", main = paste("Interpolated Penetrometric Soil Profile (IPSP) in MPa"," - ",titre))

#contour
contour(P1.interp, add = TRUE, col = "white", lwd = 1, labcex = 1)

#Export the graph in the workspace
savePlot(filename = titre,type = c("jpeg"),device = dev.cur(),restoreConsole = TRUE)

#Other graph to test (uncomment"#")
#filled.contour(P1.interp,xlab= "width in m", ylab = "depth in cm", main = paste("Interpolated Penetrometric Soil Profile (IPSP) in MPa"," - ",titre), col = mycol(30))

