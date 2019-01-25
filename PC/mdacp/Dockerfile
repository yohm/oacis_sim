################################################
# MDACP Dockerfile from Ubuntu Image for OACIS #
################################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

RUN apt-get update \
 && apt-get install -y libgomp1 bzip2

# Install mdacp
USER oacis
WORKDIR /home/oacis
RUN git clone https://github.com/yohm/sim_mdacp_oacis.git mdacp
USER root
COPY bin/* /home/oacis/mdacp/mdacp/
RUN chmod +x /home/oacis/mdacp/mdacp/* && chown -R oacis:oacis /home/oacis/mdacp \
 && echo "export PATH=\$PATH:/home/oacis/mdacp/mdacp" >> /home/oacis/.bash_profile

