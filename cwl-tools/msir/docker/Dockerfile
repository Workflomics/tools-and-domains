FROM python:3.12-slim

RUN pip install --no-cache-dir \
    numpy \
    scipy \
    pyimzml \
    scikit-learn

# Download the original recalibration script
RUN apt-get update && apt-get install -y curl && \
    curl -o /usr/local/bin/recalibration_original.py https://raw.githubusercontent.com/LaRoccaRaphael/MSI_recalibration/master/recalibration/recalibration.py && \
    rm -rf /var/lib/apt/lists/*

# Create the recalibration.py script
COPY <<EOF /usr/local/bin/recalibration.py
#!/usr/bin/env python3
import json
import sys
import subprocess
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', required=True)
    parser.add_argument('-i2', required=True) 
    parser.add_argument('-o', default='output.imzML')
    parser.add_argument('--config', help='JSON config file')
    parser.add_argument('-st', type=float, default=0.0005)
    parser.add_argument('-tl', type=float, default=0.01)
    parser.add_argument('-lm', type=float, default=0.002)
    
    args = parser.parse_args()
    
    if args.config:
        try:
            with open(args.config, 'r') as f:
                config = json.load(f)
            
            params = config.get('recalibration_parameters', {})
            st = params.get('bandwidth_density_estimation', args.st)
            tl = params.get('tolerance_dalton', args.tl) 
            lm = params.get('local_tolerance_window', args.lm)
        except:
            st, tl, lm = args.st, args.tl, args.lm
    else:
        st, tl, lm = args.st, args.tl, args.lm
    
    cmd = [
        'python3', '/usr/local/bin/recalibration_original.py',
        '-i', args.i,
        '-i2', args.i2,
        '-o', args.o,
        '-st', str(st),
        '-tl', str(tl),
        '-lm', str(lm)
    ]
    
    subprocess.run(cmd)

if __name__ == '__main__':
    main()
EOF

RUN chmod +x /usr/local/bin/recalibration.py

