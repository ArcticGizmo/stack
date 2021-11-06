defmodule __MY__MODULE__Web.UserSocket do
  use Phoenix.Socket

  channel("user:all", __MY__MODULE__Web.UserChannel)

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
