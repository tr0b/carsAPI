CREATE TABLE "vehicles" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "description" varchar NOT NULL,
  "price" decimal NOT NULL,
  "color" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz DEFAULT (now())
);

-- name: CreateVehicle :one
INSERT INTO vehicles (name, description, price, color) VALUES ($1,$2,$3,$4)
RETURNING *;
-- name: GetVehicle :one
SELECT * FROM vehicles
WHERE id = $1;

-- name: ListVehicles :many
SELECT * FROM vehicles
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: CountVehicles :one
SELECT count(*) FROM vehicles;

-- name: UpdateVehicle :exec
UPDATE vehicles 
SET 
  name = $1,
  description = $2,
  price = $3,
  color = $4
WHERE id = $5;

-- name: DeleteVehicle :exec
DELETE FROM vehicles WHERE id = $1;
