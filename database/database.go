package database

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

func SetupDatabase() *sql.DB {
	db, err := sql.Open("postgres", "host=localhost port=5432 user=postgres password=postgres dbname=govideo sslmode=disable")
	if err != nil {
		panic(fmt.Sprintf("Failed to establish connection details for database with error: %s", err))
	}
	err = db.Ping()
	if err != nil {
		panic(fmt.Sprintf("Failed to create connection with database with error: %s", err))
	}
	return db
}
