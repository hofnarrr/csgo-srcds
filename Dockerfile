FROM debian:12

ENV USER=cs2
ENV HOME=/opt/cs2
ENV SRCDS=$HOME/srcds
ENV CS2_APPID=730
ENV STEAMCMD=/usr/games/steamcmd

COPY debian-non-free.sources /etc/apt/sources.list.d/debian.sources

RUN dpkg --add-architecture i386 && \
    echo 'steamcmd steam/question string I AGREE' | debconf-set-selections && \
    apt-get update -y && \
    apt-get install -y curl steamcmd && \
    apt-get install -y --reinstall ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -Md $HOME $USER && \
    mkdir $HOME && \
    mkdir $SRCDS && \
    chown -R $USER:$USER $HOME

USER $USER

RUN $STEAMCMD +force_install_dir $SRCDS +login anonymous +app_update $CS2_APPID validate +quit
COPY entrypoint.sh /entrypoint.sh

WORKDIR $SRCDS
ENTRYPOINT ["/entrypoint.sh"]
