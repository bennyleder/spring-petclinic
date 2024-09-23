
FROM newtmitch/sonar-scanner AS sonarqube
WORKDIR /usr/src
COPY . /usr/src/
RUN sonar-scanner -Dsonar.projectBaseDir=/usr/src

FROM maven:3.8.7-openjdk-18 AS build
WORKDIR /app
COPY . /app
RUN chmod +x .. /mvnw
RUN ./mvnw package


FROM openjdk:18-alpine
WORKDIR /code
COPY -- from=build /app/target/ *. jar /code/
CMD ["sh", "-c", "java -jar /code/ *. jar"]
