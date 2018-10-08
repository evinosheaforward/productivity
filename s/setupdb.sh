#!/bin/bash

docker-compose run --rm app rails db:create

docker-compose run --rm app rails db:migrate

docker-compose run --rm app rails db:seed
