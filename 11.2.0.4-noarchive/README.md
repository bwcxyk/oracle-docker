### Image构建

```
1. 下载本目录的所有文件
2. 下载11.2.0.4 Patchset：p13390677_112040_Linux-x86-64_1of7.zip p13390677_112040_Linux-x86-64_2of7.zip
3. 执行构建命令：
cd oracle-11g-ee-base
docker build -t oracle-11g-ee-base .
cd ..
docker build -t oracle:11.2.0.4-ee .
```

### Image使用举例

```
docker run --name <container name> \
-p <host port>:1521 -p <host port>:5500 \
-e ORACLE_SID=<your SID> \
-e ORACLE_PWD=<your database passwords> \
-e CHARACTER_SET=<your character set> \
-v [<host mount point>:]/opt/oracle/oradata \
oracle:11.2.0.4-ee

Parameters:
   --name:        The name of the container (default: auto generated)
   -p:            The port mapping of the host port to the container port. 
                  Two ports are exposed: 1521 (Oracle Listener), 5500 (OEM Express)
   -e ORACLE_SID: The Oracle Database SID that should be used (default: ORCL)
   -e ORACLE_PWD: The Oracle Database SYS, SYSTEM and PDB_ADMIN password (default: auto generated)
   -e CHARACTER_SET:
                  The character set to use when creating the database (default: AL32UTF8)
   -v /opt/oracle/oradata
                  The data volume to use for the database.
                  Has to be writable by the Unix "oracle" (uid: 54321) user inside the container!
                  If omitted the database will not be persisted over container recreation.
```

先修改目录权限

```bash
mkdir -p /data/oracle/{oradata,admin}
chown -R 54321:54321 /data/oracle/oradata
chown -R 54321:54321 /data/oracle/admin
```

```bash
docker run -d --name oracledb \
-p 1521:1521 \
-e ORACLE_SID=ORCL \
-e ORACLE_PWD=oracle \
-e CHARACTER_SET=AL32UTF8 \
-e TZ=Asia/Shanghai \
-v /data/oracle:/opt/oracle/oradata \
oracle:11.2.0.4-ee
```

> ORACLE_SID一定要大写，否则你会看到如下提示。
>
> ORA-01078: failure in processing system parameters
> LRM-00109: could not open parameter file '/opt/oracle/product/11.2.0/db_1/dbs/initorcl.ora'
