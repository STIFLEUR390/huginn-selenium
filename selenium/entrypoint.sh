#!/bin/bash

# Si une liste de proxies est fournie (FORMAT: ip:port,ip2:port2,...), en sélectionne un aléatoirement
if [ -z "${PROXY_LIST}" ] && [ -f /opt/proxies.txt ]; then
  PROXY_LIST=$(cat /opt/proxies.txt)
fi


# Lancer Selenium avec les options anti-bot et proxy
exec /opt/bin/entry_point.sh --selenium-args "${SE_OPTS}"