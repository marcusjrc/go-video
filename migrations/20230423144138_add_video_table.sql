-- +goose Up
-- +goose StatementBegin
CREATE TYPE upload_status AS ENUM ('UPLOADING', 'UPLOAD_SUCCESS', 'UPLOAD_ERROR');
CREATE TABLE IF NOT EXISTS video (
    id serial PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    video_url VARCHAR(500),
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status upload_status DEFAULT 'UPLOADING'
);
-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS video;
DROP TYPE IF EXISTS upload_status;
-- +goose StatementEnd