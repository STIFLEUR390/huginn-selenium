FROM selenium/standalone-chrome:latest

USER root

ENV SE_OPTS="--disable-blink-features=AutomationControlled --no-sandbox --disable-dev-shm-usage --disable-gpu"

# Installer curl & jq dans l'image de base (Debian-based)
RUN apt-get update && \
    apt-get install -y curl jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Télécharger la liste de proxys
RUN curl -s "https://proxylist.geonode.com/api/proxy-list?limit=500&page=1&sort_by=lastChecked&sort_type=desc" \
 | jq -r '.data[] | select(.protocols[] | test("http")) | "\(.ip):\(.port)"' \
 | head -n 50 \
 | paste -sd "," - \
 > /opt/proxies.txt

# Copier le script d’entrée
COPY entrypoint.sh /opt/bin/entrypoint.sh
RUN chmod +x /opt/bin/entrypoint.sh

# Revenir à l'utilisateur selenium pour sécurité
USER seluser

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
