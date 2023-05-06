package web

import (
	"github.com/labstack/echo/v4"
	"github.com/marcusjrc/go-video/models"
	"github.com/marcusjrc/go-video/web/api"
)

func SetupRouter(server *echo.Echo, handler *models.Handler) {
	webGroup := server.Group("/")
	webGroup.GET("", api.Home(handler))
	webGroup.GET("video/:id", api.Video(handler))
	webGroup.GET("upload-video", api.UploadVideo(handler))
	webGroup.POST("upload-video", api.PostUploadVideo(handler))
}
