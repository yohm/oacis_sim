#!/bin/bash
# exec me via source command if you need
export http_proxy=http://${PROXY_USER}:${PROXY_PASSWORD}@${PROXY_SERVER}:8080
export https_proxy=http://${PROXY_USER}:${PROXY_PASSWORD}@${PROXY_SERVER}:8080
export SOCKS5_SERVER=${SOCKS_SERVER}:1080
export SOCKS5_USER=${SOCKS_USERNAME}
export SOCKS5_PASSWD=${SOCKS_PASSWORD}
export KUSER=${K_USERNAME}
