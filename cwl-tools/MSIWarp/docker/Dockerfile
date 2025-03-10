# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Install system dependencies (C++ build tools, cmake, git)
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone the MSIWarp repository
RUN git clone --recursive https://github.com/horvatovichlab/MSIWarp.git /opt/MSIWarp

# Build and install MSIWarp
WORKDIR /opt/MSIWarp

# RUN python setup.py install --user

# Install additional Python packages
RUN pip install pyimzml numpy matplotlib
RUN pip install .

# Copy the Python script and optional default config file
COPY run_msiwarp_alignment.py /usr/local/bin/run_msiwarp_alignment.py
COPY config.json /usr/local/bin/config.json

RUN chmod +x /usr/local/bin/run_msiwarp_alignment.py

# Ensure local user install path is in PATH
ENV PATH="/root/.local/bin:${PATH}"

# Set work directory
WORKDIR /data

# Default entrypoint
ENTRYPOINT ["python3", "/usr/local/bin/run_msiwarp_alignment.py"]
