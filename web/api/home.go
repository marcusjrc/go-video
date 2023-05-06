package api

import (
	"fmt"
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/marcusjrc/go-video/models"
)

func Home(handler *models.Handler) echo.HandlerFunc {
	return func(c echo.Context) error {
		videos, err := handler.Queries.GetLatestVideos(c.Request().Context())
		if err != nil {
			handler.ErrorLog.Printf(fmt.Sprintf("Failed to retrieve videos on request for Home with error: %s", err))
			return c.NoContent(http.StatusInternalServerError)
		}
		return c.Render(http.StatusOK, "home.html", map[string]interface{}{"videos": videos})
	}
}
