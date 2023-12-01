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
ENV VENV_NAME=llm_env_${PYTHON_VERSION}

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

# Create virtual environment and register kernel
RUN python${PYTHON_VERSION} -m venv /opt/${VENV_NAME} && \
    /opt/${VENV_NAME}/bin/pip install --upgrade pip && \
    /opt/${VENV_NAME}/bin/pip install ipykernel && \
    /opt/${VENV_NAME}/bin/python -m ipykernel install --user --name ENVNAME --display-name "${VENV_NAME} kernel"

# Activate the virtual environment
SHELL ["/bin/bash", "--login", "-c"]
RUN source /opt/${VENV_NAME}/bin/activate
RUN pip3 install --upgrade pip

####################################################################################################################################################
########################                                                                                                    ########################
########################                                User defined area                                                   ########################
########################                                                                                                    ########################
####################################################################################################################################################

# Method NUMBER 1
# Execute all the pip install commands here
# Installing requirements
# RUN pip install --upgrade langchain \
#     && pip install --upgrade llama-index \
#     && pip install --upgrade pydantic \
#     && pip install --upgrade openpyxl \
#     && pip install PyMuPDF \
#     && pip install --upgrade chromadb \
#     && pip install pysqlite3-binary \
#     && pip install sentence-

# # Storage
# RUN pip install --upgrade chromadb \
#     && pip install --upgrade pysqlite3-binary \
#     && pip install --upgrade llama-index \
#     && pip install typing-inspect==0.8.0 \
#     && pip install typing_extensions==4.5.0 \
#     && pip install --upgrade sentence-transformers \
#     && pip install faiss-gpu \
#     && pip install annoy \
#     && pip install qdrant-client \
#     && pip install fuzzywuzzy \
#     && pip install python-Levenshtein

# # Loading the documents
# RUN pip install --upgrade langchain \
#     && pip install --upgrade pydantic \
#     && pip install --upgrade openpyxl \
#     && pip install pypdf

# # Splitting the documents
# RUN pip install --upgrade transformers \
#     && pip install accelerate \
#     && pip install --upgrade auto_gptq \
#     && pip install --upgrade optimum

# # Storage
# RUN pip install --upgrade chromadb \
#     && pip install pysqlite3-binary

# # Defining QA Chain
# RUN pip install python-Levenshtein

# # Output
# RUN pip install aspose-words \
#     && pip install fpdf \
#     && pip install gradio

# RUN pip install --upgrade llama-index \
#     && pip install typing-inspect==0.8.0 \
#     && pip install typing_extensions==4.5.0 \
#     && pip install --upgrade langchain \
#     && pip install --upgrade pydantic

# Method NUMBER 2
# Replace the requirements.txt by a using pip freeze
COPY requirements.txt .
RUN pip install -r requirements.txt

# RUN while read requirement; do sudo pip3 install $requirement; done < requirements.txt


####################################################################################################################################################
########################                                                                                                    ########################
########################                                User defined area                                                   ########################
########################                                                                                                    ########################
####################################################################################################################################################

EXPOSE 8888 6006
CMD jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True
