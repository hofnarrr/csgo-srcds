# CS:GO SRCDS Docker image

### build it
```
$ docker build -t csgo-srcds .
```

### run it like you'd run srcds_run
```
$ docker run -dit --name csgo-srcds csgo-srcds -console -usercon -tickrate 128 -map de_dust2 +rcon_password hunter2 +sv_setsteamaccount ...
```

### optionally mount a directory to `/srcds-overlay` to customize the server
```
$ docker run -dit --name csgo-srcds -v $(pwd)/server1-files/:/srcds-overlay csgo-srcds -console -usercon ...
```
