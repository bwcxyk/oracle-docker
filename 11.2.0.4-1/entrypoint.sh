#!/bin/bash
set -e
#set -x

# Prevent owner issues on mounted folders
echo "Preparing oracle installer."
chown -R oracle:dba /u01/app/oracle
rm -f /u01/app/oracle/product
ln -s /u01/app/oracle-product /u01/app/oracle/product

#Run Oracle root scripts
echo "Running root scripts."

/u01/app/oraInventory/orainstRoot.sh 2>&1
echo | /u01/app/oracle/product/11.2.0/db_1/root.sh 2>&1 || true

# Replace place holders in response file
cp $INSTALL_DIR/$CONFIG_RSP $ORACLE_BASE/dbca.rsp
sed -i -e "s|###ORACLE_SID###|$ORACLE_SID|g" $ORACLE_BASE/dbca.rsp
sed -i -e "s|###ORACLE_PWD###|$ORACLE_PWD|g" $ORACLE_BASE/dbca.rsp
sed -i -e "s|###CHARACTER_SET###|$CHARACTER_SET|g" $ORACLE_BASE/dbca.rsp
sed -i -e "s|###TOTALMEMORY###|$DBCA_TOTAL_MEMORY|g" $ORACLE_BASE/dbca.rsp

case "$1" in
	'')
		#Check for mounted database files
		if [ "$(ls -A /u01/app/oracle/oradata)" ]; then
			echo "found files in /u01/app/oracle/oradata Using them instead of initial database"
			echo "$ORACLE_SID:$ORACLE_HOME:N" >> /etc/oratab
			chown oracle:dba /etc/oratab
			chown 664 /etc/oratab
			rm -rf /u01/app/oracle-product/11.2.0/db_1/dbs
			ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/db_1/dbs
			#Startup Database
			su oracle -c "/u01/app/oracle/product/11.2.0/db_1/bin/tnslsnr &"
			su oracle -c 'echo startup\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'
		else
			echo "Database not initialized. Initializing database."

			if [ -z "$CHARACTER_SET" ]; then
				export CHARACTER_SET="AL32UTF8"
			fi

			#printf "Setting up:\nprocesses=$processes\nsessions=$sessions\ntransactions=$transactions\n"

			mv /u01/app/oracle-product/11.2.0/db_1/dbs /u01/app/oracle/dbs
			ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/db_1/dbs

			echo "Starting tnslsnr"
			su oracle -c "/u01/app/oracle/product/11.2.0/db_1/bin/tnslsnr &"
			#create DB for SID: $ORACLE_SID
			echo "Running initialization by dbca"
			su oracle -c "$ORACLE_HOME/bin/dbca -initParams java_jit_enabled=false -silent -createDatabase -responseFile $ORACLE_BASE/dbca.rsp -redoLogFileSize 1024"
			#su oracle -c "$ORACLE_HOME/bin/dbca -initParams java_jit_enabled=false -silent -createDatabase -templateName General_Purpose.dbc -gdbname $ORACLE_SID.oracle.docker -sid $ORACLE_SID -responseFile NO_VALUE -characterSet $CHARACTER_SET -totalMemory $DBCA_TOTAL_MEMORY -emConfiguration NONE -dbsnmpPassword oracle -sysPassword oracle -systemPassword oracle"
			cat /u01/app/cfgtoollogs/dbca/$ORACLE_SID/$ORACLE_SID.log
			
		fi

		echo "Database ready to use. Enjoy! ;)"

		##
		## Workaround for graceful shutdown.
		##
		while [ "$END" == '' ]; do
			sleep 1
			trap "su oracle -c 'echo shutdown immediate\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'" INT TERM
		done
		;;

	*)
		echo "Database is not configured. Please run '/entrypoint.sh' if needed."
		exec "$@"
		;;
esac
