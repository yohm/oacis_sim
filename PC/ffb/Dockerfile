##############################################
# FFB Dockerfile from Ubuntu Image for OACIS #
##############################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

RUN apt-get update \
 && apt-get install -y libgfortran3

# Install FFB
USER root
RUN mkdir -p /home/oacis/ffb/bin
COPY bin/* /home/oacis/ffb/bin/
RUN chmod +x /home/oacis/ffb/bin/* \
 && chown -R oacis:oacis /home/oacis/ffb \
 && echo "export PATH=\$PATH:/home/oacis/ffb/bin" >> /home/oacis/.bash_profile
COPY data.tgz /home/oacis/ffb/
WORKDIR /home/oacis/ffb
RUN tar xvfz data.tgz \
 && chown -R oacis:oacis data tmpl \
 && rm -f data.tgz

