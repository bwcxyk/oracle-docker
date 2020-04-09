#!/bin/bash
# LICENSE GPL 3.0
#
# Copyright (c) 2019-2020 bwcx co,ltd. All rights reserved.
#
# Description: Starts the Listener and Oracle Database.
#              The ORACLE_HOME and the PATH has to be set.
# 
# 

# Check that ORACLE_HOME is set
if [ "$ORACLE_HOME" == "" ]; then
  script_name=`basename "$0"`
  echo "$script_name: ERROR - ORACLE_HOME is not set. Please set ORACLE_HOME and PATH before invoking this script."
  exit 1;
fi;

# Start Listener
lsnrctl start

# Start database
sqlplus / as sysdba << EOF
   STARTUP;
   exit;
EOF
