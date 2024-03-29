MKFILE_DIR := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
IMAGE_NAME ?= rbarrett89/supportit
IMAGE_TAG ?= latest

UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
	GOOS := linux
endif
ifeq ($(UNAME_S),Darwin)
	GOOS := darwin
endif
ifeq ($(UNAME_S), Windows)
	GOOS := windows
endif

MOD_PATH := github.com/Richard-Barrett/supportit
DOCKER_FLAGS := -v $(MKFILE_DIR)

# Purge Teleport Containers
.PHONY: purge
purge: 
	docker container rm $(docker container ls -a | grep -i teleport | awk '{print $1}') --force

# Runs Container Image
.PHONY: container
container: 
	docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock \
	-v ${HOME}/.kube/config:/root/.kube/config \
	rbarrett89/supportit /bin/bash

# Makes Image Base Layer
.PHONY: image 
image:
	docker build $(MKFILE_DIR) -t $(IMAGE_NAME):$(IMAGE_TAG)