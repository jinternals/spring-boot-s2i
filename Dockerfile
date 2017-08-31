
# spring-boot
FROM openshift/base-centos7

MAINTAINER Mradul Pandey <pandeymradul@gmail.com>

ENV JAVA_VERSON 1.8.0
ENV MAVEN_VERSION 3.3.9

LABEL io.k8s.description="Platform for building Spring boot application" \
      io.k8s.display-name="Spring boot maven builder" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,springboot,maven-3,java-8"


RUN yum update -y && \
  yum install -y curl && \
  yum install -y java-$JAVA_VERSON-openjdk java-$JAVA_VERSON-openjdk-devel && \
  yum clean all

RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV JAVA_HOME /usr/lib/jvm/java
ENV MAVEN_HOME /usr/share/maven

RUN mkdir -p /opt/app-root/src && chmod -R a+rwX /opt/app-root/src

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

COPY ./s2i/bin/ /usr/libexec/s2i

RUN chown -R 1001:1001 /opt/app-root

USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
