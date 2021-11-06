defmodule Stack.Trunk do
  defmacro keep(priv_path) do
    structure = read_path_from_priv(priv_path)

    quote do
      unquote(structure)
      |> Enum.into(%{})
    end
  end

  defp read_path_from_priv(priv_path) do
    rel_path = "./priv/#{priv_path}"

    cull_path = "priv/#{priv_path}/"

    paths = Path.wildcard("#{rel_path}/**/*", match_dot: true)

    paths
    |> Enum.map(fn path ->
      short_path = String.replace(path, cull_path, "", global: false)

      case File.dir?(path) do
        true -> nil
        false -> {short_path, File.read!(path)}
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  def dump_structure(structure, dirname) do
    target = Path.join(File.cwd!(), dirname)

    Enum.each(structure, fn {short_path, data} ->
      path = Path.join(target, short_path)
      File.mkdir_p!(Path.dirname(path))
      File.write(path, data)
    end)
  end
end
