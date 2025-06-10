#!/usr/bin/env Rscript
# Load required libraries
required_packages <- c("optparse", "MALDIquant", "MALDIquantForeign", "xml2", "viridisLite")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    stop(paste("Required package", pkg, "is not installed"))
  }
}

# Command line options
option_list <- list(
  make_option(c("--input"), type="character", help="Input imzML file", metavar="FILE"),
  make_option(c("--target_mz"), type="double", help="Target m/z value for visualization", metavar="NUMBER"),
  make_option(c("--tolerance"), type="double", default=0.5, help="Tolerance range for target m/z (default: 0.5)", metavar="NUMBER"),
  make_option(c("--output"), type="character", default="ion_image.png", help="Output PNG file for ion image (default: ion_image.png)", metavar="FILE")
)

opt_parser <- OptionParser(option_list=option_list, description="Generate ion images from imzML data using MALDIquant")
opts <- parse_args(opt_parser)

# Validate inputs
if (is.null(opts$input)) {
  stop("Input imzML file is required")
}
if (is.null(opts$target_mz)) {
  stop("Target m/z value is required")
}
if (!file.exists(opts$input)) {
  stop(paste("Input file does not exist:", opts$input))
}
if (opts$tolerance <= 0) {
  stop("Tolerance must be positive")
}

cat("Starting MALDIquant ion image generation...\n")
cat("Input file:", opts$input, "\n")
cat("Target m/z:", opts$target_mz, "±", opts$tolerance, "\n")

# Function to check if dataset is centroided
is_centroided <- function(imzml_file) {
  tryCatch({
    doc <- read_xml(imzml_file)
    cvParams <- xml_find_all(doc, "//*[local-name()='cvParam']")
    if (length(cvParams) == 0) {
      cat("Warning: No cvParam elements found, assuming profile mode\n")
      return(FALSE)
    }
    names <- xml_attr(cvParams, "name")
    accessions <- xml_attr(cvParams, "accession")
    
    # Check for centroid indicators
    centroid_indicators <- c("centroid", "centroided")
    result <- any(sapply(centroid_indicators, function(x) any(grepl(x, names, ignore.case = TRUE)))) ||
              any(accessions == "MS:1000127", na.rm = TRUE)
    cat("Centroided mode detected:", result, "\n")
    return(result)
  }, error = function(e) {
    cat("Warning: Could not determine centroid status, assuming profile mode\n")
    return(FALSE)
  })
}

# Determine centroided status
centroid_flag <- is_centroided(opts$input)

# Import imzML data
cat("Importing imzML data...\n")
spectra <- tryCatch({
  importImzMl(opts$input, centroided = centroid_flag)
}, error = function(e) {
  stop(paste("Failed to import imzML data:", e$message))
})

if (length(spectra) == 0) {
  stop("No spectra found in the imzML file")
}
cat("Successfully imported", length(spectra), "spectra\n")

# Get coordinates
coordinates_data <- coordinates(spectra)
if (nrow(coordinates_data) != length(spectra)) {
  stop("Mismatch between number of spectra and coordinates")
}

# Step 1: First pass - find all m/z values within tolerance across all spectra
cat("Finding matching m/z values across all spectra...\n")
all_mz_values <- c()
mz_tolerance <- opts$tolerance

# Collect all m/z values from all spectra
for (i in seq_along(spectra)) {
  spec_mz <- mass(spectra[[i]])
  all_mz_values <- c(all_mz_values, spec_mz)
  
  if (i %% 1000 == 0) {
    cat("Processed", i, "of", length(spectra), "spectra for m/z collection\n")
  }
}

# Find unique m/z values within tolerance of target
unique_mz <- unique(all_mz_values)
target_mz_indices <- which(abs(unique_mz - opts$target_mz) <= mz_tolerance)
target_mz_values <- unique_mz[target_mz_indices]

if (length(target_mz_values) == 0) {
  stop(paste("No m/z values found within tolerance of", opts$target_mz))
}

cat("Found", length(target_mz_values), "unique m/z values within tolerance\n")
cat("m/z range:", round(min(target_mz_values), 4), "-", round(max(target_mz_values), 4), "\n")

# Step 2: Extract intensities for target m/z values using Cardinal-like approach
cat("Extracting intensities using optimized method...\n")

# Pre-allocate intensity matrix: rows = m/z values, cols = pixels
intensity_matrix <- matrix(0, nrow = length(target_mz_values), ncol = length(spectra))
rownames(intensity_matrix) <- as.character(target_mz_values)

# Fill intensity matrix
for (i in seq_along(spectra)) {
  spec <- spectra[[i]]
  spec_mz <- mass(spec)
  spec_int <- intensity(spec)
  
  # For each target m/z, find the closest match in this spectrum
  for (j in seq_along(target_mz_values)) {
    target_mz <- target_mz_values[j]
    
    # Find closest m/z in this spectrum
    mz_diffs <- abs(spec_mz - target_mz)
    min_diff_idx <- which.min(mz_diffs)
    
    # Only use if within tolerance
    if (mz_diffs[min_diff_idx] <= mz_tolerance) {
      intensity_matrix[j, i] <- spec_int[min_diff_idx]
    }
  }
  
  if (i %% 1000 == 0) {
    cat("Processed", i, "of", length(spectra), "spectra for intensity extraction\n")
  }
}

# Step 3: Aggregate intensities across m/z values (like Cardinal's colMeans)
cat("Aggregating intensities across m/z channels...\n")

# Calculate average intensity across all matching m/z values for each pixel
final_intensities <- colMeans(intensity_matrix, na.rm = TRUE)

# Handle any remaining NaN values
final_intensities[is.nan(final_intensities)] <- 0

cat("Intensity extraction completed\n")
cat("Non-zero pixels:", sum(final_intensities > 0), "out of", length(final_intensities), "\n")

# Step 4: Create spatial mapping (exact same as Cardinal)
cat("Creating spatial image matrix...\n")

# Get unique coordinates and sort them
unique_x <- sort(unique(coordinates_data[, 1]))
unique_y <- sort(unique(coordinates_data[, 2]))

cat("Image dimensions:", length(unique_x), "x", length(unique_y), "\n")

# Initialize image matrix
image_matrix <- matrix(0, nrow = length(unique_y), ncol = length(unique_x))
rownames(image_matrix) <- as.character(unique_y)
colnames(image_matrix) <- as.character(unique_x)

# Fill image matrix with exact coordinate matching (like Cardinal)
for (i in seq_len(nrow(coordinates_data))) {
  x_coord <- coordinates_data[i, 1]
  y_coord <- coordinates_data[i, 2]
  
  # Find exact coordinate matches
  x_idx <- match(x_coord, unique_x)
  y_idx <- match(y_coord, unique_y)
  
  if (!is.na(x_idx) && !is.na(y_idx)) {
    image_matrix[y_idx, x_idx] <- final_intensities[i]
  }
}

# Check for valid data
valid_pixels <- sum(image_matrix > 0)
cat("Valid pixels with signal:", valid_pixels, "\n")

if (valid_pixels == 0) {
  warning("No valid pixels found. Check if target m/z is present in the data.")
}

# Step 5: Generate the plot (same as Cardinal)
cat("Generating ion image...\n")

# Calculate intensity statistics
intensity_stats <- list(
  min = min(final_intensities[final_intensities > 0], na.rm = TRUE),
  max = max(final_intensities, na.rm = TRUE),
  mean = mean(final_intensities[final_intensities > 0], na.rm = TRUE),
  nonzero_count = sum(final_intensities > 0)
)

# Handle case where no positive intensities exist
if (is.infinite(intensity_stats$min)) {
  intensity_stats$min <- 0
  intensity_stats$mean <- 0
}

cat("Intensity range:", round(intensity_stats$min, 4), "-", round(intensity_stats$max, 4), "\n")

# Create the plot
png(filename = opts$output, width = 12, height = 10, units = "in", res = 300)

# Plot parameters
par(mar = c(5, 5, 4, 2) + 0.1)

# Create the image plot (transpose matrix for correct orientation, like Cardinal)
image(x = unique_x,
      y = unique_y,
      z = t(image_matrix),
      col = viridis(256),
      xlab = "X Coordinate (µm)",
      ylab = "Y Coordinate (µm)",
      main = paste0("Ion Image at m/z = ", opts$target_mz, " ± ", opts$tolerance),
      useRaster = TRUE,
      asp = 1,
      cex.main = 1.2,
      cex.lab = 1.1)

# Add intensity information
if (intensity_stats$nonzero_count > 0) {
  mtext(paste("Intensity range:", round(intensity_stats$min, 2), "-", round(intensity_stats$max, 2)),
        side = 1, line = 3.5, cex = 0.9)
}

dev.off()

cat("Ion image saved as:", opts$output, "\n")
cat("MALDIquant analysis completed successfully!\n")

# Print summary statistics
cat("\n=== Analysis Summary ===\n")
cat("Target m/z:", opts$target_mz, "±", opts$tolerance, "\n")
cat("Matched m/z channels:", length(target_mz_values), "\n")
cat("Total pixels:", length(final_intensities), "\n")
cat("Pixels with signal:", intensity_stats$nonzero_count, "\n")
cat("Signal percentage:", round(intensity_stats$nonzero_count / length(final_intensities) * 100, 2), "%\n")
cat("========================\n")