FROM ubuntu:groovy

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && \
    apt install -y \
        build-essential \
        cryptsetup-bin \
        git \
        golang-go \
        libseccomp-dev \
        openjdk-8-jdk-headless \
        pkg-config \
        squashfs-tools \
        wget

# Install bpipe from github.
#
RUN cd /opt && \
    git clone https://github.com/ssadedin/bpipe.git && \
    cd bpipe && \
    ./gradlew build -x test
ENV PATH=/opt/bpipe/bin:${PATH}

# Install singularity
#
ENV SINGULARITY_VERSION=3.7.1
ENV GOPATH=/root/go
RUN mkdir -p "${GOPATH}/src/github.com/sylabs" && \
    cd "${GOPATH}/src/github.com/sylabs" && \
    wget https://github.com/hpcng/singularity/releases/download/v3.7.1/singularity-${SINGULARITY_VERSION}.tar.gz && \
    tar -xzvf singularity-${SINGULARITY_VERSION}.tar.gz && \
    rm singularity-${SINGULARITY_VERSION}.tar.gz && \
    cd singularity && \
    ./mconfig -v -p /usr/local && \
    make -C builddir && \
    make -C builddir install && \
    rm -rf builddir
