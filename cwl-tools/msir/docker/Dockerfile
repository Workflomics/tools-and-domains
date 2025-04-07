FROM python:3.8-slim

RUN pip install --no-cache-dir \
    numpy==1.18.1 \
    scipy==1.4.1 \
    pyimzml==1.2.6 \
    scikit-learn==0.22.1

RUN apt-get update && apt-get install -y curl && \
    curl -o /usr/local/bin/recalibration.py https://raw.githubusercontent.com/alexandrevicenzi/MSI-recalibration/main/recalibration/recalibration.py && \
    chmod +x /usr/local/bin/recalibration.py

WORKDIR /data
ENTRYPOINT ["python", "/usr/local/bin/recalibration.py"]
