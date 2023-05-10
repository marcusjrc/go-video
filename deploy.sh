#!/bin/bash
echo "Downloading Goose"
apk update
apk add curl
curl -fsSL \https://raw.githubusercontent.com/pressly/goose/master/install.sh |\sh 
echo "Goose successfully downloaded"
echo "Attempting to migrate database..."
goose -dir ./migrations postgres "=$DB_HOST user=$DB_USERNAME password=$DB_PASSWORD dbname=$DB_NAME sslmode=disable" up
./build