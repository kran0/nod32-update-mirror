# Alternate docker image for nod32-update-mirror

Another Dockerfile for [nod32-update-mirror project](https://github.com/tarampampam/nod32-update-mirror).

## Why this realization?
- Only nod32-update-mirror toolset without nginx;
- Ready to use with external nginx (another container);
- And because i can! /Please use [original](https://hub.docker.com/r/tarampampam/nod32-update-mirror/tags/) docker image instead/

## How to use?

The author supplies the docker image for user's need. I have no reason to repeat their work.
This image implements my special interest. So there are only use cases:

1) Run with `docker run` command:

```bash
 docker run -it --rm\
 -v $PWD/volumes/data:/data\
 -e FIRST_START_DELAY=2s\
 -e SCHEDULE_PERIOD=600\
 -e START_BEFORE_LOOP=true\
 -e NOD32MIRROR_MIRROR_DIR='/data'\
 kran0/nod32-update-mirror:latest
 trypoint.sh "/src/nod32-mirror.sh --force-yes --keys-update; /src/nod32-mirror.sh --force-yes --update"
```

/TODO: fill this part after write and test/
