FROM alpine:3.10 as prepare

# --branch can also take tags and detaches the HEAD at that commit in the resulting repository.
ARG BRANCH=v2.2.0
# use master to build from the master;
# Releases:
#  Aug 28, 2018: https://github.com/tarampampam/nod32-update-mirror/releases/tag/v2.2.0

ENV TEMPDIR=/tmp/code

\
RUN apk add --update --no-cache git\
 && git clone --branch=${BRANCH} https://github.com/tarampampam/nod32-update-mirror.git ${TEMPDIR}\
\
# prepare program's space
 && mkdir -vp /nod32-update-mirror\
 && mv -v ${TEMPDIR}/src ${TEMPDIR}/scheduler/entrypoint.sh /nod32-update-mirror/\
 && find /nod32-update-mirror -type f -name "*.sh" -exec chmod -v +x {} \;

FROM alpine:3.10

RUN apk --no-cache --update add bash curl wget grep sed unrar findutils
COPY --from=prepare /nod32-update-mirror /

WORKDIR /src
VOLUME ["/data"]

#ENTRYPOINT ["/src/nod32-mirror.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/src/nod32-mirror.sh --force-yes --update" ]
