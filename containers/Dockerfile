# Dockerfile for a pseudo-distributed Hadoop cluster running on a CentOS Linux container.
# Author: Andrew Jarombek
# Date: 2/8/2020

FROM ubuntu:18.04

LABEL maintainer="andrew@jarombek.com" \
      version="1.0.0" \
      description="Dockerfile for a barebones Hadoop pseudo-distributed cluster"

# Run all the container setup commands with the root user.
USER root

# Install SSH onto the container - a pre-req for Hadoop.
RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y install openssh-server

# Install Java
RUN apt-get -y install openjdk-8-jdk curl \
    && echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> .bash_profile

# Set JAVA_HOME for easy Java usage.  Many projects in the Hadoop ecosystem are written in Java.
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# SSH with no Passphrase
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa \
    && cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Hadoop
RUN curl -O http://mirrors.koehn.com/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz \
    && tar -xvf hadoop-3.2.1.tar.gz \
    && mv hadoop-3.2.1 hadoop \
    && mv hadoop/ /usr/share/

# Set convenience variables for the Hadoop installation directories.
ENV HADOOP_HOME=/usr/share/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Set environment variables which allow HDFS and YARN to be run by the root user.
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

# Set SSH configuration for the root user.
COPY /cluster-files/ssh /home/root/.ssh/config
RUN chmod 600 /home/root/.ssh/config

# Copy Hadoop XML config files into the proper filesystem directory.
COPY /cluster-files/conf /usr/share/hadoop/etc/hadoop/

# Configure Hadoop and set priveleges on Hadoop files
RUN echo "HADOOP_HOME=/usr/share/hadoop" >> .bash_profile \
    && mkdir -p /etc/hadoop/conf \
    && sed -i "\$aexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" \
        $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && ln -s $HADOOP_HOME/etc/hadoop/* /etc/hadoop/conf/ \
    && mkdir $HADOOP_HOME/logs \
    && chmod -R 777 /usr/share/hadoop

# Copy file used to bootstrap HDFS and YARN upon container startup into the sources bin directroy.
COPY hadoop-init.sh /usr/share/hadoop/sbin

# Copy demo files which are used in HDFS and MapReduce jobs.
COPY /cluster-files/hdfs-data /usr/share/hadoop/usr/andy

EXPOSE 8088
ENTRYPOINT /usr/share/hadoop/sbin/hadoop-init.sh && tail -f /dev/null