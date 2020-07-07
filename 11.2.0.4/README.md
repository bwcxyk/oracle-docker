## Oracle Database 11.2.0.4 Docker Image

Oracle官方在Github上提供了一些Oracle Docker image，但并未提供11g R2版本。考虑到目前仍有大量用户使用11g R2，所以，我们参考官方12.1版本image制作了11.2.0.4版本的image，并且在其基础上做了进一步丰富和标准化，包括：

- 指定是否开启归档

- 指定SGA及PGA大小

  > ORACLE给的建议是: OLTP系统SGA=(system_total_memory * 80%) * 80%，PGA=(system_total_memory * 80%) * 20%
  >
  > MEMORY_MAX_TARGET =SGA+PGA


- Online redo log自动调整为1G大小

- 设置用户名密码永不过期(虽不安全，但在绝大部分企业级用户均采用此实践)

- 关闭Concurrent Statistics Gathering功能


### Image构建

```
1. 下载本目录的所有文件
2. 下载11.2.0.4 Patchset：p13390677_112040_Linux-x86-64_1of7.zip p13390677_112040_Linux-x86-64_2of7.zip
3. 执行构建命令：
docker build -t oracle:11.2.0.4-ee .
```

### Image使用举例

```
docker run -d --name oracledb \
-p 1521:1521 \
-e ORACLE_SID=orcl \
-e ORACLE_PWD=oracle \
-e ORACLE_CHARACTERSET=AL32UTF8 \
-e SGA_SIZE=2560M \
-e PGA_SIZE=512M \
-e ENABLE_ARCH=true \
-v /data/oracle/oradata:/opt/oracle/oradata \
-v /data/oracle/archivelog:/opt/oracle/archivelog \
-v /data/oracle/orabak:/opt/oracle/orabak \
oracle:11.2.0.4-ee

```
