defmodule Stack.CLI do
  use Stack.Trunk, "./priv/phx"
  # @before_compile Stack.File

  # defmacrop keep(path) do
  #   IO.inspect(path)
  #   quote do
  #     File.read(unquote(path))
  #   end
  # end

  def main([]) do
    IO.puts("--- cant do that man")
  end

  def main([name]) do
    read_path_from_priv("phx")
    |> dump_structure(name)
  end

  defp read_path_from_priv(priv_path) do
    rel_path = "./priv/#{priv_path}"

    cull_path = "priv/#{priv_path}/"

    paths =
      Path.wildcard("#{rel_path}/**/*", match_dot: true)
      |> IO.inspect()

    paths
    |> Enum.map(fn path ->
      short_path = String.replace(path, cull_path, "", global: false)

      case File.dir?(path) do
        true -> nil
        false -> {short_path, File.read!(path)}
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.into(%{})
  end

  defp dump_structure(structure, dirname) do
    target = Path.join(File.cwd!(), dirname)

    Enum.each(structure, fn {short_path, data} ->
      path = Path.join(target, short_path)
      File.mkdir_p!(Path.dirname(path))
      File.write(path, data)
    end)
  end
end
