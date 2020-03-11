# Dockerfile for a pseudo-distributed Hadoop cluster running on a CentOS Linux container.
# Author: Andrew Jarombek
# Date: 2/8/2020

FROM centos:8

LABEL maintainer="andrew@jarombek.com" \
      version="1.0.0" \
      description="Dockerfile for a barebones Hadoop pseudo-distributed cluster"

# Install Java
RUN yum -y install java-1.8.0-openjdk-devel \
    && echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64/jre/bin/java" >> .bash_profile

# Install Hadoop
RUN curl -O http://mirrors.koehn.com/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz \
    && tar -xvf hadoop-3.2.1.tar.gz \
    && mv hadoop-3.2.1 hadoop \
    && mv hadoop/ /usr/share/

# Configure Hadoop
RUN echo "HADOOP_HOME=/usr/share/hadoop" >> .bash_profile \
    && HADOOP_HOME=/usr/share/hadoop \
    && mkdir -p /etc/hadoop/conf \
    && sed -i "\$aexport JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64/jre/bin/java" \
        $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && ln -s $HADOOP_HOME/etc/hadoop/* /etc/hadoop/conf/ \
    && mkdir $HADOOP_HOME/logs \
    && groupadd hadoop \
    && useradd -g hadoop hdfs \
    && useradd -g hadoop yarn \
    && chgrp -R hadoop /usr/share/hadoop \
    && chmod -R 777 /usr/share/hadoop

EXPOSE 8088
ENTRYPOINT ["tail", "-f", "/dev/null"]