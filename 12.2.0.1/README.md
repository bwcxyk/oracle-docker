### Image构建

```
1. 下载本目录的所有文件
2. 下载12.2.0.1 Patchset：linuxx64_12201_database.zip
3. 执行构建命令：
docker build -t oracle:12.2.0.1.0-ee .
```

### Image使用举例

```
docker run -d --name oracledb \
-p 1521:1521 \
-e INIT_MEM_PST=40
-e ORACLE_SID=orcl \
-e ORACLE_PWD=oracle \
-e ORACLE_CHARACTERSET=ZHS16GBK \
-v /data/oracle:/opt/oracle/oradata \
oracle:12.2.0.1.0-ee
```

