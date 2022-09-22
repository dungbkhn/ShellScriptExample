#!/bin/bash
#
# A bash script for installing latest Python 3 on your Debian, Ubuntu or Mint server.

apt update -y

apt upgrade -y

apt install software-properties-common -y

add-apt-repository ppa:deadsnakes/ppa -y

apt install python3.9 -y

apt-get install gir1.2-appindicator3 -y
