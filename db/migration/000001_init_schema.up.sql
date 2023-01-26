CREATE TABLE "vehicles" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "description" varchar NOT NULL,
  "price" decimal NOT NULL,
  "color" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz DEFAULT (now())
);

CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "middle_name" varchar,
  "last_name" varchar NOT NULL,
  "date_of_birth" date NOT NULL
);

CREATE TABLE "invoices" (
  "id" bigserial PRIMARY KEY,
  "buyer_id" bigint,
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "invoice_items" (
  "id" bigserial PRIMARY KEY,
  "invoice_id" bigint NOT NULL,
  "vehicle_id" bigint NOT NULL,
  "created_at" timestamptz DEFAULT (now())
);

CREATE INDEX ON "vehicles" ("name");

CREATE INDEX ON "vehicles" ("price");

CREATE INDEX ON "users" ("first_name");

CREATE INDEX ON "users" ("last_name");

CREATE INDEX ON "users" ("first_name", "last_name");

CREATE INDEX ON "invoice_items" ("invoice_id");

CREATE INDEX ON "invoice_items" ("vehicle_id");

CREATE INDEX ON "invoice_items" ("invoice_id", "vehicle_id");

ALTER TABLE "invoices" ADD FOREIGN KEY ("buyer_id") REFERENCES "users" ("id");

ALTER TABLE "invoice_items" ADD FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("id");

ALTER TABLE "invoice_items" ADD FOREIGN KEY ("vehicle_id") REFERENCES "vehicles" ("id");
