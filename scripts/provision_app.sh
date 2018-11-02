#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export APTARGS="-q -o=Dpkg::Use-Pty=0"

apt-get update ${APTARGS}
apt-get install python-mysqldb unzip ${APTARGS}
apt-get clean ${APTARGS}