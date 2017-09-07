# [Confluent Open Source Platform](https://www.confluent.io/product/confluent-open-source/) [Apache Kafka Connect] Docker image using [Oracle JDK] #

### Supported tags and respective Dockerfile links: ###

* ```jesse-slim-8u144-2.11.11-3.2.2``` _\([jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-kafka-connect:jesse-slim-8u144-2.11.11-3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-osp-kafka-connect:jesse-slim-8u144-2.11.11-3.2.2)
* ```jesse-slim-8u144-2.11.11-3.3.0```, ```latest``` _\([jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-kafka-connect:jesse-slim-8u144-2.11.11-3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-osp-kafka-connect:jesse-slim-8u144-2.11.11-3.3.0)

#### All tag names follow the naming convention: ####

```debian_image_tag``` + '-' + ```java_version``` + '-' + ```scala_version``` + '-' + ```confluent_platform_version```

### About: ### 

#### Summary: ####

- Debian "slim" image variant
- Oracle Java SE Development Kit (JDK) 8u144 addded, without MissionControl, VisualVM, JavaFX and JRE
- Oracle Java Cryptography Extension added
- Scala 2.11.11 added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME and SCALA\_HOME environment variables set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')]
    - [Docker utility belt script ('dub')]
- [Apache Kafka Connect] added:
    - version 0.10.2.1 in ```jesse-slim-8u144-2.11.11-3.2.2```
    - version 0.11.0.0 in ```jesse-slim-8u144-2.11.11-3.3.0``` and ```latest```

#### More details: ####

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```jesse-slim-8u144-2.11.11-3.2.2``` follows branch [3.2.x], and 
- tags ```jesse-slim-8u144-2.11.11-3.3.0``` and```latest``` follow branch [3.3.x]


Apart of the base image ([confluent-osp-base]), it has [Apache Kafka Connect] related packages, plus the [Schema Registry] added on top of it, installed using the following Confluent Debian package:
- ```confluent-schema-registry-2.11```
- ```confluent-kafka-connect-jdbc-2.11```
- ```confluent-kafka-connect-hdfs-2.11```
- ```confluent-kafka-connect-elasticsearch-2.11```
- ```confluent-kafka-connect-storage-common-2.11```
- ```confluent-kafka-connect-s3-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-osp-kafka-connect .
```

Run the container
```shell
docker run -d \
docker run -d \
    --name=kafka-connect \
    --net=host \
    -e CONNECT_BOOTSTRAP_SERVERS=localhost:29092 \
    -e CONNECT_REST_PORT=28082 \
    -e CONNECT_GROUP_ID="quickstart" \
    -e CONNECT_CONFIG_STORAGE_TOPIC="quickstart-config" \
    -e CONNECT_OFFSET_STORAGE_TOPIC="quickstart-offsets" \
    -e CONNECT_STATUS_STORAGE_TOPIC="quickstart-status" \
    -e CONNECT_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
    -e CONNECT_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
    -e CONNECT_INTERNAL_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
    -e CONNECT_INTERNAL_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
    -e CONNECT_REST_ADVERTISED_HOST_NAME="localhost" 
    mbe1224/confluent-osp-kafka-connect
```

### Environment variables: ###

One can use the following environment variables for configuring the ZooKeeper node:

| # | Name | Default value | Meaning | Comments |
|---|---|---|---|---|
| 1 | CONNECT\_BOOTSTRAP\_SERVERS | - | A unique string that identifies the Connect cluster group this worker belongs to | - |
| 2 | CONNECT\_CONFIG\_STORAGE\_TOPIC | - | The name of the topic in which to store connector and task configuration data | This must be the same for all workers with the same ```group.id``` |
| 3 | CONNECT\_CUB\_KAFKA\_MIN\_BROKERS | 1 | Expected number of brokers in the cluster | Check the [Confluent utility belt script ('cub')] - ```check_kafka_ready``` for more details |
| 4 | CONNECT\_CUB\_KAFKA\_TIMEOUT | 40 | Time in secs to wait for the number of Kafka nodes to be available | Check the [Confluent utility belt script ('cub')] - ```check_kafka_ready``` for more details |
| 5 | CONNECT\_GROUP\_ID | - | A unique string that identifies the Connect cluster group this worker belongs to | - |
| 6 | CONNECT\_INTERNAL\_KEY\_CONVERTER | - | Converter class for internal keys that implements the Converter interface | - |
| 7 | CONNECT\_INTERNAL\_VALUE\_CONVERTER | - | Converter class for internal values that implements the Converter interface | - |
| 8 | CONNECT\_KEY\_CONVERTER | - | Converter class for keys. This controls the format of the data that will be written to Kafka for source connectors or read from Kafka for sink connectors | - |
| 9 | CONNECT\_LOG4J\_LOGGERS | - | - | - |
| 10 | CONNECT\_LOG4J\_ROOT\_LOGLEVEL | INFO | - | - |
| 11 | CONNECT\_OFFSET\_STORAGE\_TOPIC | - | The name of the topic in which to store offset data for connectors | This must be the same for all workers with the same ```group.id``` |
| 12 | CONNECT\_REST\_ADVERTISED\_HOST\_NAME | - | Advertised host name is how Connect gives out a host name that can be reached by the client | - |
| 13 | CONNECT\_REST\_PORT | 8083 | Port for incomming connections | - |
| 14 | CONNECT\_STATUS\_STORAGE\_TOPIC | - | The name of the topic in which to store state for connectors | This must be the same for all workers with the same ```group.id``` |
| 15 | CONNECT\_VALUE\_CONVERTER | - | Converter class for values. This controls the format of the data that will be written to Kafka for source connectors or read from Kafka for sink connectors | - |

Moreover, one can use any of the properties specified in the [Apache Kafka Connect Configuration Options] by replacing "." with "\_" and appending "CONNECT\_" before the property name. For example, instead of ```config.storage.topic``` use ```CONNECT_CONFIG_STORAGE_TOPIC```.

### Dual licensed under: ###

* [Apache License]
* [Oracle Binary Code License Agreement]

   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Apache Kafka Connect]: <https://kafka.apache.org/documentation/#connect>   
   [Apache Kafka Connect Configuration Options]: <https://kafka.apache.org/documentation/#connectconfigs>
   [Schema Registry]: <http://docs.confluent.io/current/schema-registry/docs/index.html>   
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-kafka-connect/blob/jesse-slim-8u144-2.11.11-3.2.2/Dockerfile>
   [jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-kafka-connect/blob/jesse-slim-8u144-2.11.11-3.3.0/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [confluent-osp-base]: <https://hub.docker.com/r/mbe1224/confluent-osp-base/>
   [Apache License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-kafka-connect/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-kafka-connect/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>