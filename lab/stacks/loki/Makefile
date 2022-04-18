MKFILE_DIR := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))

UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
	GOOS := linux
endif
ifeq ($(UNAME_S),Darwin)
	GOOS := darwin
endif
ifeq ($(UNAME_S), Windows))
	GOOS := windows
endif

.PHONY: build
build:
	docker-compose -f docker-compose.yaml build

.PHONY: lab
lab:
	docker-compose -f docker-compose.yaml up -d

.PHONY: teardown
teardown:
	docker-compose down