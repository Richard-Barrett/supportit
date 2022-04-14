# Download base image ubuntu 20.04
##################
#   BASE IMAGE   #
##################
# Implement a Cache Multistage Build
FROM ubuntu:20.04 as base

# LABEL about the custom image
LABEL maintainer="richard-barrett@outlook.com"
LABEL version="0.1"
LABEL description="This is custom Docker Image for teleport labs."

# Bring in Environmental Variables for AWS, GCP, Azure
ARG AWS_ACCESS_KEY=${AWS_ACCESS_KEY}
ENV AWS_ACCESS_KEY=${AWS_ACCESS_KEY}
ARG AWS_SECRET_KEY=${AWS_SECRET_KEY}
ENV AWS_SECRET_KEY=${AWS_SECRET_KEY}
ARG AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
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
    openssl \
    git \
    zip \
    unzip \
    wget \
    apt-transport-https

#############
# Kube Base #
#############
# Download of Google Cloud Signing Key
FROM base as kubebase
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Adding Kubernetes Apt Repository
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

# Install Kubectl Tool
RUN apt-get update
RUN apt-get install -y kubectl
RUN kubectl version --client

# Install Supportit Application Essential Packages
RUN apt install -y python3

###########
# Go Base #
###########
FROM kubebase as gobase
# Install Go go1.16.7
RUN curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
RUN sha256sum go1.16.7.linux-amd64.tar.gz
RUN tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

##################
# Terraform Base #
##################
# Install Terraform 
FROM gobase as terraformbase
RUN wget https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip
RUN unzip terraform_0.14.3_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform version

# Install Docker and Docker-Compose
FROM terraformbase as dockerbase
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

##################################
# Install Cloud Vendor CLI Tools #
##################################
# Install AWS CLI
FROM dockerbase as cloudvendorbase
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

# Install Azure CLI
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Google Cloud CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update && apt-get install google-cloud-sdk

####################################
# Install Teleport As teleportbase #
####################################
FROM cloudvendorbase as teleportbase
RUN git clone https://github.com/gravitational/teleport \
    && cd teleport/examples/aws/terraform/ha-autoscale-cluster \
    && terraform init \
    && cd ~

#############################
# Install Helm via helmbase #
#############################
FROM teleportbase as helmbase
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \ 
    && chmod +x get_helm.sh \
    && bash ./get_helm.sh

#####################################
# Install Troubleshooting CLI Tools #
#####################################
FROM helmbase as toolsbase
RUN apt-get install -y traceroute \
    openssh-server \
    bind9-utils \
    dnsutils \
    iftop \
    vnstat \
    iperf3 \
    htop \
    net-tools \
    tcpdump \
    slapd \
    ldap-utils

##############################
# Install Trivy as trivybase #
##############################
FROM toolsbase as trivybase
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - \
    && echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list \
    && apt-get update \
    && apt-get install trivy

#######################################################
# TODO MAKE LAB DIRECTORIES FOR TERRAFORM As Labsbase #
#######################################################
FROM trivybase as labsbase
RUN mkdir -p git/terraform/ \
    && git clone https://github.com/gravitational/teleport.git /git/terraform \
    && git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster /git/terraform/aws \
    && git clone https://github.com/scholzj/terraform-aws-minikube /git/terraform/aws/minikube \
    && git clone https://github.com/hashicorp/learn-terraform-provision-aks-cluster /git/terraform/azure \
    && git clone https://github.com/hashicorp/learn-terraform-provision-gke-cluster /git/terraform/gcp

################################################
# Supportit Application Initialize FINAL IMAGE #
################################################
FROM labsbase as supportit
COPY . /supportit
WORKDIR /supportit
ENTRYPOINT service ssh start && bash
CMD ["localhost"]
