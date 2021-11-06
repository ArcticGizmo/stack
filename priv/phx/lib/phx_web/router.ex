defmodule __MY__MODULE__Web.Router do
  use __MY__MODULE__Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", __MY__MODULE__Web do
    pipe_through :api

    get "/hello", PageController, :hello
  end
end
