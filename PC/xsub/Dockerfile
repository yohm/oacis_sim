###############################################
# XSUB Dockerfile from Ubuntu Image for OACIS #
###############################################
FROM ubuntu:16.04
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

ARG http_proxy=""
ARG https_proxy=""
ENV SSHD_PORT=22
EXPOSE 22

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates wget \
 openssh-server git openmpi-bin python python-matplotlib ruby2.3

# Install xsub
RUN useradd -ms /bin/bash oacis
USER oacis
WORKDIR /home/oacis
RUN git clone https://github.com/crest-cassia/xsub.git \
 && echo "export PATH=\$PATH:/home/oacis/xsub/bin" >> /home/oacis/.bash_profile \
 && echo "export XSUB_TYPE=\"none\"" >> /home/oacis/.bash_profile

# Setup ssh
USER root
RUN mkdir -p /home/oacis/.ssh \
 && chown oacis /home/oacis/.ssh; chmod 700 /home/oacis/.ssh
COPY id_rsa_oacis.pub /home/oacis/.ssh/authorized_keys
RUN chown oacis /home/oacis/.ssh/authorized_keys \
 && chmod 600 /home/oacis/.ssh/authorized_keys

# Start sshd
RUN mkdir -p /var/run/sshd
#RUN echo "oacis:oacis" | chpasswd
ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]

