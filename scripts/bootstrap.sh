#!/bin/bash

function setup_ssh_keys() {
    if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
        curl -LO https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant
        mv vagrant /home/vagrant/.ssh/id_rsa
        chmod 400 /home/vagrant/.ssh/id_rsa
    fi

    if [ ! -f /home/vagrant/.ssh/id_rsa.pub ]; then
        curl -LO https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
        mv vagrant.pub /home/vagrant/.ssh/id_rsa.pub
        chmod 644 /home/vagrant/.ssh/id_rsa.pub
    fi
}

setup_ssh_keys
