#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(MALDIquant))
suppressPackageStartupMessages(library(MALDIquantForeign))

option_list <- list(
  make_option(c("--input"), type="character", help="Input imzML file"),
  make_option(c("--target_mz"), type="double", help="Target m/z value for visualization"),
  make_option(c("--tolerance"), type="double", default=0.5, help="Tolerance range for target m/z (default 0.5)"),
  make_option(c("--output"), type="character", default="ion_image.png", help="Output PNG file for ion image")
)

opt_parser <- OptionParser(option_list=option_list)
opts <- parse_args(opt_parser)

# import imzML data
spectra <- importImzML(opts$input)
coordinates <- coordinates(spectra)

num_spectra <- length(spectra)
intensity_values <- numeric(num_spectra)

# loop over each spectrum and sum the intensities within the target m/z range
for (i in seq_along(spectra)) {
  spec <- spectra[[i]]
  mz_values <- mass(spec)
  intensities <- intensity(spec)
  indices <- which(mz_values >= (opts$target_mz - opts$tolerance) & mzValues <= (opts$target_mz + opts$tolerance))
  if (length(indices) > 0) {
    intensity_values[i] <- sum(intensities[indices])
  } else {
    intensity_values[i] <- 0
  }
}

# create a data frame with coordinates and intensity values
df <- data.frame(x = coordinates[,1], y = coordinates[,2], intensity = intensity_values)

# generate an image matrix based on unique x and y coordinates
uniqueX <- sort(unique(df$x))
uniqueY <- sort(unique(df$y))
image_matrix <- matrix(0, nrow = length(uniqueY), ncol = length(uniqueX))

for (j in 1:nrow(df)) {
  ix <- which(uniqueX == df$x[j])
  iy <- which(uniqueY == df$y[j])
  image_matrix[iy, ix] <- df$intensity[j]
}

# save the ion image as a PNG file
png(filename = opts$output, width = 800, height = 600)
image(uniqueX, uniqueY, t(image_matrix)[, length(uniqueY):1],
      col = heat.colors(256),
      xlab = "X Coordinate", ylab = "Y Coordinate",
      main = paste("Ion Image at m/z =", opts$target_mz, "±", opts$tolerance))
dev.off()
