package api

import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
	"github.com/marcusjrc/go-video/models"
)

func Video(handler *models.Handler) echo.HandlerFunc {
	return func(c echo.Context) error {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			handler.ErrorLog.Printf(fmt.Sprintf("Failed to parse id parameter on request for Video with error: %s", err))
			return c.NoContent(http.StatusInternalServerError)
		}
		video, err := handler.Queries.GetVideo(c.Request().Context(), int32(id))
		if err != nil {
			handler.ErrorLog.Printf(fmt.Sprintf("Failed to retrieve video on request for Video with error: %s", err))
			return c.NoContent(http.StatusInternalServerError)
		}
		return c.Render(http.StatusOK, "video.html", video)
	}
}
