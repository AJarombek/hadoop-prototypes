# Dockerfile for a pseudo-distributed Hadoop cluster running on a CentOS Linux container.
# Author: Andrew Jarombek
# Date: 2/8/2020

FROM centos:8

LABEL maintainer="andrew@jarombek.com" \
      version="1.0.0" \
      description="Dockerfile for a barebones Hadoop pseudo-distributed cluster"

# Disable SELinux and IPv6, both of which can cause issues with Hadoop.
RUN sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    && sed -i "\$anet.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf
    && sed -i "\$anet.ipv6.conf.default.disable_ipv6 = 1" /etc/sysctl.conf
    && sysctl -p

RUN yum -y install java-1.8.0-openjdk-devel
    && echo "JAVA_HOME=/usr/lib/jvm/" >> .bash_profile