# Lab

The following labs are available.
Each lab has a `docker-compose.yaml` setup, as well as an accompnaying Kubernetes Manifests directory.
As such the labs have the following directory structure:

```bash
lab
├── docker-compose.yaml
└── manifests
    └── README.md
```

There are two components to this `lab/` setup (Ingtgrations|Teleport Components):

1. `Integrations` inside the `stacks/` directory
    - We use Docker-Compose within the `stacks/` directory to spin up integrations that can be used with Teleport locally.
2. `Teleport Components` used and housed in a manner that matches and/or mimics current `docs` at Teleport.
    - We use local Teleport Resources and build Teleport components locally.

All labs are built and based off of the following Teleport documentation:

- <https://goteleport.com/docs/>

TODO ADD AN IMAGE

## Directory Structure

1. `apis/`
    - API is the directory used to mimic [API](https://goteleport.com/docs/api/introduction/)
2. `applications/`
    - Is the direcotry used to mimic [Application Access](https://goteleport.com/docs/application-access/introduction/)
3. `baremetal`
    - Baremetal is the directory used to mimic on-prem installations with SSH [Server-Access](https://goteleport.com/docs/server-access/introduction/)
4. `databases`
    - Databases is used to mimic [Database Access](https://goteleport.com/docs/database-access/introduction/)
5. `desktops`
    - Desktops is the directory used to mimic [Desktop Access](https://goteleport.com/docs/desktop-access/introduction/)
6. `idpintegrations`
    - Idpintegrations is the directory used to mimic SSO [SSO](https://goteleport.com/docs/enterprise/sso/)
7. `kubernetes`
    - Kubernetes is the directory used to mimic Kubernetes Access [Kubernetes](https://goteleport.com/docs/kubernetes-access/introduction/)
8. `minikube`
    - A Terraform Configuration to help you spin up minikube on aws [minikube](https://registry.terraform.io/modules/scholzj/minikube/aws/latest)
9. `stacks`
    - Stacks direcotry is used to mimic various microservice platforms and integrations to teleport
10. `teleport`
    - telport is the actual lab and/or infra to spin up via `docker-compose` files.
11. `vagrant`
    - Vagrant stack to spin up teleport infrastructure.

## Using Stacks

To use the `stacks/` directory and any `stack` that is housed within, you will need to first ensure you have `docker` and `docker-compose` installed on your local machine.

After installing the requirements, all you have to do is simply change into a `stacks/` directory of your choice and spin up local resources using the following command:

```bash
docker-compose up
```

## Using Teleport

NOTE**: TELEPORT VERSIONS 6-8 WORK, 9 DOES NOT WORK!!!
Using Teleport:

1. Ensure you have logged into the local lab from the root directory of this repository:
    - `make container` will make and run the container using docker in docker or a volume set back to use your local docker host socket.
2. Once in the `docker` container you will see the lab layout and it should be similar to the overall repository structure.
3. Change into the `lab/` directory and then move further into the `lab/teleport` directory:
    - Use `ls` and you will see what versions of `teleport` are accessible via the `lab/`
    - Use `cd` to login to one of those directories with the version of your choice
4. Once you have chosen which lab you want to spin up, simple use `docker-compose up` to spin up local resources

```bash
docker-compose up -f docker-compose.yaml -d
```

This will spin up the resources, you can then use the following to exec into those resources from within the lab.

1. `docker container ls`
    - list out the docker containers available and grab the container ID from the CONTAINER_ID column
2. `docker container exec -it container_id /bin/bash`
    - Docker exec command to go into the container interactivelly with TTY Session

## Using Vagrant

TODO
