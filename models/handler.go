package models

import (
	"log"

	"github.com/marcusjrc/go-video/database"
)

type Handler struct {
	Queries  *database.Queries
	ErrorLog *log.Logger
}
