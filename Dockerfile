# Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="ceroberoz@gmail.com"
LABEL version="0.1"
LABEL description="This is custom Docker Image for \
the Scala CLI Services."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

# Install dependencies from ubuntu repository
RUN apt install -y wget git build-essential cmake automake libtool autoconf && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# Build scala
RUN git clone https://github.com/scala-network/XLArig.git && \
    mkdir XLArig/build && \
    cd XLArig/scripts && \
    ./build_deps.sh && \
    cd ../build && \
    cmake .. -DXMRIG_DEPS=scripts/deps && \
    make -j$(nproc)

RUN mv XLArig/build/xlarig / && \
    rm -rf XLArig

CMD ["./xlarig", "--config=/etc/scala/config.json"]

