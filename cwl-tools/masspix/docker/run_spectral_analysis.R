#!/usr/bin/env Rscript
# spectral_analysis.R
# Performs deisotoping and annotation from .imzML input

library(massPix)
library(rJava)
source("masspix_config.R")

# Setup
home_dir <- getwd()
lib_dir <- file.path(home_dir, "libraries")
spectra_dir <- file.path(home_dir, "data")
imzMLparse <- file.path(home_dir, "imzMLConverter", "imzMLConverter.jar")

# Load libraries
setwd(lib_dir)
lookup_FA <- read.csv("lib_FA.csv")[, 2:4]
lookup_lipid_class <- read.csv("lib_class.csv")[, 2:3]
lookup_element <- read.csv("lib_element.csv")[, 2:3]
lookup_mod <- read.csv("lib_modification.csv")[, 2:ncol(read.csv("lib_modification.csv"))]

# Parse imzML file
setwd(spectra_dir)
files <- list.files(pattern = ".imzML$", full.names = TRUE)
.jinit()
.jaddClassPath(imzMLparse)
imzML <- J("imzMLConverter.ImzMLHandler")$parseimzML(files[1])
x.cood <- J(imzML, "getWidth")
y.cood <- J(imzML, "getHeight")

# Library
dbase <- makelibrary(ionisation_mode, sel.class, fixed, fixed_FA,
                     lookup_lipid_class, lookup_FA, lookup_element)

# Extract & deisotope
extracted <- mzextractor(files, spectra_dir, imzMLparse, thres.int, thres.low, thres.high)
peaks <- peakpicker.bin(extracted, bin.ppm)
temp.image <- subsetImage(extracted, peaks, percentage.deiso, thres.int, thres.low,
                          thres.high, files, spectra_dir, imzMLparse)
temp.image.filtered <- filter(imagedata.in=temp.image, steps, thres.filter, offset = 1)

deisotoped <- deisotope(ppm, no_isotopes, prop.1, prop.2,
                        peaks=list("",temp.image.filtered[,1]), image.sub=temp.image.filtered,
                        search.mod, mod, lookup_mod)

# Annotation
annotated <- annotate(ionisation_mode, deisotoped, adducts, ppm.annotate, dbase)

# Output
ids <- cbind(deisotoped[[2]][,1], annotated, deisotoped[[2]][,3:4])
write.csv(ids, "deisotoped.csv", row.names=FALSE)
