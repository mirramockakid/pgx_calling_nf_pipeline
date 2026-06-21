FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
        build-essential \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir aldy==4.8.3

RUN useradd --create-home --shell /bin/bash aldyuser

USER aldyuser
WORKDIR /home/aldyuser

