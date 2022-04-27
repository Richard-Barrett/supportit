# Teleport Labs

To use the Teleport Labs, ensure that you have the following variable `export`ed or `set`.

```bash
export TELEPORT_VERSION-"VERSION"
```

Example:

```bash
export TELEPORT_VERSION-"9"

```

The above will use 9 as the current version of Teleport.
You can test the variable by using `printenv` or `echo $TELEPORT_VERSION`. 

## Using the Makefile

You can use the `Makefile` to build the lab image, make your lab, teardown the lab, and clearteleport images.

```bash
make build
make clearteleport
make lab
make showteleport
make teardown
```

## Using Teleport Labs with Docker-Compose

To use Teleport with `Docker-Compose` you can read up on what to do [HERE](https://goteleport.com/docs/getting-started/docker-compose/):
- Export the TELEPORT_VERSION
- Make the lab with the `make lab` command to spin up the teleport infrastructure
- Show the containers that are spun up with the Docker-Compose File with `make showteleport`
- Teardown the Lab with the `make teardown` command

You can explore the containers by execing into each container. 
The four containers that are spun up are:
- openssh
- teleport
- teleport-bootstrap
- term

The `term` container is the main container that you can exec into with:

```bash
docker exec -ti term /bin/bash
```

Once you login you can start working with exploring the environment via the documentation [HERE](https://goteleport.com/docs/getting-started/docker-compose/)

## Working with Teleport Lab Using The SupportIT Container

You can work with any of the labs using your local docker socket, which will allow you to spin up resources on your local within a container. 
Furthermore the [SupportIT Container](https://github.com/Richard-Barrett/supportit/blob/main/Dockerfile) can also support the local Kubernetes.
If you want to use the [SupportIT Container](https://github.com/Richard-Barrett/supportit/blob/main/Dockerfile) go to the root of this repository:
- Use the Local `Makefile` at the root
- Build the image with `make image` command
- Run and Exec into the `SupportIT` docker container with the `make container` command

You will have access to everything in this repo from within a container and can run docker-compose and kubernetes using local docker/kube contexts.
