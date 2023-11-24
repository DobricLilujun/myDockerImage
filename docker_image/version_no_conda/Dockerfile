#!/bin/bash

FROM ubuntu:20.04
RUN yes| unminimize

# Set ENV variables
ENV LANG C.UTF-8
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive

ENV APT_INSTALL="apt-get install -y --no-install-recommends"
ENV PIP_INSTALL="python3 -m pip --no-cache-dir install --upgrade"
ENV GIT_CLONE="git clone --depth 10"


# ==================================================================
# Tools
# ------------------------------------------------------------------

RUN apt-get update && \
    $APT_INSTALL \
    apt-utils \
    apt-transport-https \
    wget \
    git \
    vim \
    curl \
    openssh-client \
    unzip \
    zip \
    csvkit \
    sudo \
    software-properties-common

# ==================================================================
# Python
# ------------------------------------------------------------------

# Adding repository for python3.11
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    $APT_INSTALL \
    python3.11-dev

# Add symlink so python and python3 commands use same python3.9 executable
RUN ln -s /usr/bin/python3.11 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.11 /usr/local/bin/python




# Installing pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
ENV PATH=$PATH:/root/.local/bin

# Create and activate a virtual environment
RUN pyenv virtualenv 3.11.0 llm_env && \
    pyenv activate llm_env && \
    $PIP_INSTALL \
    numpy==1.23.4 \
    scipy==1.9.2 \
    pandas==1.5.0 \
    cloudpickle==2.2.0 \
    scikit-image \
    matplotlib==3.6.1 \
    ipython==8.5.0 \
    ipykernel==6.16.0 \
    ipywidgets==8.0.2 \
    cython==0.29.32 \
    tqdm==4.64.1 \
    gdown \
    xgboost==1.6.2 \
    pillow==9.2.0 \
    seaborn==0.12.0 \
    sqlalchemy==1.4.41 \
    spacy==3.4.1 \
    nltk==3.7 \
    boto3==1.24.90 \
    tabulate==0.9.0 \
    future==0.18.2 \
    gradient==2.0.6 \
    jsonify==0.5 \
    opencv-python==4.6.0.66 \
    sentence-transformers==2.2.2 \
    wandb==0.13.4 \
    awscli==1.25.91 \
    jupyterlab-snippets==0.4.1 \
    tornado==6.1

# ==================================================================
# Installing CUDA packages (CUDA Toolkit 11.6.2 & CUDNN 8.4.1)
# ------------------------------------------------------------------

# Installing CUDA Toolkit
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda-repo-ubuntu2004-12-1-local_12.1.0-530.30.02-1_amd64.deb && \
    dpkg -i cuda-repo-ubuntu2004-12-1-local_12.1.0-530.30.02-1_amd64.deb && \
    cp /var/cuda-repo-ubuntu2004-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get -y install cuda

ENV PATH=$PATH:/usr/local/cuda-12.1/bin
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64

# ==================================================================
# PyTorch
# ------------------------------------------------------------------

RUN $PIP_INSTALL torch torchvision torchaudio torchtext && \

    # ==================================================================
    # Hugging Face
    # ------------------------------------------------------------------
    $PIP_INSTALL datasets && \

    # ==================================================================
    # JupyterLab
    # ------------------------------------------------------------------
    $PIP_INSTALL jupyterlab==3.4.6 && \


    # ==================================================================
    # Installing transformers & scikit image (fixed)
    # ------------------------------------------------------------------
    RUN pip install -U git+https://github.com/huggingface/transformers

RUN pip install --pre scikit-learn


# ==================================================================
# Startup
# ------------------------------------------------------------------

EXPOSE 8888 6006

CMD jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True
