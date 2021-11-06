use Mix.Config

config :__MY__APP__,
  namespace: __MY__MODULE__,
  ecto_repos: [__MY__MODULE__.Repo]

# Configures the endpoint
config :__MY__APP__, __MY__MODULE__Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dOk2CGM0B+s2SE1ILmTAHNCa+zHcgDxTgbGm1J5tJSUTbBNJ8jLloCZvmdXy3hbl",
  render_errors: [view: __MY__MODULE__Web.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: __MY__MODULE__.PubSub,
  live_view: [signing_salt: "QAhKoI4G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
