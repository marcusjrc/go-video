# Go-video

## Overview
**Go-video is a Golang video hosting web application, supporting user uploaded videos.** Built using Echo, SQLC, PostgreSQL

Frontend is served as static html pages by Echo, using tailwind for styling


## Installation
1. Install Go on your computer, and then run `go install` to install the dependencies
2. You'll also need to manually install both SQLc (https://docs.sqlc.dev/en/stable/overview/install.html) & Goose (https://github.com/pressly/goose)
3. Set up docker-compose by using `docker-compose up` from within the project root folder. This will setup the local infrastructure
4. Next, run `./migrate.sh` in the root folder. This will migrate your database to the latest migration


## Linting & Testing
1. We use go fmt & staticheck for formatting & linting. You will need to install staticcheck (https://staticcheck.io/docs/getting-started/) and then run it by using the `staticcheck ./...` cmd.
2. We use go test for testing. Tests have the naming format: name_test.go, e.g. suffixed by _test


