FROM alpine:3.8 as prepare

ENV TEMPDIR=/tmp/code

RUN apk add --update --no-cache git unzip\
 && git clone https://github.com/tarampampam/nod32-update-mirror.git ${TEMPDIR}\

# prepare program's space
 && mkdir -vp /nod32-update-mirror\
 && mv -v ${TEMPDIR}/src ${TEMPDIR}/scheduler/entrypoint.sh /nod32-update-mirror/\
 && find /nod32-update-mirror -type f -name "*.sh" -exec chmod -v +x {} \;

FROM alpine:3.8

RUN apk --no-cache --update add bash curl wget grep sed apache2-utils unrar findutils
COPY --from=prepare /nod32-update-mirror /

WORKDIR /src
VOLUME ["/data"]
ENTRYPOINT ["/src/nod32-mirror.sh"]
