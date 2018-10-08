#!/bin/bash

docker-compose down

docker build . -t productivity-frontend

docker-compose build
