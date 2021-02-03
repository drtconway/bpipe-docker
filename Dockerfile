FROM ubuntu:groovy

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && \
    apt install -y \
        git \
        openjdk-8-jdk-headless

RUN cd /opt && \
    git clone https://github.com/ssadedin/bpipe.git && \
    cd bpipe && \
    ./gradlew build -x test

ENV PATH=/opt/bpipe/bin:${PATH}

