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

# Makes Image Base Layer
.PHONY: image 
image:
	docker build $(MKFILE_DIR) -t $(IMAGE_NAME):$(IMAGE_TAG)

# Runs Container Image
.PHONY: container
container:
	docker run -it -e $(IMAGE_NAME):$(IMAGE_TAG) bash