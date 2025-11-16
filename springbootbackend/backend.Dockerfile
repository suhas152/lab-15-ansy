# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

# (Optional) Copy .mvn if any custom config, but you may skip mvnw
COPY pom.xml ./
COPY src ./src

# Run using mvn directly (assuming mvn is available in the image)
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk AS runtime
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 2000
ENTRYPOINT ["java", "-jar", "app.jar"]