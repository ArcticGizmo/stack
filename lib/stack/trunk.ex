defmodule Stack.Trunk do
  defmacro bring(priv_path) do
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

  def dump(structure, dirname) do
    target = Path.join(File.cwd!(), dirname)

    Enum.each(structure, fn {short_path, data} ->
      path = Path.join(target, short_path)
      File.mkdir_p!(Path.dirname(path))
      File.write(path, data)
    end)
  end

  def rename(structure, from, to) do
    structure
    |> Map.put(to, structure[from])
    |> Map.drop([from])
  end

  def replace_everywhere(structure, pattern, replacement) do
    Enum.map(structure, fn {key, data} ->
      {key, String.replace(data, pattern, replacement)}
    end)
  end

  def replace(structure, key, pattern, replacement) do
    Map.update!(structure, key, &String.replace(&1, pattern, replacement))
  end
end
