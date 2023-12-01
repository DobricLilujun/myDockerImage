# How to build and use docker images 

This is a small tutorial to guide you how to build and use the docker images in paperspace

## Prerequest

1. A **docker image** you want to in the paperspace. As in foyer project, we can use the following github respository as a basic build images. 

​	[Github Repository link for the docker images building](https://github.com/DobricLilujun/myDockerImage.git)

2. And you need to have your **docker** installed on your system.

​	[Docker Installation Tutorial](https://docs.docker.com/engine/install/)

3. **Your project** prepared with your python virtual environment and have python, cuda and torch version in your mind.

   I recommend you to use conda but only pip is okay.  You can check the torch and cuda version control from this: https://pytorch.org/blog/deprecation-cuda-python-support/

4. An account of Docker Hub

## Step by Step tutorial

Following the follwowing:

```cmd
# Git clone the docker repo
git clone https://github.com/DobricLilujun/myDockerImage.git
cd myDockerImage/

# Check Docker Follw
docker --version  # Docker version 24.0.2, build cb74dfc

# Check if you are in the right environment
source activate [Your path to env]/bin/activate  # if you use conda: conda activate [Your env name]

# Two method to export your python env
# Method NUMBER 1: Replace the requirements.txt by a using pip freeze
pip freeze > requirements.txt
# Method NUMBER 2: Execute all the pip install commands here and fill all commends in dockerfiles

# Login to your docker account
docker login  # input your docker username and password
```

Try to build the docker image and push it to docker hub

**Attention**: If you fail to build some images, slight change the docker file but choose the same image name but different versions which can save a lot of time in building 

```cmd
# Build and push your own docker image 
# If you push an image and you found the error of Request is denied, then follow this instruction to solve it: https://www.youtube.com/watch?v=iIYw0Z0AI1c
# Template
docker build -t [Your image name]:[Your image version] .
docker tag [Your image name]:[Your image version] [dockerhub username]/[Your image name]:[Your image version]
docker push [dockerhub username]/[Your image name]:[Your image version]
```

The following is an example I use:

```cmd
# Building
docker build -t llm_docker_test:1.0 .
# Running and test
docker run -t llm_docker_test:1.0
# Tag
docker tag llm_docker_test:1.0 lujunlicareerist/llm_docker_test:1.0
# Push
docker push lujunlicareerist/llm_docker_test:1.0

```

## Use it from paperspace

1. Create one notebook

2. Choose start from Scratch

3. Choose "View advanced options"

4. Choose the docker imaged you created: 

![4](https://raw.githubusercontent.com/DobricLilujun/imagesAll/main/images4.PNG)

5. Input your github details

   ![5](https://raw.githubusercontent.com/DobricLilujun/imagesAll/main/images5.PNG)

6. Only input [docker_user_name]/[docker_image_name]:[image_version] is enough to start the images

![6](https://raw.githubusercontent.com/DobricLilujun/imagesAll/main/images6.PNG)

Enjoy it!
