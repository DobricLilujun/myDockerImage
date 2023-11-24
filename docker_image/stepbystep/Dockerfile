#!/bin/bash

# This docker includes basic softwares of linux based on ubuntu:22.04
# Install python3.8,3.9,3.11
# Install anaconda Anaconda3-2023.09
# Install venv 3.8, 3.9,3.11
# Creat a virtual environment using 3.11
# CUDA 12.3 is installed but maybe not necessary
# 

FROM ubuntu:22.04
RUN yes| unminimize

# Set ENV variables
ENV LANG C.UTF-8
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive

ENV APT_INSTALL="apt-get install -y --no-install-recommends"
ENV PIP_INSTALL="python3 -m pip --no-cache-dir install --upgrade"
ENV GIT_CLONE="git clone --depth 10"


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
    software-properties-common \
    nvidia-cuda-toolkit


RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    $APT_INSTALL \
    python3.11-dev


RUN ln -s /usr/bin/python3.11 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.11 /usr/local/bin/python


# # Installing conda
RUN curl --output anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
RUN chmod u+x anaconda.sh
RUN ./anaconda.sh -b -p /root/anaconda3
RUN /root/anaconda3/bin/conda init bash
RUN /bin/bash -c "source ~/.bashrc"
RUN ln -s /root/anaconda3/bin/conda /usr/local/bin/conda
RUN rm anaconda.sh
RUN conda install pytorch torchvision torchaudio cpuonly -c pytorch
RUN export PATH=/usr/local/cuda/bin:$PATH

# # # Insall python dependency
# RUN conda create -n llm_env python=3.11 && \
#     conda activate llm_env && \
#     $PIP_INSTALL \
#     numpy==1.23.4 \
#     scipy==1.9.2 \
#     pandas==1.5.0 \
#     cloudpickle==2.2.0 \
#     scikit-image \
#     matplotlib==3.6.1 \
#     ipython==8.5.0 \
#     ipykernel==6.16.0 \
#     ipywidgets==8.0.2 \
#     cython==0.29.32 \
#     tqdm==4.64.1 \
#     gdown \
#     xgboost==1.6.2 \
#     pillow==9.2.0 \
#     seaborn==0.12.0 \
#     sqlalchemy==1.4.41 \
#     spacy==3.4.1 \
#     nltk==3.7 \
#     boto3==1.24.90 \
#     tabulate==0.9.0 \
#     future==0.18.2 \
#     gradient==2.0.6 \
#     jsonify==0.5 \
#     opencv-python==4.6.0.66 \
#     sentence-transformers==2.2.2 \
#     wandb==0.13.4 \
#     awscli==1.25.91 \
#     jupyterlab-snippets==0.4.1 \
#     tornado==6.1

# RUN conda config --set auto_activate_base false && \
#     conda config --set show_channel_urls true


# Installing pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
ENV PATH=$PATH:/root/.local/bin


# ==================================================================
# Virtual Environment (venv) with numpy and scipy
# ------------------------------------------------------------------


# Install venv dependencies python version should compatible with python-venv version
RUN apt-get update && apt-get install -y python3-venv python3.11-dev build-essential libssl-dev libffi-dev libpq-dev
RUN apt-get install python3.11-venv -y

# Create and activate a virtual environment
RUN python3 -m venv /opt/llm_env && \
    /opt/llm_env/bin/pip install --upgrade pip && \
    /opt/llm_env/bin/pip install numpy==1.23.4 scipy==1.9.2

# Set the environment variables for the virtual environment
ENV VIRTUAL_ENV=/opt/llm_env
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# ==================================================================
# Installing CUDA packages ( Ubuntu 2004 with cuda toolkit 12.3)
# ------------------------------------------------------------------


RUN sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN sudo wget https://developer.download.nvidia.com/compute/cuda/12.3.1/local_installers/cuda-repo-ubuntu2004-12-3-local_12.3.1-545.23.08-1_amd64.deb
RUN sudo dpkg -i cuda-repo-ubuntu2004-12-3-local_12.3.1-545.23.08-1_amd64.deb
RUN sudo cp /var/cuda-repo-ubuntu2004-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
RUN sudo apt-get update
RUN sudo apt-get -y install cuda-toolkit-12-3

ENV PATH=$PATH:/usr/local/cuda-12.3/bin
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' >> ~/.bashrc \
    && echo 'export PATH=$PATH:/usr/local/cuda/bin' >> ~/.bashrc \
    && echo 'export CUDA_HOME=$CUDA_HOME:/usr/local/cuda' >> ~/.bashrc

RUN sudo rm -rf cuda
RUN sudo ln -s /usr/local/cuda-12.3/  /usr/local/cuda


# ==================================================================
# PyTorch
# ------------------------------------------------------------------


# RUN $PIP_INSTALL torch torchvision torchaudio torchtext && \
#     # ==================================================================
#     # Hugging Face
#     # ------------------------------------------------------------------
#     $PIP_INSTALL datasets && \
#     # ==================================================================
#     # JupyterLab
#     # ------------------------------------------------------------------
#     $PIP_INSTALL jupyterlab==3.4.6 && \
#     # ==================================================================
#     # Installing transformers & scikit image (fixed)
#     # ------------------------------------------------------------------
#     RUN pip install -U git+https://github.com/huggingface/transformers

RUN pip install --pre scikit-learn


# ==================================================================
# Startup
# ------------------------------------------------------------------

EXPOSE 8888 6006

CMD ["/bin/bash"]