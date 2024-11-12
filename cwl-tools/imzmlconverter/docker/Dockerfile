FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    wget \
    unzip \
    openjdk-8-jre \
    curl \
    python3 \
    python3-pip

WORKDIR /usr/local/imzmlconverter

RUN wget https://github.com/ImzMLConverter/imzMLConverter/releases/download/v2.1.1/imzMLConverter-2.1.1.zip -O imzMLConverter.zip && \
    unzip imzMLConverter.zip && \
    rm imzMLConverter.zip

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

ENTRYPOINT ["java", "-jar", "imzMLConverter-2.1.1/jimzMLConverter-2.1.1.jar"]

CMD ["--help"]
