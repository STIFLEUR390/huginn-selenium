#!/bin/bash

# Appel API GeoNode
echo "[+] Récupération de la liste de proxys..."
PROXIES=$(curl -s "https://proxylist.geonode.com/api/proxy-list?limit=500&page=1&sort_by=lastChecked&sort_type=desc")

# Extraction et formatage (filtre HTTP/HTTPS et pays optionnel)
PROXY_LIST=$(echo "$PROXIES" | jq -r '.data[] | select(.protocols[] | test("http")) | "\(.ip):\(.port)"' | head -n 50 | paste -sd "," -)

# Sauvegarde dans le .env ou export temporaire
echo "PROXY_LIST=\"$PROXY_LIST\"" > .env.proxy

echo "[✓] Liste de $(( $(echo \"$PROXY_LIST\" | grep -o ',' | wc -l) + 1 )) proxys prête."
