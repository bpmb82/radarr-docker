FROM bpmbee/mono-base:latest

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
        jq xml-twig-tools && \
 echo "**** install sonarr ****" && \
 RADAR_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/Radarr/Radarr/releases/latest | awk -F / '{print $NF}') && \
 curl -L https://github.com/Radarr/Radarr/archive/${RADAR_VERSION}.tar.gz \
        -o /opt/radarr.tar.gz && \
 cd /opt && \
 tar zxvf radarr.tar.gz && \
 rm radarr.tar.gz && \
 RADARR_DIR=$(ls | grep Radarr*)
 cd $RADARR_DIR && \
 echo "**** cleanup ****" && \
 apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
 rm -rf \
        /tmp/* \
        /var/tmp/*

WORKDIR /opt
COPY start.sh .
COPY healtcheck.sh .
RUN chmod +x *.sh

EXPOSE 8989
VOLUME /config

HEALTHCHECK --interval=5m --timeout=5s \
  CMD /opt/healthcheck.sh

ENTRYPOINT ["/opt/start.sh"]
