FROM openjdk:11-jre-slim

COPY /target/camellia-0.0.1-SNAPSHOT.jar /usr/local/lib/camellia-server.jar

ENTRYPOINT ["java","-jar","/usr/local/lib/camellia-server.jar"]
