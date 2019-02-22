#######################################
# OACIS Dockerfile for simulator demo #
#######################################
FROM oacis/oacis
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

ARG http_proxy=""
ARG https_proxy=""

# install matplotlib for analizer
RUN apt-get -y install python-matplotlib

# copy misc files
COPY _oacis_add_host.sh /home/oacis/
RUN tr -d \\r < /home/oacis/_oacis_add_host.sh > /home/oacis/oacis_add_host.sh \
 && chown oacis:oacis /home/oacis/oacis_add_host.sh && chmod +x /home/oacis/oacis_add_host.sh

# ffb
RUN mkdir -p /home/oacis/ffb && chown -R oacis:oacis /home/oacis/ffb
COPY register_ffb.rb /home/oacis/ffb
RUN chown oacis:oacis /home/oacis/ffb/register_ffb.rb

# mdacp
RUN mkdir -p /home/oacis/mdacp && chown -R oacis:oacis /home/oacis/mdacp
COPY register_mdacp.rb /home/oacis/mdacp
COPY mdacp/plot_figs.py /home/oacis/mdacp/
RUN chown oacis:oacis /home/oacis/mdacp/register_mdacp.rb /home/oacis/mdacp/plot_figs.py

# setup ssh
RUN mkdir -p /home/oacis/.ssh \
 && chown oacis:oacis /home/oacis/.ssh; chmod 700 /home/oacis/.ssh
COPY id_rsa_oacis.pub /home/oacis/.ssh/authorized_keys
COPY id_rsa_oacis /home/oacis/.ssh/id_rsa
RUN chown oacis:oacis /home/oacis/.ssh/authorized_keys /home/oacis/.ssh/id_rsa \
 && chmod 600 /home/oacis/.ssh/authorized_keys /home/oacis/.ssh/id_rsa \
 && echo "StrictHostKeyChecking no" >> /home/oacis/.ssh/config \
 && echo "Host ffb\\n\\tUser oacis\\n\\tHostName ffb\\n\\tIdentityFile ~/.ssh/id_rsa" >> /home/oacis/.ssh/config \
 && echo "Host mdacp\\n\\tUser oacis\\n\\tHostName mdacp\\n\\tIdentityFile ~/.ssh/id_rsa" >> /home/oacis/.ssh/config \
 && echo "Host genesis\\n\\tUser oacis\\n\\tHostName genesis\\n\\tIdentityFile ~/.ssh/id_rsa" >> /home/oacis/.ssh/config \
 && chown oacis:oacis /home/oacis/.ssh/config && chmod 600 /home/oacis/.ssh/config

# start mongodb daemon and OACIS daemons.
CMD ["./oacis_start.sh"]
