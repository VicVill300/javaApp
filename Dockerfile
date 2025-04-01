# Use OpenJDK 21 instead of 17
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled Java class file into the container
COPY app/HelloWorld.class .

# Run the Java application
CMD ["java", "HelloWorld"]
