#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2016 Oracle and/or its affiliates. All rights reserved.
#
# Since: December, 2016
# Author: gerald.venzl@oracle.com
# Description: Sets up the unix environment for DB installation.
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

# Setup filesystem and oracle user
# Adjust file permissions, go to /opt/oracle as user 'oracle' to proceed with Oracle installation
# ------------------------------------------------------------
mkdir -p $ORACLE_BASE/oradata && \
chmod ug+x $ORACLE_BASE/$RUN_FILE && \
chmod ug+x $ORACLE_BASE/$CREATE_DB_FILE && \
yum install -y openssl make gcc binutils gcc-c++ compat-libstdc++ elfutils-libelf-devel elfutils-libelf-devel-static ksh libaio libaio-devel numactl-devel sysstat unixODBC \ unixODBC-devel pcre-devel glibc.i686 unzip sudo
groupadd dba
useradd -G dba -d /home/oracle oracle
echo "oracle ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
mkdir -p $ORACLE_HOME
mkdir -p $ORACLE_BASE/oradata
mkdir -p $ORACLE_BASE/oraInventory
chown -R oracle:dba $ORACLE_BASE/product
chown -R oracle:dba $ORACLE_BASE/oraInventory
chown -R oracle:dba $ORACLE_BASE/oradata
chmod -R 775 $ORACLE_BASE/product
chmod -R 775 $ORACLE_BASE/oradata
chmod -R 775 $ORACLE_BASE/oraInventory
echo oracle:oracle | chpasswd && \
chown -R oracle:dba $ORACLE_BASE