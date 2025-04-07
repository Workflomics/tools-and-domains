FROM python:3.10-slim

RUN apt-get update && apt-get install -y libglu1-mesa-dev libgomp1 libopenslide-dev

RUN pip install --upgrade pip && \
    pip install m2aia numpy

COPY m2aia_normalize.py /usr/local/bin/m2aia_normalize.py
RUN chmod +x /usr/local/bin/m2aia_normalize.py

ENTRYPOINT ["python3", "/usr/local/bin/m2aia_normalize.py"]
