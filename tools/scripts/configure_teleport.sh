#!/bin/bash -e

# SYSTEM VARIABLES
TELEPORT_USERS=${cat users/users.txt}

# Create Teleport User
teleport_create_users () {
    for i in ${TELEPORT_USERS}};
        do tctl users add ${TELEPORT_USERS} --roles=editor,access --logins=root,ubuntu | tee /tmp/token.txt;
    done
}

show_tokens () {
    cat /tmp/token.txt
}

