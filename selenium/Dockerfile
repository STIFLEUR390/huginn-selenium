FROM selenium/standalone-chrome:latest

USER root

ENV SE_OPTS="--disable-blink-features=AutomationControlled --no-sandbox --disable-dev-shm-usage --disable-gpu"

RUN apt-get update && \
    apt-get install -y curl jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /opt/bin/entrypoint.sh
RUN chmod +x /opt/bin/entrypoint.sh

USER seluser

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
