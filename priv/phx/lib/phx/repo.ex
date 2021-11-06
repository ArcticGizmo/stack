defmodule __MY__MODULE__.Repo do
  use Ecto.Repo,
    otp_app: :__MY__APP__,
    adapter: Ecto.Adapters.Postgres
end
