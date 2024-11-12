#!/bin/bash
PRG=wcloud
DOCKER_USER=workflomics

# Make sure we don´t have a stale ${PRG} binary or dir
rm -rf ${PRG}

mkdir -p build
cd build

if [ ! -d "${PRG}" ]; then
  git clone "https://github.com/isaackd/${PRG}.git"
fi

cd ${PRG}

# Update the repository
git pull

# Get version from git
VERSION=$(git describe --abbrev --dirty --always --tags)
VERSION=${VERSION#"v"}

# We want a full static binary
rustup target add x86_64-unknown-linux-musl

# Build the binary
cargo install --target=x86_64-unknown-linux-musl --force ${PRG}

cd ../..

cp ~/.cargo/bin/${PRG} ${PRG}

# Create Docker image
docker build --no-cache --tag "${DOCKER_USER}/${PRG}:latest" --tag "${DOCKER_USER}/${PRG}:${VERSION}" .

# Test the Docker image
echo "Testing the Docker image"
echo "This should display the \"Help\" message"
echo ""

docker run --rm "${DOCKER_USER}/${PRG}:${VERSION}" /bin/wcloud --help

echo ""

# Push Docker image
echo "Now push the image to Dockerhub with:"
echo "docker push ${DOCKER_USER}/${PRG}:latest"
echo "docker push ${DOCKER_USER}/${PRG}:${VERSION}"

# Remove the binary
rm ${PRG}

