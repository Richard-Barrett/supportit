#Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="richard.barrett@goteleport.com"
LABEL version="0.1"
LABEL description="This is custom Docker Image for \
teleport labs."

# Bring in Environmental Variables for AWS, GCP, Azure
ENV AWS_ACCESS_KEY=${AWS_ACCESS_KEY}
ENV AWS_SECRET_KEY=${AWS_SECRET_KEY}
ENV AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

# Install Base Dependencies
RUN apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    tree \
    tar \
    zip \
    unzip \
    wget \
    apt-transport-https

# Download of Google Cloud Signing Key
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Adding Kubernetes Apt Repository
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

# Install Kubectl Tool
RUN apt-get update
RUN apt-get install -y kubectl
RUN kubectl version --client

# Install Supportit Application Essential Packages
RUN apt install -y python3

# Install Go go1.16.7
RUN curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
RUN sha256sum go1.16.7.linux-amd64.tar.gz
RUN tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

# Install Terraform 
RUN wget https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip
RUN unzip terraform_0.14.3_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform version

# TODO: FIGURE OUT HOW TO INSTALL TERRAFORM ON DOCKER WITH APT AND OFFICIAL GPG KEY AND RELEASE ON MAIN
# RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - 
# RUN aapt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# RUN apt update
# RUN apt install terraform


# Install Cloud Vendor CLI Tools
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

# TODO INSTALL AZURE CLI AND GOOGLE CLOUD CLI

# Supportit Application Initialize
COPY . /supportit
WORKDIR /supportit
ENTRYPOINT [ "/bin/bash" ]
CMD ["localhost"]