# ── Stage 1: Build the WAR file using Maven ─────────────────────────
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application (WAR file) skipping tests
RUN mvn clean package -DskipTests

# ── Stage 2: Deploy on Tomcat 10 ────────────────────────────────────
FROM tomcat:10.1-jre17-temurin

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the built WAR from the builder stage as ROOT.war (serves at /)
COPY --from=builder /app/target/Online-Camping-Portal.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Render forwards external traffic to this port)
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
