#!/bin/bash

docker-compose run --rm app rails db:create

docker-compose run --rm app rails db:migrate
