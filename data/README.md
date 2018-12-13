# Initialize Database

```
$ docker stop init-db
$ docker rm init-db
$ docker build --no-cache -t init-db:latest .
$ docker run -d -t --name init-db -e "COUCHDB_HOSTNAME=192.168.1.5" -e "COUCHDB_USERNAME=couchdbadmin" -e "COUCHDB_PASSWORD=couchdbadmin" init-db
$ docker exec -it init-db /bin/sh

```