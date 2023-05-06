#!/bin/bash
goose -dir ./migrations postgres "host=localhost user=postgres password=postgres dbname=govideo sslmode=disable"  up 