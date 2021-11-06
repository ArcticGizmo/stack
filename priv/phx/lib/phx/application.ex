defmodule __MY__MODULE__.Application do
  use Application

  def start(_type, _args) do
    children = [
      __MY__MODULE__.Repo,
      {Phoenix.PubSub, name: __MY__MODULE__.PubSub},
      __MY__MODULE__Web.Endpoint
    ]

    opts = [strategy: :one_for_one, name: __MY__MODULE__.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    __MY__MODULE__Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
