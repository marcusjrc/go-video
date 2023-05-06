-- +goose Up
-- +goose StatementBegin
ALTER TABLE video
ADD description VARCHAR(2200) NULL;

ALTER TABLE video
ADD view_count INTEGER DEFAULT 0 NOT NULL;
-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
ALTER TABLE video
DROP COLUMN IF EXISTS description;

ALTER TABLE video
DROP COLUMN IF EXISTS view_count;
-- +goose StatementEnd