# FROM python:3.7.7-slim-stretch
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

RUN mkdir -p /opt/program
COPY bloom_trainer.py /opt/program
WORKDIR /opt/program


ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt install -y python3.10 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY requirements.txt requirements.txt
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 \
    && python3.10 -m pip install -r requirements.txt \
    && python3.10 -m pip install numpy --pre torch --force-reinstall --index-url https://download.pytorch.org/whl/nightly/cu118
COPY . .
# ENTRYPOINT [ "python3.10"]


ENTRYPOINT [ "python3", "/opt/program/bloom_trainer.py" ]