defmodule EXAMPLE__MODULE__NAMEWeb.Router do
  use EXAMPLE__MODULE__NAMEWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EXAMPLE__MODULE__NAMEWeb do
    pipe_through :api

    get "/hello", PageController, :hello
  end
end
