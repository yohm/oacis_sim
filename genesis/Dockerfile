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

RUN mkdir -p /home/oacis/genesis/tutorial-1.1 \
 && (cd /home/oacis/genesis/tutorial-1.1; \
     mkdir -p 1_setup 2_minimization 3_heating 4_equilibration 5_production)
COPY tutorial-1.1/1_setup/* /home/oacis/genesis/tutorial-1.1/1_setup/
COPY tutorial-1.1/2_minimization/* /home/oacis/genesis/tutorial-1.1/2_minimization/
COPY tutorial-1.1/3_heating/* /home/oacis/genesis/tutorial-1.1/3_heating/
COPY tutorial-1.1/4_equilibration/* /home/oacis/genesis/tutorial-1.1/4_equilibration/
COPY tutorial-1.1/5_production/* /home/oacis/genesis/tutorial-1.1/5_production/
RUN chown -R oacis:oacis /home/oacis/genesis/tutorial-1.1
