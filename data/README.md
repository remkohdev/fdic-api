# Initialize Database

```
$ docker stop init-db
$ docker rm init-db
$ docker build --no-cache -t init-db:latest .
$ docker run -d -t --name init-db init-db:latest
$ docker exec -it init-db /bin/sh

```