FROM bpmbee/mono-base:latest

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
        jq xml-twig-tools && \
 echo "**** install sonarr ****" && \
 RADARR_VERSION=$(curl -sL "https://radarr.servarr.com/v1/update/master/changes?os=linux" | jq -r '.[0].version') && \
 curl -L -o /opt/radarr.tar.gz https://github.com/Radarr/Radarr/releases/download/v$RADARR_VERSION/Radarr.master.$RADARR_VERSION.linux-core-x64.tar.gz && \
 cd /opt && \
 tar zxvf radarr.tar.gz && \
 rm radarr.tar.gz && \
 echo "**** cleanup ****" && \
 apt-get -y remove jq && \
 apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
 rm -rf \
        /tmp/* \
        /var/tmp/*

WORKDIR /opt
COPY start.sh .
COPY healthcheck.sh .
RUN chmod +x *.sh

EXPOSE 7878
VOLUME /config

HEALTHCHECK --interval=5m --timeout=5s \
  CMD /opt/healthcheck.sh

ENTRYPOINT ["/opt/start.sh"]
