#!/bin/bash

echo "[INFO] Téléchargement de la liste des proxys..."

curl -s "https://proxylist.geonode.com/api/proxy-list?limit=500&page=1&sort_by=lastChecked&sort_type=desc" \
 | jq -r '.data[] | select(.protocols[] | test("http")) | "\(.ip):\(.port)"' \
 | head -n 50 \
 | paste -sd "," - \
 > /opt/proxies.txt

echo "[INFO] Proxys enregistrés dans /opt/proxies.txt"
cat /opt/proxies.txt

echo "[INFO] Lancement de Selenium"
exec /opt/bin/entry_point.sh
