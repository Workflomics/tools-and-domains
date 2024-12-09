FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/wine
ENV WINEARCH=win64

RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    curl \
    gnupg2 \
    wine64 \
    wine32 \
    winbind \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /wine && wineboot --init

RUN wget https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe -O /tmp/python-installer.exe \
    && wine /tmp/python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 \
    && rm /tmp/python-installer.exe

RUN wine python --version

RUN wget https://github.com/mhammond/pywin32/releases/download/b306/pywin32-306.win-amd64-py3.11.exe -O /tmp/pywin32-installer.exe \
    && wine /tmp/pywin32-installer.exe \
    && rm /tmp/pywin32-installer.exe

RUN wine python -m pip install msigen

WORKDIR /app
COPY . /app

CMD ["wine", "python", "MSIGen_CLI.py", "config.json"]

# This one is useless! 
# And use win base image too! 
# Dont know how to deal with this