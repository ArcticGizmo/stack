defmodule EXAMPLE__MODULE__NAMEWeb.PageController do
  use EXAMPLE__MODULE__NAMEWeb, :controller

  def hello(conn, _params) do
    respond(conn, 200, %{message: "Hello, this is an example api response"})
  end
end
