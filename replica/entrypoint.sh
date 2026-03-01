#!/bin/bash
set -e

mkdir -p "$PGDATA"
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Wait for primary to be ready
until gosu postgres pg_isready -h primary -p 5432 -U postgres; do
  echo "Waiting for primary to be ready..."
  sleep 2
done

# Run pg_basebackup only on first start (empty data dir)
if [ -z "$(ls -A "$PGDATA")" ]; then
  echo "Running pg_basebackup from primary..."
  PGPASSWORD=replicator gosu postgres pg_basebackup \
    -h primary \
    -U replicator \
    -p 5432 \
    -D "$PGDATA" \
    -Fp -Xs -P -R
  echo "Base backup complete. Starting replica..."
fi

exec gosu postgres postgres
