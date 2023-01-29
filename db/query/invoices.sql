CREATE TABLE "invoices" (
  "id" bigserial PRIMARY KEY,
  "buyer_id" bigint,
  "created_at" timestamptz DEFAULT (now())
);

-- name: CreateInvoice :one
INSERT INTO invoices (buyer_id) VALUES ($1)
RETURNING *;
-- name: GetInvoice :one
SELECT * FROM invoices
WHERE id = $1;

-- name: ListInvoices :many
SELECT * FROM invoices
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: CountInvoices :one
SELECT count(*) FROM invoices;

-- name: UpdateInvoice :exec
UPDATE invoices 
SET 
  buyer_id = $1
WHERE id = $2;

-- name: DeleteInvoice :exec
DELETE FROM invoices WHERE id = $1;
