#!/usr/bin/env bash
# Startup command for localstack docker container
# Tested with localstack:0.12.17.5

# Check docker service
docker ps > /dev/null 2>&1
if [ $? -eq 0 ]; then
    # Start container
    /usr/bin/sudo su - $USER -c "docker run --rm -d -p 4566:4566 -p 4571:4571 localstack/localstack:0.12.17.5"
else
    echo "ERROR: docker is not running!"
    exit 1
fi
