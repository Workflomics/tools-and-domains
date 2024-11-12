# Use ubuntu as image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    potrace \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /imagemagick

# Install necessary packages
RUN wget https://www.imagemagick.org/download/ImageMagick.tar.gz && \
    tar xvzf ImageMagick.tar.gz && \
    cd ImageMagick-* && \
    apt-get update && apt-get install -y \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjbig-dev \
    librsvg2-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && \
    ./configure --with-png=yes --with-rsvg=yes && \  
    make && \
    make install && \
    ldconfig

# Set environment 
ENV MAGICK_HOME="/usr/local/ImageMagick"
ENV PATH="$MAGICK_HOME/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# Default command
CMD ["magick", "-version"]
