FROM thothbot/alpine-jre8
COPY ./target/myproject*.jar ./myproject-0.0.1-SNAPSHOT.jar
COPY ./run.sh /run.sh
RUN chmod a+x /run.sh
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "./myproject-0.0.1-SNAPSHOT.jar"]
