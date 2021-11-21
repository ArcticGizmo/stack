defmodule Stack.Trunk do
  @type structure :: map()

  defmacro bring(priv_path, ignore \\ []) do
    structure = read_path_from_priv(priv_path, ignore)

    quote do
      unquote(structure)
      |> Enum.into(%{})
    end
  end

  defp read_path_from_priv(priv_path, ignored) do
    rel_path = "./priv/#{priv_path}"

    cull_path = "priv/#{priv_path}/"

    paths = Path.wildcard("#{rel_path}/**/*", match_dot: true)

    paths
    |> Enum.map(fn path ->
      short_path = String.replace(path, cull_path, "", global: false)

      case File.dir?(path) || ignore_path?(short_path, ignored) do
        true ->
          nil

        false ->
          data =
            path
            |> File.read!()
            |> String.replace("\r", "")

          {short_path, data}
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp ignore_path?(path, ignored) do
    Enum.any?(ignored, &String.starts_with?(path, &1))
  end

  @spec dump(structure, String.t()) :: no_return()
  def dump(structure, dirname) do
    target = Path.join(File.cwd!(), dirname)

    IO.puts("Dumping structure")

    structure
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.each(fn {short_path, data} ->
      path = Path.join(target, short_path)
      File.mkdir_p!(Path.dirname(path))
      File.write(path, data)
      IO.puts("  * #{path}")
    end)
  end

  @spec rename(structure, String.t(), String.t()) :: structure
  def rename(structure, from, to) do
    structure
    |> Map.put(to, structure[from])
    |> Map.drop([from])
  end

  @spec replace_everywhere(structure, String.t(), String.t()) :: structure
  def replace_everywhere(structure, pattern, replacement) do
    Enum.map(structure, fn {key, data} ->
      pattern = String.replace(pattern, "\r", "")
      {key, String.replace(data, pattern, replacement)}
    end)
    |> Enum.into(%{})
  end

  @spec replace(structure, String.t(), String.t(), String.t()) :: structure
  def replace(structure, key, pattern, replacement) do
    pattern =
      pattern
      |> String.replace("\r", "")
      |> adjust_multiline()

    Map.update!(structure, key, &String.replace(&1, pattern, replacement))
  end

  defp adjust_multiline(string) when is_binary(string) do
    String.split(string, "\n")
    |> adjust_multiline()
  end

  defp adjust_multiline([string]), do: string

  defp adjust_multiline(["", first_line]), do: String.trim_leading(first_line)

  defp adjust_multiline(["", first_line | rest]) do
    cull_offset =
      first_line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce_while(0, fn {letter, index}, _acc ->
        case letter do
          " " -> {:cont, index}
          _ -> {:halt, index}
        end
      end)

    [first_line | rest]
    |> Enum.map(fn str ->
      str
      |> String.split_at(cull_offset)
      |> elem(1)
    end)
    |> Enum.join("\n")
  end

  @spec append(structure, String.t(), String.t()) :: structure
  def append(structure, key, data) do
    Map.update!(structure, key, &"#{&1}\n#{data}")
  end
end
