FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    default-jdk \
    libnetcdf-dev \
    wget \
    unzip

RUN R -e "install.packages('remotes', repos='http://cran.rstudio.com/')"
RUN R -e "remotes::install_github('ftw302/massPix')"

COPY *.R /usr/local/bin/
RUN chmod +x /usr/local/bin/*.R

WORKDIR /masspix

ENTRYPOINT ["/bin/bash"]
