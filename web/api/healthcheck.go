package api

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/marcusjrc/go-video/models"
)

func Healthcheck(handler *models.Handler) echo.HandlerFunc {
	return func(c echo.Context) error {
		return c.NoContent(http.StatusOK)
	}
}
