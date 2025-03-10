#!/usr/bin/env python3
"""
run_msiwarp_alignment.py

A script to perform mass alignment of MSI data using MSIWarp.
User only needs to supply an input imzML file and an optional config file.
All processing parameters are read from the config file.
"""

import sys
import os
import json
import argparse
import numpy as np
from pyimzml.ImzMLParser import ImzMLParser
from pyimzml.ImzMLWriter import ImzMLWriter
import msiwarp as mx
from msiwarp.util.warp import to_mx_peaks, to_mz, to_height

# Default configuration
DEFAULT_CONFIG = {
    "reference_index": 0,
    "n_cores": 0,
    "sigma_default": 0.1,
    "epsilon": 1.0,
    "n_nodes": 4,
    "node_delta": 0.01,
    "n_steps": 25,
    "output_file": "aligned_output.imzML"
}

def load_config(config_path):
    try:
        with open(config_path, "r") as f:
            config = json.load(f)
        return config
    except Exception as e:
        print("Error loading config file, using defaults. Error:", e)
        return DEFAULT_CONFIG

def main():
    parser = argparse.ArgumentParser(
        description="Perform mass alignment of MSI data using MSIWarp with external configuration."
    )
    parser.add_argument("--input", required=True, help="Input imzML file")
    parser.add_argument("--config", help="Optional configuration file in JSON format")
    args = parser.parse_args()
    
    # Load configuration
    if args.config:
        config = load_config(args.config)
    else:
        config = DEFAULT_CONFIG

    output_file = config.get("output_file", "aligned_output.imzML")
    
    print("Loading imzML data from {}...".format(args.input))
    parser_imzml = ImzMLParser(args.input)
    coordinates = list(parser_imzml.coordinates)
    
    spectra = []
    # Process each spectrum
    for idx, coords in enumerate(coordinates):
        mzs, intensities = parser_imzml.getspectrum(idx)
        sigma = config.get("sigma_default", 0.1)
        peaks = [mx.peak(idx, mz, inten, sigma) for mz, inten in zip(mzs, intensities)]
        spectra.append(peaks)
    
    ref_index = config.get("reference_index", 0)
    print("Using spectrum index {} as reference.".format(ref_index))
    reference_spectrum = spectra[ref_index]
    
    # Determine m/z range
    mz_min = min([min([p.mz for p in s]) for s in spectra if s])
    mz_max = max([max([p.mz for p in s]) for s in spectra if s])
    
    # Setup warping nodes based on config
    n_nodes = config.get("n_nodes", 4)
    node_mzs = np.linspace(mz_min, mz_max, n_nodes).tolist()
    node_delta = config.get("node_delta", 0.01)
    node_deltas = [node_delta] * n_nodes
    n_steps = config.get("n_steps", 25)
    nodes = mx.initialize_nodes(node_mzs, node_deltas, n_steps)
    
    epsilon = config.get("epsilon", 1.0)
    n_cores = config.get("n_cores", 1)
    
    print("Finding optimal warpings...")
    optimal_moves = mx.find_optimal_spectra_warpings(spectra, reference_spectrum, nodes, epsilon, n_cores=n_cores)
    
    print("Warping spectra...")
    warped_spectra = [mx.warp_peaks(s, nodes, opt_move) for s, opt_move in zip(spectra, optimal_moves)]
    
    print("Writing aligned spectra to {}...".format(output_file))
    with ImzMLWriter(output_file) as writer:
        for warped, coords in zip(warped_spectra, coordinates):
            mz_array = to_mz(warped)
            intensity_array = to_height(warped)
            writer.addSpectrum(mz_array, intensity_array, coords)
    
    print("Alignment and export completed.")

if __name__ == "__main__":
    main()
