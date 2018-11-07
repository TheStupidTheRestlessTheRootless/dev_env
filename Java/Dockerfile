# Ubuntu 16.04
# Oracle Java 1.8.0_101 64 bit
# Maven 3.3.9

FROM ubuntu:16.04

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

# update dpkg repositories
RUN apt-get update \
    && apt-get install -y wget git vim \
    && apt-get clean

ENV MVN_VERSION 3.3.9
ENV JAVA_VERSION 1.8.0_191

# get maven 3.3.9
RUN wget --no-verbose -O /tmp/apache-maven-$MVN_VERSION.tar.gz http://archive.apache.org/dist/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz

# verify checksum
RUN echo "516923b3955b6035ba6b0a5b031fbd8b /tmp/apache-maven-$MVN_VERSION.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.3.9.tar.gz -C /opt/ \
    && ln -s /opt/apache-maven-3.3.9 /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/local/bin \
    && rm -f /tmp/apache-maven-3.3.9.tar.gz

ENV MAVEN_HOME /opt/maven

# set shell variables for java installation
ENV filename jdk-8u191-linux-x64.tar.gz
ENV downloadlink http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/$filename

# download java, accepting the license agreement
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/$filename $downloadlink 

# unpack java
RUN mkdir /opt/java-oracle && tar -zxf /tmp/$filename -C /opt/java-oracle/
ENV JAVA_HOME /opt/java-oracle/jdk$JAVA_VERSION
ENV PATH $JAVA_HOME/bin:$PATH

# configure symbolic links for the java and javac executables
RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

CMD ["/bin/bash"]
