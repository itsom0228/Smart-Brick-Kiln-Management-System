# Stage 1: Build the Maven application
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY . .
WORKDIR /app/back-end
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/back-end/target/kiln-1.0.0.war app.war
EXPOSE 10000
ENTRYPOINT ["java", "-jar", "app.war"]
