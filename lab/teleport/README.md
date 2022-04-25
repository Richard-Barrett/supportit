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
make teardown
```
