#!/bin/bash
# LICENSE GPL 3.0
#
# Copyright (c) 2012-2018 Hangzhou WOQUTECH co,ltd. All rights reserved.
#
# Description: Checks the status of Oracle Database.
# Return codes: 0 = Database is open and ready to use
#               1 = Database is not open
#               2 = Sql Plus execution failed
#               3 = Standby Database is in MOUNTED mode WITH APPLY.
#               4 = Standby Database is in READ ONLY WITH APPLY mode. 
# 

ORACLE_SID="`grep $ORACLE_HOME /etc/oratab | cut -d: -f1`"
ORAENV_ASK=NO
source oraenv

# Check Oracle DB status and store it in status

status=`sqlplus -s / as sysdba << EOF
   set heading off;
   set pagesize 0;
   select open_mode from v\\$database;
   exit;
EOF`
  
# Store return code from SQL*Plus
ret=$?


# SQL Plus execution was successful
if [ $ret -eq 0 ] ; then
   exit 0;
# SQL Plus execution failed
else
   exit 2;
fi;
