# MySQL Docker Compose with Teleport

## Steps to Integrate MySQL to Teleport

- 1. Use root/example as user/password credentials for MySQL
- 2. Set them as environmnet variables
- 3. Run `make build` to build (OPTIONAL) the image `make lab` in the current directory to make the `MySQL+Teleport` lab

## Requirements for Lab To Work

- You must export or set the `TELEPORT_VERSION` for the `${TELEPORT_VERSION}` within the compose file to pick up what version of teleport you want to spin up.
- You must specify the `MYSQL_PASSWORD` for the `${MYSQL_PASSWORD}` within the compose file to pick up the password for the `MySQL` database password

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
 rbarrett@RBARRETT-MBP13-1881  ~/Git/Teleport/supportit/lab/stacks/mysql   Richard-Barrett-patch13  make lab                      ✔  7365  15:50:22
Makefile:10: Extraneous text after `ifeq' directive
docker-compose -f docker-compose.yml up -d

Creating mysql_db_1      ... done
Creating teleport        ... done
Creating mysql_adminer_1    ... done
Creating teleport-bootstrap ... done
Creating term               ... done
Creating openssh            ... done
```

If you don't set any of the variables it will warn you in the output:

```bash
❯ make lab
Makefile:10: Extraneous text after `ifeq' directive
docker-compose -f docker-compose.yaml up -d
WARN[0000] The "TELEPORT_VERSION" variable is not set. Defaulting to a blank string.
WARN[0000] The "TELEPORT_VERSION" variable is not set. Defaulting to a blank string.
WARN[0000] The "TELEPORT_VERSION" variable is not set. Defaulting to a blank string.
WARN[0000] The "TELEPORT_VERSION" variable is not set. Defaulting to a blank string.
WARN[0000] The "POSTGRES_PASSWORD" variable is not set. Defaulting to a blank string.
WARN[0000] The "POSTGRES_ROOT_PASSWORD" variable is not set. Defaulting to a blank string.
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string.
WARN[0000] The "KEYCLOAK_PASSWORD" variable is not set. Defaulting to a blank string.
WARN[0000] The "GF_SECURITY_ADMIN_PASSWORD" variable is not set. Defaulting to a blank string.
Error response from daemon: no such image: quay.io/gravitational/teleport-lab:: invalid reference format
make: *** [lab] Error 1
```

NOTE**: ENSURE YOU SET ANY VARIABLES DEFINED IN THE DOCKER COMPOSE FILE

## Working With Teleport in The Docker Container

To get a full view of teleport on your local, read the following guide on how to get started:
- [Getting Started](https://goteleport.com/docs/getting-started/docker-compose/)

