#!/bin/bash -xv

echo '=====>docker stop'
docker stop fdic-api
docker rm fdic-api

echo '=====>docker build'
docker build --no-cache -t fdic-api .

echo '=====>docker run'
docker run -d --restart always --name fdic-api -p 3000:3000 -e "NODE_ENV=local" fdic-api