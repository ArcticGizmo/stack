defmodule Stack.Phx do
  alias Stack.Trunk

  require Trunk

  def create(app_name, module_name, opts \\ []) do
    Trunk.bring("phx", ["_build", ".elixir_ls", "deps"])
    |> Trunk.append(".gitignore", "*secret*")
    |> use_repo(opts[:use_repo])
    |> Trunk.replace_everywhere("EXAMPLE__MODULE__NAME", module_name)
    |> Trunk.replace_everywhere("example__app__name", app_name)
    |> Trunk.dump("example_phx")
  end

  defp use_repo(structure, true), do: structure

  defp use_repo(structure, false) do
    r_config = "
    config :example__app__name,
      namespace: EXAMPLE__MODULE__NAME,
      ecto_repos: [EXAMPLE__MODULE__NAME.Repo]"

    r_dev = "
    # Configure your database
    config :example__app__name, EXAMPLE__MODULE__NAME.Repo,
      username: \"postgres\",
      password: \"postgres\",
      database: \"example__app__name_dev\",
      hostname: \"localhost\",
      show_sensitive_data_on_connection_error: true,
      pool_size: 10"

    r_prod_secret = "
    config :example__app__name, EXAMPLE__MODULE__NAME.Repo,
      # ssl: true,
      url: database_url,
      pool_size: String.to_integer(System.get_env(\"POOL_SIZE\") || \"10\")"

    r_test = "
    # Configure your database
    #
    # The MIX_TEST_PARTITION environment variable can be used
    # to provide built-in test partitioning in CI environment.
    # Run `mix help test` for more information.
    config :example__app__name, EXAMPLE__MODULE__NAME.Repo,
      username: \"postgres\",
      password: \"postgres\",
      database: \"example__app__name_test\#{System.get_env(\"MIX_TEST_PARTITION\")}\",
      hostname: \"localhost\",
      pool: Ecto.Adapters.SQL.Sandbox"

    r_application = "      EXAMPLE__MODULE__NAME.Repo,"

    r_endpoint = "    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :phx"

    r_test_helper = "Ecto.Adapters.SQL.Sandbox.mode(EXAMPLE__MODULE__NAME.Repo, :manual)"

    r_channel_case = "
    setup tags do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(EXAMPLE__MODULE__NAME.Repo)

      unless tags[:async] do
        Ecto.Adapters.SQL.Sandbox.mode(EXAMPLE__MODULE__NAME.Repo, {:shared, self()})
      end

      :ok
    end"

    r_conn_case = "
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EXAMPLE__MODULE__NAME.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(EXAMPLE__MODULE__NAME.Repo, {:shared, self()})
    end"

    structure
    |> Trunk.replace("config/config.exs", r_config, "")
    |> Trunk.replace("config/dev.exs", r_dev, "")
    |> Trunk.replace("config/prod.secret.exs", r_prod_secret, "")
    |> Trunk.replace("config/test.exs", r_test, "")
    |> Trunk.replace("lib/phx/application.ex", r_application, "")
    |> Trunk.replace("lib/phx_web/endpoint.ex", r_endpoint, "")
    |> Trunk.replace("test/test_helper.exs", r_test_helper, "")
    |> Trunk.replace("test/support/channel_case.ex", r_channel_case, "")
    |> Trunk.replace("test/support/conn_case.ex", r_conn_case, "")
    |> Map.drop(["lib/phx/repo.ex", "test/support/data_case.ex"])
  end
end
