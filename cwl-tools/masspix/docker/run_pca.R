#!/usr/bin/env Rscript
# pca_analysis.R
# Performs PCA on image.norm.csv

library(massPix)
source("masspix_config.R")

image.norm <- read.csv("image.norm.csv")
image.scale <- centreScale(imagedata.in = image.norm, scale.type, transform, offset)
imagePca(imagedata.in = image.scale, offset=offset, PCnum, scale, x.cood, y.cood,
         nlevels, res.spatial, summary, title, rem.outliers)

# Save PCA plot
png("PCA_plot.png")
imagePca(imagedata.in = image.scale, offset=offset, PCnum, scale, x.cood, y.cood,
         nlevels, res.spatial, summary, title, rem.outliers)
dev.off()

# Save loadings
pca <- princomp(t(image.scale[,(offset+1):ncol(image.scale)]), cor=FALSE)
labs.all <- as.numeric(as.vector(image.scale[,1]))
for (i in 1:PCnum){
  loadings <- cbind(pca$loadings[,i], labs.all)
  write.csv(loadings, paste0("loadings_PC",i,".csv"), row.names=FALSE)
}
