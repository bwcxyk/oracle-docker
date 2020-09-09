# Pull base image
# ---------------
FROM oracle-11g-ee-base:latest

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV ORACLE_SID=orcl \
    CHARACTER_SET=AL32UTF8 \
    ORACLE_PWD=oracle \
    DBCA_TOTAL_MEMORY=4096 \
    ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/11.2.0/db_1/bin  


COPY entrypoint.sh /entrypoint.sh

EXPOSE 1521

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]