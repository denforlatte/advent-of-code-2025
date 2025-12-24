FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install GNAT Ada compiler, GPRbuild, and basic tools
RUN apt-get update && apt-get install -y \
    gnat \
    gprbuild \
    git \
    curl \
    wget \
    unzip \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Keep container running
CMD ["/bin/bash"]
