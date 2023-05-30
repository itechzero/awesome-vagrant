#!/bin/bash

function setup_docker() {
  if [ -x "$(command -v docker)" ]; then
    warn "Docker already installed, skipping..."
    return 0
  fi

  local access_google=false
  local url="google.com"
  local ping_output=$(ping -c 1 "$url" 2>&1)
  # 检查ping命令的退出状态码和ping_output的内容
  if [ $? -eq 0 ] && [[ $ping_output == *"1 packets transmitted, 1 received"* ]]; then
      access_google=true
  fi

  info "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  if [ ! "$access_google" ]; then
    sudo sh get-docker.sh --mirror Aliyun
  else
    sudo sh get-docker.sh
  fi

  sudo rm get-docker.sh
  info "Docker installed successfully."

  if [ ! "$access_google" ]; then
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
