# Alternate docker image for nod32-update-mirror

Another Dockerfile for [nod32-update-mirror project](https://github.com/tarampampam/nod32-update-mirror).
Usefull examples, support, original docekr image, nginx.confs and all the stuff are in [The Original Project](https://github.com/tarampampam/nod32-update-mirror)!

## Why this realization?
- Pure nod32-update-mirror toolset without nginx;
- Ready to use with external nginx (I prefer another container for nginx);
- And because i can!

## How to use?

This image implements my special interest. So there are just a few use cases:

1) Run with scheduler enabled (default):

```bash
 docker run -it --rm --name nod32_update_scheduler\
  -v $PWD/data:/data\
  -v $PWD/settings.conf:/src/settings.conf:ro\
  --user $(id --user):$(id --group)\
  -e FIRST_START_DELAY=2s\
  -e SCHEDULE_PERIOD=43200\
  -e START_BEFORE_LOOP=true\
  kran0/nod32-update-mirror:latest
```

2) Run only worker and quit (usefull):

```bash
 docker run -it --rm --name nod32_update\
  -v $PWD/data:/data\
  -v $PWD/settings.conf:/src/settings.conf:ro\
  --user $(id --user):$(id --group)\
  --entrypoint="/src/nod32-mirror.sh"\
  kran0/nod32-update-mirror:latest --force-yes --update
```

3) Sometime i'll add docker-compose.yaml

Feel free tu use your `$PWD/data`. 
