###################################
# OACIS Dockerfile for K-computer #
###################################
FROM oacis/oacis
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

ARG SOCKS5_SERVER=""
ARG SOCKS5_USER=""
ARG SOCKS5_PASSWD=""
ENV SOCKS5_SERVER=${SOCKS5_SERVER}
ENV SOCKS5_USER=${SOCKS5_USER}
ENV SOCKS5_PASSWD=${SOCKS5_PASSWD}
ARG KUSER="oacis"
ENV KUSER=${KUSER}

RUN apt-get -y install connect-proxy; exit 0

# put oacis_*.sh
USER root
COPY _oacis_setup.sh _mk_*.sh /home/oacis/
RUN tr -d \\r < /home/oacis/_oacis_setup.sh > /home/oacis/oacis_setup.sh \
 && tr -d \\r < /home/oacis/_mk_oacis_start.sh > /home/oacis/mk_oacis_start.sh \
 && tr -d \\r < /home/oacis/_mk_ssh_config.sh > /home/oacis/mk_ssh_config.sh \
 && chown oacis:oacis /home/oacis/*.sh && chmod +x /home/oacis/*.sh

# put ssh private key of K-computer
RUN mkdir /home/oacis/.ssh
COPY id_rsa.K.pub /home/oacis/.ssh/authorized_keys
RUN chown -R oacis:oacis /home/oacis/.ssh \
 && chmod 700 /home/oacis/.ssh && chmod 600 /home/oacis/.ssh/authorized_keys

# expose ssh port
EXPOSE 22

# put setup_xsub_k.sh
#COPY _setup_xsub_k.sh /home/oacis/
#RUN tr -d \\r < /home/oacis/_setup_xsub_k.sh > /home/oacis/setup_xsub_k.sh \
# && chown oacis:oacis /home/oacis/setup_xsub_k.sh

# put ffb environment
RUN mkdir /home/oacis/ffb
#COPY ffb/* /home/oacis/ffb/
#RUN tr -d \\r < /home/oacis/ffb/_install_ffb_K.sh > /home/oacis/ffb/install_ffb_K.sh \
# && tr -d \\r < /home/oacis/ffb/_setup_ffb_K.sh > /home/oacis/ffb/setup_ffb_K.sh \
# && chown -R oacis:oacis /home/oacis/ffb && chmod +x /home/oacis/ffb/*.sh
COPY ffb/register_ffb_K.rb /home/oacis/ffb/
RUN chown -R oacis:oacis /home/oacis/ffb

# put genesis environment
RUN mkdir /home/oacis/genesis
#COPY genesis/* /home/oacis/genesis/
#RUN tr -d \\r < /home/oacis/genesis/_install_genesis_K.sh > /home/oacis/genesis/install_genesis_K.sh \
# && tr -d \\r < /home/oacis/genesis/_setup_genesis_K.sh > /home/oacis/genesis/setup_genesis_K.sh \
# && chown -R oacis:oacis /home/oacis/genesis && chmod +x /home/oacis/genesis/*.sh
COPY genesis/register_genesis_K.rb /home/oacis/genesis/
RUN chown -R oacis:oacis /home/oacis/genesis

# put mdacp environment
RUN mkdir /home/oacis/mdacp
#COPY mdacp/* /home/oacis/mdacp/
#RUN tr -d \\r < /home/oacis/mdacp/_install_mdacp_K.sh > /home/oacis/mdacp/install_mdacp_K.sh \
# && tr -d \\r < /home/oacis/mdacp/_setup_mdacp_K.sh > /home/oacis/mdacp/setup_mdacp_K.sh \
# && chown -R oacis:oacis /home/oacis/mdacp && chmod +x /home/oacis/mdacp/*.sh
COPY mdacp/register_mdacp_K.rb /home/oacis/mdacp/
RUN chown -R oacis:oacis /home/oacis/mdacp

# start mongodb daemon and OACIS setup.
CMD ["./oacis_setup.sh"]
