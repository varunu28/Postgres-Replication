#!/bin/bash
# Allow replication connections from the replica
echo "host replication replicator all md5" >> "$PGDATA/pg_hba.conf"
