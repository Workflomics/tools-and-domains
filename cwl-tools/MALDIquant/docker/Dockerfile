FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev libnetcdf-dev

RUN R -e "install.packages('MALDIquant', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('MALDIquantForeign', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('optparse', repos='http://cran.rstudio.com/')"

COPY run_detect_peaks_imzml.R /usr/local/bin/run_detect_peaks_imzml.R
RUN chmod +x /usr/local/bin/run_detect_peaks_imzml.R

WORKDIR /MALDIquant
