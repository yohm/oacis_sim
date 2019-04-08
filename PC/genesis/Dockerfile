##################################################
# GENESIS Dockerfile from Ubuntu Image for OACIS #
##################################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

RUN apt-get update \
 && apt-get install -y libgfortran3 libblas3 liblapack3 libgomp1

# Install GENESIS and Tutorial
USER root
COPY genesis_dist.tgz /home/oacis/genesis/
WORKDIR /home/oacis/genesis
RUN tar xvfz genesis_dist.tgz \
 && chown -R oacis:oacis /home/oacis/genesis \
 && chmod +x /home/oacis/genesis/bin/* \
 && echo "export PATH=\$PATH:/home/oacis/genesis/bin" >> /home/oacis/.bash_profile \
 && rm -f genesis_dist.tgz

