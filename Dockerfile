FROM mono:6-slim

ENV RADARR_VERSION 0.2.0.1358

RUN apt-get update \
  && apt-get install -y --no-install-recommends mediainfo sqlite3 libmono-cil-dev wget \
  && cd /tmp \
  && wget https://github.com/Radarr/Radarr/releases/download/v$RADARR_VERSION/Radarr.develop.$RADARR_VERSION.linux.tar.gz \
  && tar -xf Radarr* -C /opt/ \
  && apt-get purge -y wget \
  && mkdir -p /usr/lib/radarr/{config,downloads,movies} \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && find /opt/Radarr/ -type f -exec chmod 644 {} \; \
  && find /opt/Radarr/ -type d -exec chmod 755 {} \; \
  && chmod 755 /opt/Radarr/ 

EXPOSE 7878
VOLUME ["/usr/lib/radarr/config", "/usr/lib/radarr/downloads", "/usr/lib/radarr/movies"]

ENTRYPOINT ["mono", "--debug", "/opt/Radarr/Radarr.exe", "-nobrowser", "-data=/usr/lib/radarr/config"]