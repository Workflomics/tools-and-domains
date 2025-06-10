#!/usr/bin/env python3
import argparse
import m2aia as m2
import os

parser = argparse.ArgumentParser(description="Run normalization or standardization with pyM2aia.")
parser.add_argument("-i", "--input", type=str, required=True, help="Input imzML file path.")
parser.add_argument("-o", "--output", type=str, required=True, help="Output imzML file path.")
parser.add_argument("-m", "--method", type=str, choices=["tic", "sqrt"], default="tic",
                    help="Normalization method: 'tic' (Total Ion Current) or 'sqrt' (Square Root).")

args = parser.parse_args()

reader = m2.ImzMLReader(args.input)

if args.method == "tic":
    reader.SetNormalization(m2.m2NormalizationTIC)
elif args.method == "sqrt":
    reader.SetIntensityTransformation(m2.m2IntensityTransformationSquareRoot)

try:
    reader.WriteContinuousCentroidImzML(args.output, [])
except Exception as e:
    print(f"Error with empty centroids list: {e}")
    print("Trying to get existing m/z values...")
    try:
        spectrum = reader.GetMeanSpectrum()
        mz_values = reader.GetXAxis() 
        reader.WriteContinuousCentroidImzML(args.output, mz_values.tolist())
    except Exception as e2:
        print(f"Error getting m/z values: {e2}")
        raise

print(f"Saved normalized file to {args.output}")
