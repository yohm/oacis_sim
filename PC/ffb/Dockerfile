##############################################
# FFB Dockerfile from Ubuntu Image for OACIS #
##############################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

RUN apt-get update \
 && apt-get install -y libgfortran3

# Install FFB
USER root
COPY ffb_dist.tgz /home/oacis/ffb/
WORKDIR /home/oacis/ffb
RUN tar xvfz ffb_dist.tgz \
 && chown -R oacis:oacis . \
 && chmod +x bin/* \
 && echo "export PATH=\$PATH:/home/oacis/ffb/bin" >> /home/oacis/.bash_profile \
 && rm -f ffb_dist.tgz

