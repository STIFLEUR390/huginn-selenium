FROM selenium/standalone-chrome:latest

ENV SE_OPTS="--disable-blink-features=AutomationControlled --no-sandbox --disable-dev-shm-usage --disable-gpu"

RUN apt-get update && apt-get install -y curl jq

RUN curl -s "https://proxylist.geonode.com/api/proxy-list?limit=500&page=1&sort_by=lastChecked&sort_type=desc" \
 | jq -r '.data[] | select(.protocols[] | test("http")) | "\(.ip):\(.port)"' \
 | head -n 50 \
 | paste -sd "," - \
 > /opt/proxies.txt


COPY entrypoint.sh /opt/bin/entrypoint.sh
RUN chmod +x /opt/bin/entrypoint.sh

ENTRYPOINT ["/opt/bin/entrypoint.sh"]