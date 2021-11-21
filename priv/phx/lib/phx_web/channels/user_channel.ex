defmodule EXAMPLE__MODULE__NAMEWeb.UserChannel do
  @moduledoc false

  @room "user:all"

  @type topic :: String.t()

  def join(@room, params, socket) do
    IO.inspect("--- Joined")
    IO.inspect(params)
    {:ok, :ok, socket}
  end

  def handle_in("test", payload, socket) do
    IO.inspect("--- got test")
    IO.inspect(payload)
    {:reply, :ok, socket}
  end
end
