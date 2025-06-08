#!/bin/bash

echo "[ENTRYPOINT] Chargement des proxys :"
cat /opt/proxies.txt

# Lancement de Selenium
exec /opt/bin/entry_point.sh
