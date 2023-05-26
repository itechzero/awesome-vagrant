#!/bin/bash

function setup_ssh_key() {
    if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
        curl -LO https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant
        if [ -f "vagrant" ]; then
          mv vagrant /home/vagrant/.ssh/id_rsa
          sudo chmod 400 /home/vagrant/.ssh/id_rsa
        fi
    fi

    if [ ! -f /home/vagrant/.ssh/id_rsa.pub ]; then
        curl -LO https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
        if [ -f "vagrant.pub" ]; then
          mv vagrant.pub /home/vagrant/.ssh/id_rsa.pub
          sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub
        fi

    fi
}

setup_ssh_key
