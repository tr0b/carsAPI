// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: users.sql

package carsAPI

import (
	"context"
	"database/sql"
	"time"
)

const createUser = `-- name: CreateUser :one
INSERT INTO users (first_name, middle_name, last_name, date_of_birth) VALUES ($1,$2,$3,$4)
RETURNING id, first_name, middle_name, last_name, date_of_birth
`

type CreateUserParams struct {
	FirstName   string         `json:"first_name"`
	MiddleName  sql.NullString `json:"middle_name"`
	LastName    string         `json:"last_name"`
	DateOfBirth time.Time      `json:"date_of_birth"`
}

func (q *Queries) CreateUser(ctx context.Context, arg CreateUserParams) (User, error) {
	row := q.db.QueryRowContext(ctx, createUser,
		arg.FirstName,
		arg.MiddleName,
		arg.LastName,
		arg.DateOfBirth,
	)
	var i User
	err := row.Scan(
		&i.ID,
		&i.FirstName,
		&i.MiddleName,
		&i.LastName,
		&i.DateOfBirth,
	)
	return i, err
}

const getUser = `-- name: GetUser :one
SELECT id, first_name, middle_name, last_name, date_of_birth FROM users
WHERE id = $1
`

func (q *Queries) GetUser(ctx context.Context, id int64) (User, error) {
	row := q.db.QueryRowContext(ctx, getUser, id)
	var i User
	err := row.Scan(
		&i.ID,
		&i.FirstName,
		&i.MiddleName,
		&i.LastName,
		&i.DateOfBirth,
	)
	return i, err
}

const listUsers = `-- name: ListUsers :many
SELECT id, first_name, middle_name, last_name, date_of_birth FROM users
ORDER BY id
LIMIT $1
OFFSET $2
`

type ListUsersParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) ListUsers(ctx context.Context, arg ListUsersParams) ([]User, error) {
	rows, err := q.db.QueryContext(ctx, listUsers, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []User
	for rows.Next() {
		var i User
		if err := rows.Scan(
			&i.ID,
			&i.FirstName,
			&i.MiddleName,
			&i.LastName,
			&i.DateOfBirth,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
