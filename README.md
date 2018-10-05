# Alternate docker image for nod32-update-mirror

Usefull examples, support, original docker image and all the stuff are in [The Original Project](https://github.com/tarampampam/nod32-update-mirror)!

## Why this realization?
- Pure lightweight nod32-update-mirror toolset without nginx included in main image;
- Ready to use with (official or le-enabled) nginx;
- And because I can!

## How to use?

Use legal keys, there is no `--keys-update` option enabled by default.
Use custom `settings.conf`, you are to write your own using `settings.conf~example`.

Use cases:

1) Docker run with scheduler enabled (default):

```bash
 docker run -it --rm --name nod32_update_scheduler\
  -v $PWD/data:/data\
  -v $PWD/settings.conf:/src/settings.conf:ro\
  -e FIRST_START_DELAY=2s\
  -e SCHEDULE_PERIOD=43200\
  -e START_BEFORE_LOOP=true\
  kran0/nod32-update-mirror:latest
```

Data dir `$PWD/data` will be updated every `SCHEDULE_PERIOD`.

2) Docker run worker only (usefull for external scheduler):

```bash
 docker run -it --rm --name nod32_update\
  -v $PWD/data:/data\
  -v $PWD/settings.conf:/src/settings.conf:ro\
  --user $(id --user):$(id --group)\
  --entrypoint="/src/nod32-mirror.sh"\
  kran0/nod32-update-mirror:latest --force-yes --update
```

Feel free to use your `$PWD/data`. 

3) Docker-compose up worker and nginx (using docker-compose.yaml)

```bash
 docker-compose up -d
```

Nginx will serve `nod32-data` volume's contents.

## How to build?

Please watch my [Automated builds](https://hub.docker.com/r/kran0/nod32-update-mirror/tags/).

| Repository:Tag | Build description  |
|:-:|---|
| kran0/nod32-update-mirror:latest | latest master from [author's git](https://github.com/tarampampam/nod32-update-mirror) |
| kran0/davmail-docker:2.2.0 and such | Releases based on this project [tags](https://github.com/kran0/nod32-update-mirror/releases) |

While the Dockerfile uses multi-stage build. You need Docker 17.05 or higher on the daemon and client to build.
Build command: "`docker build -t kran0/nod32-update-mirror:latest .`".
