FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common wget curl

RUN dpkg --add-architecture i386 && apt-get update

RUN apt-get install -y wine64 wine32 xvfb

RUN apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip setuptools

RUN pip3 install pywin32==306

RUN pip3 install MSIGen

WORKDIR /msigen

COPY MSIGen_CLI.py /msigen/MSIGen_CLI.py
COPY config.json /msigen/config.json

ENTRYPOINT ["xvfb-run", "wine", "python", "/msigen/MSIGen_CLI.py", "/msigen/config.json"]
