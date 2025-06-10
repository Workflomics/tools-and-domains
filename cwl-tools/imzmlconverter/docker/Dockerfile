FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Amsterdam"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        unzip \
        openjdk-8-jre \
        curl \
        python3 \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /imzmlconverter && \
    cd /imzmlconverter && \
    wget https://github.com/AlanRace/imzMLConverter/releases/download/2.1.1/jimzMLConverter-2.1.1.zip -O imzMLConverter.zip && \
    unzip imzMLConverter.zip && \
    rm imzMLConverter.zip

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

ENTRYPOINT ["java", "-jar", "/imzmlconverter/jimzMLConverter-2.1.1.jar"]
CMD ["--help"]