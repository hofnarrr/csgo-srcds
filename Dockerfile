FROM debian:10

ENV USER csgo
ENV HOME /opt/csgo
ENV STEAMCMD $HOME/steamcmd
ENV SRCDS $HOME/srcds

RUN apt-get update -y && \
    apt-get install -y curl lib32gcc1 lib32stdc++6 && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -Md $HOME $USER && \
    mkdir $HOME && \
    mkdir $STEAMCMD && \
    mkdir $SRCDS && \
    chown -R $USER:$USER $HOME

USER $USER

RUN curl https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xvzC $STEAMCMD && \
    chmod -R u+x $STEAMCMD
RUN bash $STEAMCMD/steamcmd.sh +login anonymous +force_install_dir $SRCDS +app_update 740 validate +quit
COPY entrypoint.sh /entrypoint.sh

WORKDIR $SRCDS
ENTRYPOINT ["/entrypoint.sh"]
