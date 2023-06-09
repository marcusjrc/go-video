// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.2

package database

import (
	"database/sql"
	"database/sql/driver"
	"fmt"
	"time"
)

type UploadStatus string

const (
	UploadStatusUPLOADING     UploadStatus = "UPLOADING"
	UploadStatusUPLOADSUCCESS UploadStatus = "UPLOAD_SUCCESS"
	UploadStatusUPLOADERROR   UploadStatus = "UPLOAD_ERROR"
)

func (e *UploadStatus) Scan(src interface{}) error {
	switch s := src.(type) {
	case []byte:
		*e = UploadStatus(s)
	case string:
		*e = UploadStatus(s)
	default:
		return fmt.Errorf("unsupported scan type for UploadStatus: %T", src)
	}
	return nil
}

type NullUploadStatus struct {
	UploadStatus UploadStatus
	Valid        bool // Valid is true if UploadStatus is not NULL
}

// Scan implements the Scanner interface.
func (ns *NullUploadStatus) Scan(value interface{}) error {
	if value == nil {
		ns.UploadStatus, ns.Valid = "", false
		return nil
	}
	ns.Valid = true
	return ns.UploadStatus.Scan(value)
}

// Value implements the driver Valuer interface.
func (ns NullUploadStatus) Value() (driver.Value, error) {
	if !ns.Valid {
		return nil, nil
	}
	return string(ns.UploadStatus), nil
}

type Video struct {
	ID          int32
	Title       string
	VideoUrl    sql.NullString
	CreatedOn   time.Time
	Status      NullUploadStatus
	Description sql.NullString
	ViewCount   int32
}
