# Dockerfile
ARG BASE_IMAGE=openjdk:21-jdk-slim
FROM ${BASE_IMAGE}

WORKDIR /app
COPY app/HelloWorld.class .

CMD ["java", "HelloWorld"]
