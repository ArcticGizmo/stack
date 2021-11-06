defmodule Stack.Trunk do
  defmacro __using__(path) when is_binary(path) do
    file = File.read!("./priv/phx/sample.ex")

    quote do
      Module.put_attribute(__MODULE__, :files, unquote(file))
    end
  end
end
