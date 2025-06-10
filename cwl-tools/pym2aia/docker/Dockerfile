FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libglu1-mesa-dev \
        libgomp1 \
        libopenslide-dev \
    && rm -rf /var/lib/apt/lists/*

COPY m2aia-0.5.10-py3-none-manylinux_2_31_x86_64.whl /tmp/
RUN pip install --upgrade pip && \
    pip install --no-cache-dir /tmp/m2aia-0.5.10-py3-none-manylinux_2_31_x86_64.whl numpy

COPY m2aia-normalize.py /usr/local/bin/m2aia-normalize.py
RUN chmod +x /usr/local/bin/m2aia-normalize.py

ENTRYPOINT ["python3", "/usr/local/bin/m2aia-normalize.py"]
