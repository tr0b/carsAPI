CREATE TABLE users (
  id         bigserial PRIMARY KEY,
  first_name        varchar   NOT NULL,
  middle_name        varchar   NOT NULL,
  last_name        varchar   NOT NULL,
  date_of_birth        date   NOT NULL
);

-- name: CreateUser :one
INSERT INTO users (first_name, middle_name, last_name, date_of_birth) VALUES ($1,$2,$3,$4)
RETURNING *;
-- name: GetUser :one
SELECT * FROM users
WHERE id = $1;

-- name: ListUsers :many
SELECT * FROM users
ORDER BY id
LIMIT $1
OFFSET $2;
