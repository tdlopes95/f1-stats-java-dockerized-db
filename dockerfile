# ===== Build stage =====
FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder
WORKDIR /app

COPY pom.xml ./

RUN mvn -B -U -e -DskipTests dependency:go-offline || true


COPY src ./src
RUN mvn -B -e -DskipTests clean package

# ===== Runtime stage =====
FROM eclipse-temurin:21-jre
WORKDIR /app

# Reasonable defaults for a small Spring app; keep your original JAVA_OPTS
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75.0 -XX:+UseG1GC"

# Copy the built jar; if you know the final name, replace the wildcard with it
COPY --from=builder /app/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]