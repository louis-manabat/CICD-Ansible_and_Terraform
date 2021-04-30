#!/usr/bin/env bash
docker build -f src/qawolfdockerfile ./src -t qabuild:latest --no-cache
docker-compose -f docker-compose-e2e.yml up -d
docker exec -it qawolf /usr/app/e2e.sh