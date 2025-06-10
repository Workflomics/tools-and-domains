#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(MALDIquant))
suppressPackageStartupMessages(library(MALDIquantForeign))
suppressPackageStartupMessages(library(xml2))

option_list <- list(
make_option(c("--input"), type="character", help="Input imzML file")
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