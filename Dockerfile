FROM ubuntu:20.04
RUN yes| unminimize

# This docker includes basic softwares of linux based on ubuntu:22.04
# Install python3.8,3.9,3.11
# Install anaconda Anaconda3-2023.09
# Install venv 3.8, 3.9,3.11
# Creat a virtual environment using 3.11
# CUDA 12.3 is installed but maybe not necessary
# Work directory project CMD ["/bin/bash"]


ENV LANG C.UTF-8
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive

ENV APT_INSTALL="apt-get install -y --no-install-recommends"
ENV PIP_INSTALL="python3 -m pip --no-cache-dir install --upgrade"
ENV GIT_CLONE="git clone --depth 10"

RUN apt-get update && \
    apt-get install -y apt-utils

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
    software-properties-common\
    nvidia-cuda-toolkit\
    python3-pip

RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.8 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

RUN apt-get install -y python3.9 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2

RUN apt-get install -y python3.11 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 3

RUN apt-get install -y python3-pip

RUN update-alternatives --set python3 /usr/bin/python3.8

RUN python3 --version && \
    python3.8 --version && \
    python3.9 --version && \
    python3.11 --version

RUN apt-get update && \
    apt-get install -y python3-dev build-essential libssl-dev libffi-dev libpq-dev

RUN apt-get install -y python3.8-venv

RUN apt-get install -y python3.9-venv

RUN apt-get install -y python3.11-venv

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
RUN apt-get update && apt-get install -y python3.11-venv python3-dev build-essential libssl-dev libffi-dev libpq-dev

# Create and activate a virtual environment
RUN python3.9 -m venv /opt/llm_env_3.9
RUN /opt/llm_env_3.9/bin/pip install --upgrade pip
RUN python3.8 -m venv /opt/llm_env_3.8
RUN /opt/llm_env_3.8/bin/pip install --upgrade pip
RUN python3.11 -m venv /opt/llm_env_3.11
RUN /opt/llm_env_3.11/bin/pip install --upgrade pip

WORKDIR /project
# RUN mkdir project
# COPY requirements.txt .
# RUN pip install -r requirements.txt
CMD ["/bin/bash"]


# RUN ln -s /usr/bin/python3.11 /usr/local/bin/python3 && \
#     ln -s /usr/bin/python3.11 /usr/local/bin/python

# ARG CUDA_VERSION=12.3.1
# RUN sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
# RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
# RUN sudo wget https://developer.download.nvidia.com/compute/cuda/12.3.1/local_installers/cuda-repo-ubuntu2004-12-3-local_12.3.1-545.23.08-1_amd64.deb
# RUN sudo dpkg -i cuda-repo-ubuntu2004-12-3-local_12.3.1-545.23.08-1_amd64.deb
# RUN sudo cp /var/cuda-repo-ubuntu2004-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
# RUN sudo apt-get update
# RUN sudo apt-get -y install cuda-toolkit-12-3
# ENV PATH=$PATH:/usr/local/cuda-12.3/bin
# ENV LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64

# RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-12.3/lib64' >> ~/.bashrc \
#     && echo 'export PATH=$PATH:/usr/local/cuda-12.3/bin' >> ~/.bashrc \
#     && echo 'export CUDA_HOME=/usr/local/cuda-12.3' >> ~/.bashrc

# RUN sudo rm -rf cuda
# RUN sudo ln -s /usr/local/cuda-12.3/  /usr/local/cuda

# docker run --runtime=nvidia -it docker.io/library/llm_env:1.1

# # Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
# ENV TINI_VERSION v0.6.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
# RUN chmod +x /usr/bin/tini
# ENTRYPOINT ["/usr/bin/tini", "--"]
# CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]


# lacking torch and jupyterlab
# jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root

# CUDA version and torch version control
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
# CUDA version update for CUDA 11.8
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run

# Install Toolkit 1.8
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
# sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
# sudo dpkg -i cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
# sudo cp /var/cuda-repo-ubuntu2204-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
# sudo apt-get -y install cuda

## Rebuild 
# docker build -t llm_env_cuda_without_python_dep:2.0 .
## not work

## Try docker images on docker hub

# docker pull nvidia/cuda:12.2.0-base-ubuntu22.04


## For example, I've chosen the project RAG as a sample proejct
# I'm trying to make the running environment and make sure that GPU can be used for training.

# install jupyter and ipykernel


## Try to install conda on images



# 缺少torch和jupyterlab
# 激活环境
# jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root

# CUDA version and torch version control
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
# CUDA version update for CUDA 11.8
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run

# Install Toolkit 1.8

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
# sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
# sudo dpkg -i cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
# sudo cp /var/cuda-repo-ubuntu2204-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
# sudo apt-get -y install cuda


# Pip install torch python版本对应的CUDA Torch 版本对应上才会下载 
# 转用conda 保证可用性
# 发现CUDA 10.1 不支持 ptyhon 3.11 安装python 3.9
# sudo apt update
# sudo apt install python3.9


# no docker image in container

# install gptq
# Cuda version is installed in tesla GPU not support pytorhc more than 1.13 so let's change the cuda version of the images.


# check version compatible :https://pytorch.org/get-started/previous-versions/
## Trying to install the version of 

## Only tesla GPU K60 ONLY support maximum 11.4 and torch 1.12 but the autogptq needs to minimum version of torch with 1.13
## impossible to fine-tuning large language model.

## Let's try on paperspace and singularity
## module

# AdVANCEE rag 02

# UBUNTU 22.4 doesn't support apt install 3.8 3.9 3.11