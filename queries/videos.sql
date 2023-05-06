-- name: GetVideo :one
SELECT *
FROM video
WHERE id = $1
LIMIT 1;
-- name: GetLatestVideos :many
SELECT *
FROM video
ORDER BY created_on DESC
LIMIT 30;
-- name: CreateEmptyVideoAndReturnId :one
INSERT INTO video (title)
VALUES ($1)
RETURNING id;