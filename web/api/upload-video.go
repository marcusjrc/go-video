package api

import (
	"net/http"

	validation "github.com/go-ozzo/ozzo-validation/v4"
	"github.com/labstack/echo/v4"
	"github.com/marcusjrc/go-video/models"
)

func UploadVideo(handler *models.Handler) echo.HandlerFunc {
	return func(c echo.Context) error {
		return c.Render(http.StatusOK, "upload-video.html", nil)
	}
}

type UploadVideoValidation struct {
	Title       string
	Description string
}

func (u UploadVideoValidation) Validate() error {
	return validation.ValidateStruct(&u,
		validation.Field(&u.Title, validation.Required, validation.Length(5, 100)),
		validation.Field(&u.Description, validation.Length(0, 2200)),
	)
}

func PostUploadVideo(handler *models.Handler) echo.HandlerFunc {
	return func(c echo.Context) (err error) {
		upload := new(UploadVideoValidation)
		if err = c.Bind(upload); err != nil {
			return echo.NewHTTPError(http.StatusBadRequest, err.Error())
		}
		if err = upload.Validate(); err != nil {
			return c.Render(http.StatusOK, "upload-video.html", err)
		}
		return c.NoContent(http.StatusOK)
	}
}
