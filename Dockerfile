FROM mbe1224/confluent-osp-kafka:jesse-slim-8u144-2.11.11-3.2.2

ENV CONFLUENT_DEB_VERSION="2"

ENV COMPONENT=kafka-connect

# Default kafka-connect rest.port
EXPOSE 8083

RUN echo "===> Installing Schema Registry (for Avro jars) ..." \
    && apt-get -qq update \
    && apt-get install -y \
        confluent-schema-registry=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
        confluent-kafka-connect-jdbc=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
        confluent-kafka-connect-hdfs=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
        confluent-kafka-connect-elasticsearch=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
        confluent-kafka-connect-storage-common=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
        confluent-kafka-connect-s3=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \    
    && echo "===> Cleaning up ..."  \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    echo "===> Setting up ${COMPONENT} dirs ..." \
    && mkdir -p /etc/${COMPONENT} /etc/${COMPONENT}/secrets /etc/${COMPONENT}/jars /etc/confluent/docker \
    && chmod -R ag+w /etc/${COMPONENT} /etc/${COMPONENT}/secrets /etc/${COMPONENT}/jars \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/apply-mesos-overrides" -O "/etc/confluent/docker/apply-mesos-overrides" \
    && echo "34238affe466e41c2f06c078993e29f4c358fb297d019213e75b404490d38ee4" "/etc/confluent/docker/apply-mesos-overrides" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && echo "3316f81e68b0437700c0f48170a6e13511bd103fa7d10771151370f9ff7f7064" "/etc/confluent/docker/configure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && echo "d7ca27dbd0ada8b4fc5a016ee2bd2eb53b6d24f14cb2b4cee00e834ccc06bc74" "/etc/confluent/docker/ensure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && echo "25df078e3ca6fb3db7e1286e4ef9a32e0e8a00ddbabe45cb4d2c9eee9af7d467" "/etc/confluent/docker/launch" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && echo "9c5a9355db166d390d9c36686bc4c859669acaf82c28cbdae7ee3bfe6a2422ec" "/etc/confluent/docker/log4j.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && echo "8499f919a9fc31f7cac5b5fd8998fabeea7debc3518e02cbe2854faa2ca73b31" "/etc/confluent/docker/run" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka-connect-base/include/etc/confluent/docker/kafka-connect.properties.template" -O "/etc/confluent/docker/kafka-connect.properties.template" \
    && echo "121a6de516ed9ea469aa143098e36c7df05b801e86cde1738a5b13c102e383d9" "/etc/confluent/docker/kafka-connect.properties.template" | sha256sum -c -

VOLUME ["/etc/${COMPONENT}/jars", "/etc/${COMPONENT}/secrets"]

CMD ["/etc/confluent/docker/run"]
