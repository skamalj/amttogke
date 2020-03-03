FROM maven:3.5-jdk-8-alpine as builder
COPY . /tmp/
WORKDIR /tmp
RUN mvn clean install -PcheckstyleSkip -DskipTests

FROM jboss/wildfly
COPY --from=builder /tmp/target/spring-mvc-example.war /opt/jboss/wildfly/standalone/deployments/
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]


