#!/bin/bash
set -ex

# Aguarda o Postgres estar pronto
until pg_isready -U postgres; do
  echo "Aguardando postgres estar pronto..."
  sleep 2
done

# Cria o banco, se ainda não existir
psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'PFS-DB-CORE'" | grep -q 1 || createdb -U postgres PFS-DB-CORE

# Restaura o dump
echo "Restaurando dump do CORE..."
pg_restore -U postgres -d PFS-DB-CORE /restore/dump-core-PFS-CORE.dump
