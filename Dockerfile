FROM maven:3.8.5-openjdk-17 as build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN mvn package
RUN ls $HOME/target

FROM openjdk:17-jdk-alpine
COPY --from=build /usr/app/target/spring-petclinic-3.2.0-SNAPSHOT.jar /app/runner.jar
ENTRYPOINT java -jar /app/runner.jar
