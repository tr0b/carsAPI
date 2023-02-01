CREATE TABLE "invoice_items" (
  "id" bigserial PRIMARY KEY,
  "invoice_id" bigint NOT NULL,
  "vehicle_id" bigint NOT NULL,
  "created_at" timestamptz DEFAULT (now())
);

-- name: CreateInvoiceItem :one
INSERT INTO invoice_items (invoice_id, vehicle_id) VALUES ($1,$2)
RETURNING *;
-- name: GetInvoiceItem :one
SELECT * FROM invoice_items
WHERE id = $1;

-- name: ListInvoiceItems :many
SELECT * FROM invoice_items
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: CountInvoiceItems :one
SELECT count(*) FROM invoice_items;

-- name: UpdateInvoiceItem :exec
UPDATE invoice_items 
SET 
  invoice_id = $1,
  vehicle_id = $2
WHERE id = $3;

-- name: DeleteInvoiceItem :exec
DELETE FROM invoice_items WHERE id = $1;
