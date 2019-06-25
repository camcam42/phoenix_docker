#!/bin/bash

if [ -f ".env" ]; then
  source ".env"
else
  echo "No .env file available in the project. Please build again the image with an .env file in the repository"
  exit -1
fi

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  # mix ecto.create
  # mix ecto.migrate
  # mix run priv/repo/seeds.exs
  echo "Database $PGDATABASE created."
fi

#test

mix phx.server