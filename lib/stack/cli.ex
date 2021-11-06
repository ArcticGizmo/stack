defmodule Stack.CLI do
  require Stack.Trunk

  @phx Stack.Trunk.keep("phx")

  def main(_args) do
    IO.inspect(@phx)
  end
end
