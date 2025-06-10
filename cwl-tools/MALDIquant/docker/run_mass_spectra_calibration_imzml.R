#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(MALDIquant))
suppressPackageStartupMessages(library(MALDIquantForeign))
suppressPackageStartupMessages(library(xml2))

option_list <- list(
make_option(c("--input"), type="character", help="Input imzML file"),
make_option(c("--output"), type="character", default="calibrated_output.imzML", help="Output imzML file"),
make_option(c("--ref_mz"), type="character", help="Comma-separated reference m/z values for calibration")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

# Check if centroided dataset
is_centroided <- function(imzml_file) {
tryCatch({
doc <- read_xml(imzml_file)
cvParams <- xml_find_all(doc, "//*[local-name()='cvParam']")
names <- xml_attr(cvParams, "name")
accessions <- xml_attr(cvParams, "accession")
cat("Found", length(cvParams), "cvParam elements\n")
cat("Looking for MS:1000127 in accessions...\n")
result <- any(grepl("centroid", names, ignore.case = TRUE)) ||
any(accessions == "MS:1000127", na.rm = TRUE)
cat("Result:", result, "\n")
return(result)
 }, error = function(e) {
cat("Error:", e$message, "\n")
return(FALSE)
 })
}

centroid_flag <- is_centroided(opt$input)
cat("Centroided detected:", centroid_flag, "\n")

# import imzml format data
spectra <- importImzMl(opt$input, centroided = centroid_flag)

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
calibrated_mz <- detected_mz # if there are too few matching peaks, no correction is performded
 }
# generate calibrated spectra
calibrated_spec <- createMassSpectrum(mass=calibrated_mz, intensity=intensity(peaks))
calibrated_spectra[[i]] <- calibrated_spec
 } else {
calibrated_spectra[[i]] <- spec # if no peak is detected, the original spectrum is kept
 }
}

# save the calibrated file in imzml format
exportImzMl(calibrated_spectra, file=opt$output, coordinates=coords)