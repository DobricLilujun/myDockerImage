FROM ubuntu:20.04
RUN yes | unminimize

ENV LANG C.UTF-8
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive
ENV APT_INSTALL="apt-get install -y --no-install-recommends"
ENV PIP_INSTALL="python3 -m pip --no-cache-dir install --upgrade"
ENV GIT_CLONE="git clone --depth 10"


# Set Python version and virtual environment name as environment variables
ENV PYTHON_VERSION=3.8
# Define environment variables
ENV VENV_NAME=llm_env_${PYTHON_VERSION}
ENV VENV_NAME_AUX=llm_env_aux${PYTHON_VERSION}


# Install necessary packages and set Python version
RUN apt-get update && \
    apt-get install -y \
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
    nvidia-cuda-toolkit \
    python3-pip && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    libpq-dev && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1 && \
    apt-get install -y python3-pip python${PYTHON_VERSION}-venv


RUN update-alternatives --set python3 /usr/bin/python${PYTHON_VERSION}
RUN ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python3
RUN ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python

# Create virtual environment and register kernel1
RUN python${PYTHON_VERSION} -m venv /opt/${VENV_NAME} && \
    /opt/${VENV_NAME}/bin/pip install --upgrade pip && \
    /opt/${VENV_NAME}/bin/pip install ipykernel && \
    /opt/${VENV_NAME}/bin/python -m ipykernel install --user --name ENVNAME --display-name "${VENV_NAME} kernel"


# Create virtual environment and register kernel2
RUN python${PYTHON_VERSION} -m venv /opt/${VENV_NAME_AUX} && \
    /opt/${VENV_NAME_AUX}/bin/pip install --upgrade pip && \
    /opt/${VENV_NAME_AUX}/bin/pip install ipykernel && \
    /opt/${VENV_NAME_AUX}/bin/python -m ipykernel install --user --name ENVNAME --display-name "${VENV_NAME_AUX} kernel"


# Install Python dependency
RUN /opt/${VENV_NAME}/bin/pip install --upgrade pip
COPY requirements.txt .
RUN /opt/${VENV_NAME}/bin/pip install -r requirements.txt
RUN /opt/${VENV_NAME_AUX}/bin/pip install --upgrade pip
RUN /opt/${VENV_NAME_AUX}/bin/pip install -r requirements.txt

RUN pip install --upgrade pip
RUN pip install jupyterlab
RUN pip install jupyterlab-snippets


EXPOSE 8888 6006
CMD jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True
