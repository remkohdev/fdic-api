FROM alpine:3.8

RUN apk add --no-cache curl 

RUN mkdir /database
COPY INSTITUTIONS2.json /data/INSTITUTIONS2.json

COPY ./init-database.sh ./
RUN chmod +x ./init-database.sh

ENTRYPOINT ["/bin/sh"]
