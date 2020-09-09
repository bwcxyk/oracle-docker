#!/bin/bash
#
# Description: Sets up the unix environment for DB installation.
# 

# Setup filesystem and oracle user
# Adjust file permissions, go to /opt/oracle as user 'oracle' to proceed with Oracle installation
# ------------------------------------------------------------
set -x

groupadd dba \
  &&    useradd -m -G dba oracle \
  &&    mkdir /u01 \
  &&    chown oracle:dba /u01
yum install -y openssl \
    make \
    gcc \
    binutils \
    gcc-c++ \
    compat-libstdc++ \
    elfutils-libelf-devel \
    elfutils-libelf-devel-static \
    ksh \
    libaio \
    libaio-devel \
    numactl-devel \
    sysstat \
    unixODBC \
    unixODBC-devel \
    pcre-devel \
    glibc.i686 \
    unzip \
    sudo \
    wget \
  &&    yum clean all