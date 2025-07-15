# Use a Java 17 base image
FROM eclipse-temurin:17-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy Maven wrapper files and pom.xml
COPY .mvn .mvn
COPY mvnw pom.xml ./

# Download dependencies first (for better Docker caching)
RUN ./mvnw dependency:go-offline

# Copy all project files
COPY . .

# Build the Spring Boot JAR
RUN ./mvnw clean package -DskipTests

# Expose the default Spring Boot port
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "target/your-project-name-0.0.1-SNAPSHOT.jar"]
