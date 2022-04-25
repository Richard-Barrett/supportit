#!/usr/bin/env/bash -e

create_machineid_systemdservice () {
    cat << EOF > /etc/systemd/system/machine-id.service
    [Unit]
    Description=Teleport Machine ID Service
    After=network.target

    [Service]
    Type=simple
    User=teleport
    Group=teleport
    Restart=on-failure
    ExecStart=/usr/local/bin/tbot start -c /etc/tbot.yaml
    ExecReload=/bin/kill -HUP $MAINPID
    PIDFile=/run/machine-id.pid
    LimitNOFILE=8192

    [Install]
    WantedBy=multi-user.target
    EOF
}

start_machineid_systemdservice () {
    systemctl daemon reload;
    systemctl start machine-id;
    systemctl status machine-id
}

enable_machine_id_systemdservice () {
    systemctl enable machine-id
}