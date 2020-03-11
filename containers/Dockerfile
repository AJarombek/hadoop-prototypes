# Dockerfile for a pseudo-distributed Hadoop cluster running on a CentOS Linux container.
# Author: Andrew Jarombek
# Date: 2/8/2020

FROM ubuntu:18.04

LABEL maintainer="andrew@jarombek.com" \
      version="1.0.0" \
      description="Dockerfile for a barebones Hadoop pseudo-distributed cluster"

USER root

RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y install openssh-server

# Install Java
RUN apt-get -y install openjdk-8-jdk curl \
    && echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> .bash_profile

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# SSH with no Passphrase
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa \
    && cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Hadoop
RUN curl -O http://mirrors.koehn.com/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz \
    && tar -xvf hadoop-3.2.1.tar.gz \
    && mv hadoop-3.2.1 hadoop \
    && mv hadoop/ /usr/share/

ENV HADOOP_HOME=/usr/share/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

COPY /cluster-files/ssh $HOME/.ssh/config
COPY /cluster-files/conf /usr/share/hadoop/etc/hadoop/

# Configure Hadoop
RUN echo "HADOOP_HOME=/usr/share/hadoop" >> .bash_profile \
    && mkdir -p /etc/hadoop/conf \
    && sed -i "\$aexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" \
        $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && ln -s $HADOOP_HOME/etc/hadoop/* /etc/hadoop/conf/ \
    && mkdir $HADOOP_HOME/logs \
    && groupadd hadoop \
    && useradd -g hadoop hdfs \
    && useradd -g hadoop yarn \
    && chgrp -R hadoop /usr/share/hadoop \
    && chmod -R 777 /usr/share/hadoop

WORKDIR /usr/share/hadoop
RUN bin/hdfs namenode -format \
    && service ssh start \
    && su hdfs \
    && sbin/start-dfs.sh \
    && su yarn \
    && sbin/start-yarn.sh

RUN useradd andy \
    && bin/hadoop fs -mkdir -p /user/andy \
    && bin/hadoop fs -chown andy:andy /user/andy \
    && bin/hadoop fs -mkdir /tmp \
    && bin/hadoop fs -chmod 777 /tmp
WORKDIR /

EXPOSE 8088
ENTRYPOINT ["tail", "-f", "/dev/null"]