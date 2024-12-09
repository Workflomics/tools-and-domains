#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(MALDIquant))
suppressPackageStartupMessages(library(MALDIquantForeign))

option_list <- list(
  make_option(c("--input"), type="character", help="Input imzML file")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

# import imzml format data
spectra <- importImzML(opt$input)

# get coordinates info for all pixels
coords <- coordinates(spectra)

results <- data.frame(x = numeric(0), y = numeric(0), peak_mass = numeric(0), peak_intensity = numeric(0))

for (i in seq_along(spectra)) {
  spec <- spectra[[i]]
  # peak detection
  peaks <- detectPeaks(spec)
  
  # get m/z and intensity info
  if (length(mass(peaks)) > 0) {
    pixel_x <- coords[i,1]
    pixel_y <- coords[i,2]
    temp_df <- data.frame(
      x = rep(pixel_x, length(mass(peaks))),
      y = rep(pixel_y, length(mass(peaks))),
      peak_mass = mass(peaks),
      peak_intensity = intensity(peaks)
    )
    results <- rbind(results, temp_df)
  }
}

# write the result in csv format
write.csv(results, file="peak_detection_results.csv", row.names=FALSE)
