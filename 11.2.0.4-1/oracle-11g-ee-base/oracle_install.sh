#!/bin/bash

set -e

#Delete limits cause of docker limits issue
cat /etc/security/limits.conf | grep -v oracle | tee /etc/security/limits.conf

# Replace place holders
# ---------------------
sed -i -e "s|###ORACLE_BASE###|$ORACLE_BASE|g" $INSTALL_DIR/$INSTALL_RSP && \
sed -i -e "s|###ORACLE_HOME###|$ORACLE_HOME|g" $INSTALL_DIR/$INSTALL_RSP

echo 'Unzipping'
cd $INSTALL_DIR
unzip -q linux.x64_11gR2_database_1of2.zip
unzip -q linux.x64_11gR2_database_2of2.zip
rm -f linux*.zip

mv database /home/oracle/

su oracle -c 'cd /home/oracle/database && ./runInstaller -ignorePrereq -ignoreSysPrereqs -silent -responseFile $INSTALL_DIR/$INSTALL_RSP -waitForCompletion 2>&1'
rm -rf /home/oracle/database

mv /u01/app/oracle/product /u01/app/oracle-product