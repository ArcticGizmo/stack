defmodule EXAMPLE__MODULE__NAME.Application do
  use Application

  def start(_type, _args) do
    children = [
      # EXAMPLE__MODULE__NAME.Repo,
      {Phoenix.PubSub, name: EXAMPLE__MODULE__NAME.PubSub},
      EXAMPLE__MODULE__NAMEWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: EXAMPLE__MODULE__NAME.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    EXAMPLE__MODULE__NAMEWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
