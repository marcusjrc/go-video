package database

import (
	"strconv"

	"github.com/marcusjrc/go-video/config"
	"github.com/xeonx/timeago"
)

func (video Video) FormatCreatedToTimeAgo() string {
	return timeago.English.Format(video.CreatedOn)
}

func (video Video) GetVideoPageUrl() string {
	return config.DOMAIN + "video/" + strconv.Itoa(int(video.ID))
}
