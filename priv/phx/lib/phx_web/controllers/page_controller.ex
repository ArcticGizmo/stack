defmodule __MY__MODULE__Web.PageController do
  use __MY__MODULE__Web, :controller

  def hello(conn, _params) do
    respond(conn, 200, %{message: "Hello, this is an example api response"})
  end
end
