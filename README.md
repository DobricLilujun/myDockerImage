

# myDockerImage

This is a docker image that we can reuse it for our own project especially while doing deep learning and machine learning with cuda.


## Table of Contents

- [myDockerImage](#mydockerimage)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Building the Docker Image](#building-the-docker-image)

## Overview

There is a basic dockerfile in the project root respository and we can use it as a reference. 

Docker is an open-source platform for building, deploying, and running application containers. Its lightweight containers provide **"efficient resource utilization"** and **"fast startup and shutdown times"**. Docker containers are portable across different environments, enabling seamless deployment from development to production. The platform supports version control, ensuring consistent application versions across various settings. Additionally, Docker offers isolation between containers and the host system, facilitating secure and scalable application deployment. Its integration with automation tools allows for automated building, testing, and deployment of applications.

## Getting Started

Basically, the docker image is based on the docker file which usually based on a ubuntu docker image.

https://docs.docker.com/engine/install/ubuntu/

<mark style="background-color: light green">Attention: Running of docker need the administrator to grant you the specific docker run authority . You don't need a sudoer but you need ask for docker command authority which uses part of the sudoer authority.</mark>

The following command should be runnable for ubuntu system

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world
```



### Prerequisites

Install your own docker on your system by following the instruction:

### Building and usage of Docker Image

Build your own image by running this 

```bash
docker build -t your-image-name:tag .
# example
# docker build -t llm_env_conda:1.0 .
```

Get all docker images on the devices.

```bash
docker images
# possible results

REPOSITORY                                                                       TAG                                        IMAGE ID       CREATED          SIZE
llm_env_conda                                                                    1.0                                        38449d13aadc   40 minutes ago   13.3GB
```

Run your own image by running the following

--gpus all 指的是使用所有gpu

--it 指的是使用interactive的方式去执行，也就是你可以直接像linux系统一样进行操作

```bash
docker run --rm --gpus all -it llm_env_conda:1.0
```

<mark style="background-color: red">Attention: Please don't use other command like docker run nvidia etc because it's alread obsolete.</mark>



### Build environment with python

#### Choose the correct compatible python version

The compatible python version 

#### Use CONDA instead of venv



#### Verify the CUDA version with your graphical card and  torch version needed



#### Build your own images compatible to your project and push





Export and push your project online or build locally by your self using dockerfile. （login in docker）

```
Request is denied?
how to solve:
https://www.youtube.com/watch?v=iIYw0Z0AI1c
```



#### Online available docker image



1. **Choose the correct compatible python version**

2. **Suggest CONDA instead of venv** 

3. **Try to verify the corresponding CUDA version and find the latest compatible torch version to cuda and your graphical card ? how**

4. **Try to make sure CUDA is available ? How to make sure and how to verify?**

5. **Try to build your project locally and export the requirement.txt**

6. **Build your own images compatible to your project**

7. **Export and push your project online or build locally by your self using dockerfile. （login in docker）**

   ```
   
   ```





An example of using image and build your own image

Use the docker image in **paper space** instead of buiding env by your self

Cannot use docker but we can use other things 

Todo:

 How to use docker image in singularity



The docker image cannot be used in paper space . 

They already build the environment 

But we can still build our environment in hpc and other things .