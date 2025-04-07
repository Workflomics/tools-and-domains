#!/usr/bin/env Rscript
# clustering_analysis.R
# Performs clustering on image.norm.csv

library(massPix)
source("masspix_config.R")

image.norm <- read.csv("image.norm.csv")

# Save clustering plot
png("cluster_plot.png")
cluster(cluster.type, imagedata.in=image.norm, offset, width=x.cood,
        res.spatial, height=y.cood, clusters)
dev.off()
