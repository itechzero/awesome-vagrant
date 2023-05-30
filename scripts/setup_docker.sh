#!/bin/bash

function setup_docker() {
  if [ -x "$(command -v docker)" ]; then
    warn "Docker already installed, skipping..."
    return 0
  fi

  local country=$(curl -sSL https://ipapi.co/country)
  info "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  if [ "$country" = "CN" ]; then
    sudo sh get-docker.sh --mirror Aliyun
  else
    sudo sh get-docker.sh
  fi

  rm get-docker.sh
  info "Docker installed successfully."

  if [ "$country" = "CN" ]; then
    info "Configuring Docker registry mirrors..."
    if [ ! -d "/etc/docker" ]; then
        sudo mkdir -p /etc/docker
    fi
    sudo tee /etc/docker/daemon.json <<-'EOF'
    {
      "registry-mirrors": ["https://gwsg6nw9.mirror.aliyuncs.com"]
    }
  EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    info "Docker registry mirrors configured successfully."
  fi

}

setup_docker
