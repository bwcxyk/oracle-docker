# Pull base image
# ---------------
FROM centos:7.6.1810

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV ORACLE_BASE=/u01/app \
    ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1 \
    INSTALL_FILE_1="linux.x64_11gR2_database_1of2.zip" \
    INSTALL_FILE_2="linux.x64_11gR2_database_2of2.zip" \
    INSTALL_RSP="db_inst.rsp" \
    CONFIG_RSP="dbca.rsp.tmpl" \
    SETUP_LINUX_FILE="setupLinuxEnv.sh" \
    INSTALL_DB_FILE="oracle_install.sh"

# Use second ENV so that variable get substituted
ENV INSTALL_DIR=/install

# Copy binaries
# -------------
COPY $INSTALL_RSP $CONFIG_RSP $SETUP_LINUX_FILE $INSTALL_DB_FILE $INSTALL_FILE_1 $INSTALL_FILE_2 $INSTALL_DIR/

# Install DB software binaries
RUN $INSTALL_DIR/$SETUP_LINUX_FILE && \
    $INSTALL_DIR/$INSTALL_DB_FILE