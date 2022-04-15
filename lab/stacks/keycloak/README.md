# Keycloak Lab with Teleport

## Steps to Integrate Keycloak to Teleport

- 1. You can use admin/password as a default
- 2. Set them as environmnet variables with the `export` command
- 3. Run `make build` to build (OPTIONAL) the image `make lab` in the current directory to make the `Keycloak+Teleport` lab

## Requirements for Lab To Work

You Need to Set the Following Variables to make it work:
- `TELEPORT_VERSION`
- `POSTGRES_PASSWORD`
- `POSTGRES_ROOT_PASSWORD`
- `DB_PASSWORD`
- `KEYCLOAK_PASSWORD`
- `GF_SECURITY_ADMIN_PASSWORD`

- You must export or set the `TELEPORT_VERSION` for the `${TELEPORT_VERSION}` within the compose file to pick up what version of teleport you want to spin up.
- you can export the value into your local shell as follows:

```bash
export TELEPORT_VERSION="9"
```

If you do not set the `TELEPORT_VERSION`, you will encounter an error as follows:

```bash
ERROR: no such image: quay.io/gravitational/teleport-lab:: invalid reference format
make: *** [lab] Error 1
```

- Set the `TELEPORT_VERSION` as such:

```bash
export TELEPORT_VERSION="9"
```

## Using The Makefile

To make the lab type in the following:

```bash
make lab
```

You should see something similar to the following

```bash

```

If you don't set any of the variables it will warn you in the output:

```bash
WARNING: The MYSQL_PASSWORD variable is not set. Defaulting to a blank string.
```

NOTE**: ENSURE YOU SET ANY VARIABLES DEFINED IN THE DOCKER COMPOSE FILE

## Working With Teleport in The Docker Container

To get a full view of teleport on your local, read the following guide on how to get started:
- [Getting Started](https://goteleport.com/docs/getting-started/docker-compose/)