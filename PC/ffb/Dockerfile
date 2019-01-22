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
COPY bin/les3* /home/oacis/ffb/bin/
RUN chmod +x /home/oacis/ffb/bin/les3* \
 && chown -R oacis:oacis /home/oacis/ffb \
 && echo "export PATH=\$PATH:/home/oacis/ffb/bin" >> /home/oacis/.bash_profile

