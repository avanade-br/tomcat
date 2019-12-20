# https://hub.docker.com/_/microsoft-java-jre
FROM mcr.microsoft.com/java/jre:11u5-zulu-alpine

ENV TOMCAT_MAJOR 9
ENV TOMCAT_MINOR 0
ENV TOMCAT_PATCH 29

ENV TOMCAT_VERSION "${TOMCAT_MAJOR}.${TOMCAT_MINOR}.${TOMCAT_PATCH}"
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH "${CATALINA_HOME}/bin:${PATH}"

WORKDIR ${CATALINA_HOME}

RUN TOMCAT_DIR="apache-tomcat-${TOMCAT_VERSION}" && \
    TOMCAT_PACK="${TOMCAT_DIR}.tar.gz" && \
    TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/${TOMCAT_PACK}" && \
    echo "Downloading package ${TOMCAT_URL}" && \
    wget -nv ${TOMCAT_URL} && \
    wget -qO- "${TOMCAT_URL}.sha512" | sha512sum -c && \
    tar xzf ${TOMCAT_PACK} && \
    mv ${TOMCAT_DIR}/* . && \
    rmdir ${TOMCAT_DIR} && \
    rm -f ${TOMCAT_PACK}

EXPOSE 8080

CMD ["catalina.sh", "run"]