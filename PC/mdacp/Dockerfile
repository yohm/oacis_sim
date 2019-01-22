################################################
# MDACP Dockerfile from Ubuntu Image for OACIS #
################################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

RUN apt-get install -y python3-matplotlib

# Install mdacp
USER root
RUN mkdir -p /home/oacis/mdacp/bin
COPY bin/* /home/oacis/mdacp/bin/
RUN chmod +x /home/oacis/mdacp/bin/* \
 && chown -R oacis:oacis /home/oacis/mdacp \
 && echo "export PATH=\$PATH:/home/oacis/mdacp/bin" >> /home/oacis/.bash_profile

