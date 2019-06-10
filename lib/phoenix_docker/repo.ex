defmodule PhoenixDocker.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_docker,
    adapter: Ecto.Adapters.Postgres
end
