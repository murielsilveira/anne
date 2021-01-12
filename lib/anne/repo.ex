defmodule Anne.Repo do
  use Ecto.Repo,
    otp_app: :anne,
    adapter: Ecto.Adapters.Postgres
end
