################################################
# MDACP Dockerfile from Ubuntu Image for OACIS #
################################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

#RUN apt-get update \
# && apt-get install -y python-matplotlib

# Install mdacp
USER root
RUN mkdir -p /home/oacis/mdacp
COPY bin/* /home/oacis/mdacp/
RUN chmod +x /home/oacis/mdacp/* \
 && chown -R oacis:oacis /home/oacis/mdacp \
 && echo "export PATH=\$PATH:/home/oacis/mdacp" >> /home/oacis/.bash_profile

