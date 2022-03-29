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

# Install curl, unzip from ubuntu repository
RUN apt install -y curl unzip libuv1-dev hwloc && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# Get latest Scala CLI (Linux) & Unzip to /opt/scala
RUN curl -L https://github.com/scala-network/XLArig/releases/download/v5.2.3/XLArig-v5.2.3-linux-x86_64.zip --silent > xlarig.zip && \
    mkdir /opt/scala && \
    unzip xlarig.zip -d /opt/scala

# Run Scala CLI
COPY config.json /opt/scala
RUN /opt/scala/./xlarig

# Expose Port for the Application 
EXPOSE 80 443