#!/bin/bash

VERSION=1.9.3
PRG=word_cloud
DOCKER_USER=workflomics

# Build the Docker image
docker build --no-cache --build-arg sw_version=${VERSION} --tag "${DOCKER_USER}/${PRG}:latest" --tag "${DOCKER_USER}/${PRG}:${VERSION}" .

# Test the Docker image
echo "Testing the Docker image"
echo "This should display the \"Help\" message"
echo ""

# Create Docker image
docker run --rm "${DOCKER_USER}/${PRG}:${VERSION}" /bin/wordcloud_cli --help

echo ""

# Push Docker image
echo "Now push the image to Dockerhub with:"
echo "docker image push ${DOCKER_USER}/${PRG}:latest"
echo "docker image push ${DOCKER_USER}/${PRG}:${VERSION}"
