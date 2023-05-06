package main

import (
	"embed"
	"io"
	"log"
	"net/http"
	"os"
	"text/template"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/marcusjrc/go-video/config"
	"github.com/marcusjrc/go-video/database"
	"github.com/marcusjrc/go-video/models"
	"github.com/marcusjrc/go-video/web"
)

type TemplateRenderer struct {
	templates *template.Template
}

func (t *TemplateRenderer) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	tmpl := template.Must(t.templates.Clone())
	tmpl = template.Must(tmpl.ParseFS(tmplFS, "web/templates/pages/"+name))
	return tmpl.ExecuteTemplate(w, name, data)
}

//go:embed web/templates/*
var tmplFS embed.FS

func main() {

	// Setup server
	echo.NotFoundHandler = func(c echo.Context) error {
		return c.Render(http.StatusNotFound, "not-found.html", nil)
	}

	server := echo.New()
	server.Use(middleware.Recover())
	server.Use(middleware.Logger())
	server.Use(middleware.Gzip())

	renderer := &TemplateRenderer{
		templates: template.Must(template.New("template").Funcs(template.FuncMap{
			"Domain": func() string { return config.DOMAIN },
			"Title":  func() string { return config.TITLE }}).ParseFS(tmplFS, "web/templates/**/*.html")),
	}
	server.Renderer = renderer

	// Setup database connection
	db := database.SetupDatabase()
	queries := database.New(db)

	// Setup API urls with database handler
	env := &models.Handler{Queries: queries, ErrorLog: log.New(os.Stdout, "ERROR: ", log.Ldate|log.Ltime|log.Lshortfile)}
	web.SetupRouter(server, env)

	server.Logger.Fatal(server.Start(":8080"))
}
