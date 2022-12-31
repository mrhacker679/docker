FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven git -y
RUN git clone -b docker https://github.com/mrhacker679/vprofile-repo.git
RUN cd vprofile-project && mvn install


FROM tomcat:8-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
