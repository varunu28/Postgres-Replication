CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator';

CREATE DATABASE ecommerce;

\c ecommerce;

CREATE TABLE orders (
    id          SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    status      VARCHAR(50) NOT NULL DEFAULT 'pending',
    total_amount NUMERIC(10, 2) NOT NULL,
    shipping_address TEXT,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW()
);
