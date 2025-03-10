#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(MALDIquant))
suppressPackageStartupMessages(library(MALDIquantForeign))

option_list <- list(
  make_option(c("--input"), type="character", help="Input imzML file"),
  make_option(c("--output"), type="character", default="calibrated_output.imzML", help="Output imzML file"),
  make_option(c("--ref_mz"), type="character", help="Comma-separated reference m/z values for calibration")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

# import imzml format data
spectra <- importImzML(opt$input)

# resolve reference m/z values
reference_mz <- as.numeric(unlist(strsplit(opt$ref_mz, ",")))

# get coordinates info for all pixels
coords <- coordinates(spectra)

# performing mass calibration
calibrated_spectra <- list()
for (i in seq_along(spectra)) {
  spec <- spectra[[i]]
  
  # peak detection
  peaks <- detectPeaks(spec)
  
  if (length(mass(peaks)) > 0) {
    # identify peaks and match to the nearest reference m/z
    detected_mz <- mass(peaks)
    matched_mz <- sapply(detected_mz, function(m) reference_mz[which.min(abs(reference_mz - m))])

    # calculate nonlinear interpolation calibration
    if (length(matched_mz) > 3) {  
      loess_model <- loess(matched_mz ~ detected_mz, span=0.75)
      calibrated_mz <- predict(loess_model, newdata = data.frame(detected_mz = detected_mz))
    } else {
      calibrated_mz <- detected_mz  # if there are too few matching peaks, no correction is performded
    }

    # generate calibrated spectra
    calibrated_spec <- createMassSpectrum(mass=calibrated_mz, intensity=intensity(peaks))
    calibrated_spectra[[i]] <- calibrated_spec
  } else {
    calibrated_spectra[[i]] <- spec  # if no peak is detected, the original spectrum is kept
  }
}

# save the calibrated file in imzml format
exportImzML(calibrated_spectra, file=opt$output, coordinates=coords)
