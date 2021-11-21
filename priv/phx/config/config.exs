use Mix.Config

config :example__app__name,
  namespace: EXAMPLE__MODULE__NAME,
  ecto_repos: [EXAMPLE__MODULE__NAME.Repo]

# Configures the endpoint
config :example__app__name, EXAMPLE__MODULE__NAMEWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dOk2CGM0B+s2SE1ILmTAHNCa+zHcgDxTgbGm1J5tJSUTbBNJ8jLloCZvmdXy3hbl",
  render_errors: [view: EXAMPLE__MODULE__NAMEWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: EXAMPLE__MODULE__NAME.PubSub,
  live_view: [signing_salt: "QAhKoI4G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
