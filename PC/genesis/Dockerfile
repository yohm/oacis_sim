##################################################
# GENESIS Dockerfile from Ubuntu Image for OACIS #
##################################################
FROM oacis_sim/xsub
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

RUN apt-get update \
 && apt-get install -y libgfortran3 libblas3 liblapack3 libgomp1

# Install GENESIS and Tutorial
USER root
RUN mkdir -p /home/oacis/genesis/bin
COPY bin/* /home/oacis/genesis/bin/
RUN chmod +x /home/oacis/genesis/bin/* \
 && chown -R oacis:oacis /home/oacis/genesis \
 && echo "export PATH=\$PATH:/home/oacis/genesis/bin" >> /home/oacis/.bash_profile

COPY data_dist.tgz /home/oacis/genesis/
WORKDIR /home/oacis/genesis
RUN tar xvfz data_dist.tgz \
 && chown -R oacis:oacis /home/oacis/genesis/data \
 && rm -f data_dist.tgz
