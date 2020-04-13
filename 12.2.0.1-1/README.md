**该镜像不启用Oracle12C的新特性PDB**

### Image构建

```
1. 下载本目录的所有文件
2. 下载12.2.0.1 Patchset：linuxx64_12201_database.zip
3. 执行构建命令：
docker build -t oracle:12.2.0.1-ee .
```

### Image使用举例

```
docker run --name <container name> \
-p <host port>:1521 -p <host port>:5500 \
-e ORACLE_SID=<your SID> \
-e ORACLE_PWD=<your database passwords> \
-e ORACLE_CHARACTERSET=<your character set> \
-v [<host mount point>:]/opt/oracle/oradata \
oracle:12.2.0.1-ee

Parameters:
   --name:        The name of the container (default: auto generated)
   -p:            The port mapping of the host port to the container port. 
                  Two ports are exposed: 1521 (Oracle Listener), 5500 (OEM Express)
   -e ORACLE_SID: The Oracle Database SID that should be used (default: ORCLCDB)
   -e ORACLE_PWD: The Oracle Database SYS, SYSTEM and PDB_ADMIN password (default: auto generated)
   -e ORACLE_CHARACTERSET:
                  The character set to use when creating the database (default: AL32UTF8)
   -v /opt/oracle/oradata
                  The data volume to use for the database.
                  Has to be writable by the Unix "oracle" (uid: 54321) user inside the container!
                  If omitted the database will not be persisted over container recreation.
   -v /opt/oracle/scripts/startup | /docker-entrypoint-initdb.d/startup
                  Optional: A volume with custom scripts to be run after database startup.
                  For further details see the "Running scripts after setup and on startup" section below.
   -v /opt/oracle/scripts/setup | /docker-entrypoint-initdb.d/setup
                  Optional: A volume with custom scripts to be run after database setup.
                  For further details see the "Running scripts after setup and on startup" section below.
```

```bash
docker run -d --name oracledb \
-p 1521:1521 \
-e ORACLE_SID=orcl \
-e ORACLE_PWD=oracle \
-e ORACLE_CHARACTERSET=ZHS16GBK \
-v /data/oracle:/opt/oracle/oradata \
oracle:12.2.0.1-ee
```

注意挂载目录时需要修改宿主机目录权限

```bash
mkdir /data/oracle
chown 1000.1000 /data/oracle
```

即把宿主机目录调整为与容器oracle用户id一致