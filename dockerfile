FROM sonarsource/sonar-scanner-cli AS static-code-check
WORKDIR /usr/src
COPY . /usr/src/
RUN sonar-scanner \
-Dsonar.projectBaseDir=/usr/src \
-Dsonar.host.url=https://172.17.0.2:9000 \
-Dsonar.exclusions =** / *. java \
-Dsonar.token=sqp_5044acaa6b7ccfa1ff6dafba5bc6cf55dffb0d94 \
-Dsonar.projectKey=petclinic 
#-Dsonar.language=javascript

FROM maven:3.8.7-openjdk-18 AS maven-build
WORKDIR /app
COPY . /app
RUN chmod +x ./mvnw
RUN ./mvnw package

FROM openjdk:18-alpine as package
WORKDIR /code
COPY --from=build /app/target/ *. jar /code/
CMD ["sh", "-c", "java -jar /code/ *. jar"]
