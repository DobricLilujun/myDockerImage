#!/bin/bash

# Paperspace Dockerfile for Gradient base image
# Paperspace image is located in Dockerhub registry: paperspace/gradient_base

# ==================================================================
# Module list
# ------------------------------------------------------------------
# python                3.11.0           (apt)
# torch                 2.0              (pip)
# torchvision           0.13.1           (pip)
# torchaudio            0.12.1           (pip)
# tensorflow            2.9.2            (pip)
# jax                   0.3.23           (pip)
# transformers          4.21.3           (pip)
# datasets              2.4.0            (pip)
# jupyterlab            3.4.6            (pip)
# numpy                 1.23.4           (pip)
# scipy                 1.9.2            (pip)
# pandas                1.5.0            (pip)
# cloudpickle           2.2.0            (pip)
# scikit-image          0.19.3           (pip)
# scikit-learn          1.1.2            (pip)
# matplotlib            3.6.1            (pip)
# ipython               8.5.0            (pip)
# ipykernel             6.16.0           (pip)
# ipywidgets            8.0.2            (pip)
# cython                0.29.32          (pip)
# tqdm                  4.64.1           (pip)
# gdown                 4.5.1            (pip)
# xgboost               1.6.2            (pip)
# pillow                9.2.0            (pip)
# seaborn               0.12.0           (pip)
# sqlalchemy            1.4.41           (pip)
# spacy                 3.4.1            (pip)
# nltk                  3.7              (pip)
# boto3                 1.24.90          (pip)
# tabulate              0.9.0            (pip)
# future                0.18.2           (pip)
# gradient              2.0.6            (pip)
# jsonify               0.5              (pip)
# opencv-python         4.6.0.66         (pip)
# sentence-transformers 2.2.2            (pip)
# wandb                 0.13.4           (pip)
# nodejs                16.x latest      (apt)
# default-jre           latest           (apt)
# default-jdk           latest           (apt)


# ==================================================================
# Initial setup
# ------------------------------------------------------------------

# Ubuntu 20.04 as base image
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
    ca-certificates \
    wget \
    rsync \
    git \
    vim \
    mlocate \
    libssl-dev \
    curl \
    openssh-client \
    unzip \
    unrar \
    zip \
    csvkit \
    dialog \
    man-db \
    manpages \
    manpages-dev \
    manpages-posix \
    manpages-posix-dev \
    nano \
    sudo \
    software-properties-common


# ==================================================================
# Python
# ------------------------------------------------------------------

#Based on https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa

# Adding repository for python3.11
RUN add-apt-repository ppa:deadsnakes/ppa -y && \

    # Installing python3.11
    $APT_INSTALL \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-distutils-extra\
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3.10-distutils-extra

# Add symlink so python and python3 commands use same python3.9 executable
RUN ln -s /usr/bin/python3.11 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.11 /usr/local/bin/python

# Installing pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
ENV PATH=$PATH:/root/.local/bin

# Installing conda
RUN curl --output anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh && \
    chmod u+x anaconda.sh && ./anaconda.sh -b -p /root/anaconda3 && /root/anaconda3/bin/conda init bash && \
    source ~/.bashrc && ln -s /root/anaconda3/bin/conda /usr/local/bin/condaRUN conda install pytorch torchvision torchaudio cpuonly -c pytorch

# Insall python dependency
RUN conda create -n llm_env python=3.11 && \
    conda activate llm_env && \
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
    tornado==6.1 && \

    conda clean -af


# 设置 conda 的配置，避免一些初始化时的提示
RUN conda config --set auto_activate_base false && \
    conda config --set show_channel_urls true


# ==================================================================
# Installing CUDA packages (CUDA Toolkit 11.6.2 & CUDNN 8.4.1)
# ------------------------------------------------------------------

# Based on https://developer.nvidia.com/cuda-toolkit-archive
# Based on https://developer.nvidia.com/rdp/cudnn-archive
# Based on https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#package-manager-ubuntu-install

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

# Installing CUDNN
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-get install dirmngr -y && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
    apt-get update && \
    apt-get install libcudnn8=8.9.0.*-1+cuda12.1 -y && \
    apt-get install libcudnn8-dev=8.9.0.*-1+cuda12.1 -y && \
    rm /etc/apt/preferences.d/cuda-repository-pin-600


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
#!/bin/bash

# Paperspace Dockerfile for Gradient base image
# Paperspace image is located in Dockerhub registry: paperspace/gradient_base

# ==================================================================
# Module list
# ------------------------------------------------------------------
# python                3.11.0           (apt)
# torch                 2.0              (pip)
# torchvision           0.13.1           (pip)
# torchaudio            0.12.1           (pip)
# tensorflow            2.9.2            (pip)
# jax                   0.3.23           (pip)
# transformers          4.21.3           (pip)
# datasets              2.4.0            (pip)
# jupyterlab            3.4.6            (pip)
# numpy                 1.23.4           (pip)
# scipy                 1.9.2            (pip)
# pandas                1.5.0            (pip)
# cloudpickle           2.2.0            (pip)
# scikit-image          0.19.3           (pip)
# scikit-learn          1.1.2            (pip)
# matplotlib            3.6.1            (pip)
# ipython               8.5.0            (pip)
# ipykernel             6.16.0           (pip)
# ipywidgets            8.0.2            (pip)
# cython                0.29.32          (pip)
# tqdm                  4.64.1           (pip)
# gdown                 4.5.1            (pip)
# xgboost               1.6.2            (pip)
# pillow                9.2.0            (pip)
# seaborn               0.12.0           (pip)
# sqlalchemy            1.4.41           (pip)
# spacy                 3.4.1            (pip)
# nltk                  3.7              (pip)
# boto3                 1.24.90          (pip)
# tabulate              0.9.0            (pip)
# future                0.18.2           (pip)
# gradient              2.0.6            (pip)
# jsonify               0.5              (pip)
# opencv-python         4.6.0.66         (pip)
# sentence-transformers 2.2.2            (pip)
# wandb                 0.13.4           (pip)
# nodejs                16.x latest      (apt)
# default-jre           latest           (apt)
# default-jdk           latest           (apt)


# ==================================================================
# Initial setup
# ------------------------------------------------------------------

# Ubuntu 20.04 as base image
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
    ca-certificates \
    wget \
    rsync \
    git \
    vim \
    mlocate \
    libssl-dev \
    curl \
    openssh-client \
    unzip \
    unrar \
    zip \
    csvkit \
    dialog \
    man-db \
    manpages \
    manpages-dev \
    manpages-posix \
    manpages-posix-dev \
    nano \
    sudo \
    software-properties-common


# ==================================================================
# Python
# ------------------------------------------------------------------

#Based on https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa

# Adding repository for python3.11
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    # Installing python3.11
    $APT_INSTALL \
    python3.11 

# Add symlink so python and python3 commands use same python3.9 executable
RUN ln -s /usr/bin/python3.11 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.11 /usr/local/bin/python

# Installing pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
ENV PATH=$PATH:/root/.local/bin

# Installing conda
RUN curl --output anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh && \
    chmod u+x anaconda.sh && ./anaconda.sh -b -p /root/anaconda3 && /root/anaconda3/bin/conda init bash && \
    source ~/.bashrc && ln -s /root/anaconda3/bin/conda /usr/local/bin/condaRUN conda install pytorch torchvision torchaudio cpuonly -c pytorch

# Insall python dependency
RUN conda create -n llm_env python=3.11 && \
    conda activate llm_env && \
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
    tornado==6.1 && \
    conda clean -af

RUN conda config --set auto_activate_base false && \
    conda config --set show_channel_urls true


# ==================================================================
# Installing CUDA packages (CUDA Toolkit 11.6.2 & CUDNN 8.4.1)
# ------------------------------------------------------------------

# Based on https://developer.nvidia.com/cuda-toolkit-archive
# Based on https://developer.nvidia.com/rdp/cudnn-archive
# Based on https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#package-manager-ubuntu-install

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

# Installing CUDNN
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-get install dirmngr -y && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
    apt-get update && \
    apt-get install libcudnn8=8.9.0.*-1+cuda12.1 -y && \
    apt-get install libcudnn8-dev=8.9.0.*-1+cuda12.1 -y && \
    rm /etc/apt/preferences.d/cuda-repository-pin-600


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
