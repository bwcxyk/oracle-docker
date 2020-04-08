FROM centos:7 as base

RUN yum install -y wget unzip binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 \
glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 \
libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 \
libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64 && yum clean all

COPY oracle_12c_install.sh \
oracle-12c-ee.rsp \
linuxx64_12201_database.zip \
/install/

RUN /install/oracle_12c_install.sh /install/oracle-12c-ee.rsp

FROM base

ENV INIT_MEM_PST 40
ENV ORACLE_SID=orcl
ENV ORACLE_HOME=/u01/app/oracle/product/12.2.0/db_1
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/12.2.0/db_1/bin
ENV DISPLAY :0
ENV VNC_PASSWORD oracle
ENV WEB_CONSOLE false
ENV MANUAL_DBCA false

RUN yum install -y epel-release && yum install -y xorg-x11-server-Xvfb x11vnc fluxbox xterm novnc && yum clean all

COPY entrypoint.sh /

EXPOSE 1521
EXPOSE 8080
EXPOSE 6800
VOLUME ["/docker-entrypoint-initdb.d"]

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]