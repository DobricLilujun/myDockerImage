FROM paperspace/gradient-base:pt112-tf29-jax0314-py39-20220803


# RUN apt-get update && \
#     apt-get install -y apt-utils

# RUN apt-get update && \
#     $APT_INSTALL \
#     apt-utils \
#     apt-transport-https \
#     wget \
#     git \
#     vim \
#     curl \
#     openssh-client \
#     unzip \
#     zip \
#     csvkit \
#     sudo \
#     software-properties-common\
#     nvidia-cuda-toolkit\
#     python3-pip


# COPY requirements.txt .
# RUN pip3 install -r requirements.txt

# RUN mkdir project
COPY requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 8888 6006

CMD jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True


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