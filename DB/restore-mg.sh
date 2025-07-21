#!/bin/bash
set -ex

# Aguarda o Postgres estar pronto
until pg_isready -U postgres; do
  echo "Aguardando postgres estar pronto..."
  sleep 2
done

# Cria o banco, se ainda não existir
psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'PFS-DB-MG'" | grep -q 1 || createdb -U postgres PFS-DB-MG

# Restaura o dump
echo "Restaurando dump do MG..."
pg_restore -U postgres -d PFS-DB-MG /restore/dump-core-PFS-MG.dump
