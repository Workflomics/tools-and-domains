#!/usr/bin/env Rscript
# feature_extraction.R
# Builds full image and outputs image.norm.csv

library(massPix)
source("masspix_config.R")

# Setup
home_dir <- getwd()
spectra_dir <- file.path(home_dir, "data")
files <- list.files(path=spectra_dir, pattern=".imzML$", full.names=TRUE)

# Construct full image
final.image <- constructImage(extracted, deisotoped, peaks, imzMLparse,
                              spectra_dir, thres.int, thres.low, thres.high, files)
image.ann <- cbind(ids, final.image[,2:ncol(final.image)])

# Normalize
image.norm <- normalise(imagedata.in=image.ann, norm.type, standards=NULL, offset=offset)
write.csv(image.norm, "image.norm.csv", row.names=FALSE)
