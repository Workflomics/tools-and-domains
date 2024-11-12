FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget xdg-utils libgl1 libgtk-3-0 libxtst6 gh sudo && \
    rm -rf /var/lib/apt/lists/*

RUN gh auth login && \
    gh release download --repo mzmine/mzmine --pattern "mzmine*.deb" || \
    wget https://github.com/mzmine/mzmine/releases/download/text-action-release/mzmine_4.3.1_amd64.deb

RUN sudo mkdir -p /usr/share/desktop-directories/ && \
    sudo apt install -y ./mzmine*.deb && \
    rm -f mzmine*.deb

WORKDIR /opt/mzmine/bin

ENTRYPOINT ["./mzmine", "-help"]
