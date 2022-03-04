# SupportIt

Misc tooling

**WARNING:** content here is not necessarily safe for release to customers.
Use your best judgement before sending a script/tool to a customer for use.
If you haven't tested it yourself in a test lab, it's probably unsafe.
DO NOT blindly copy-paste tooling or scripts from this repo to customers.

![Image](https://github.com/Richard-Barrett/supportit/blob/main/.assets/supportit_logo.png)

A Repo for Support Engineering Labs

[![CodeQL](https://github.com/Richard-Barrett/supportit/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/codeql-analysis.yml)
[![Docker Image CI](https://github.com/Richard-Barrett/supportit/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/docker-image.yml)
[![Go](https://github.com/Richard-Barrett/supportit/actions/workflows/go.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/go.yml)
[![Greetings](https://github.com/Richard-Barrett/supportit/actions/workflows/greetings.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/greetings.yml)
[![Labeler](https://github.com/Richard-Barrett/supportit/actions/workflows/label.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/label.yml)
[![Terraform Validation](https://github.com/Richard-Barrett/supportit/actions/workflows/validate.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/validate.yml)
[![Release](https://github.com/Richard-Barrett/supportit/actions/workflows/release.yml/badge.svg)](https://github.com/Richard-Barrett/supportit/actions/workflows/release.yml)

## Directory Structure

1. `.assets/`
    - The assets directory for images and logos
2. `.deprecated/`
    - A directory for deprecated assets and code that can be used later if needed
3. `.github/`
    - The GitHub directory maintaining CICD Workflows and repository configuration files
4. `bin/`
    - The binary directory used for hosting the main binary wrapper built on Go
5. `cmd/`
    - The command directory used for hosting all command line code as a wrappable interface
6. `lab/`
    - Various resources that allows for the spin-up of labs via Docker, Docker-Compose, Kubernetes Manifests, and Terraform
7. `pkg/`
    - The binary server code that integrates with `cmd/` and `bin/` directories for the overall Go project.
8. `repros/`
    - The `repros/` directory houses common repros for engineers to have access to and fix using local components.
9   `tools/`
    - The `tools/` directory houses any utilities that can be shared for troubleshooting purposes and distributed.

## Labs

You can use the current repository as a lab. The repository is wrapped up and built into a container image that houses all of the tools needed to work with various cloud resources, toolings, and also allows you to connect to your local docker container. The docker container is very large as you are trying to simulate an actual workingspace that can bootstrap and spin up local docker resources via `docker` and `docker-compose`.

## How To Use The Repo

Inside this repo, there is a `Makefile`, the `Makefile` allows you to build local resources in a programatic way.
You can use the following methos to get started:

```bash
make image
make container
```

You will find that you build an image called `rbarrett/supportit` and run a container called `rbarrett/supportit` on your local.

**WARNING:** PLEASE MAKE A GITHUB ISSUE IF YOU ARE UNABLE TO BUILD THE IMAGE!!!

## What's In This Repo

Inside the `lab/` directory you will find various stacks available to you.
Simply go inside the directory with the `docker-compose.yaml` file and do the following within the CLI.

```bash
docker-compose up
```

The stack should build a local docker resources allowing for remote connection.
