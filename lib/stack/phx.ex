defmodule Stack.Phx do
  alias Stack.Trunk

  require Trunk

  def create() do
    module_name = "Example"
    app_name = "example"

    files =
      Trunk.bring("phx")
      |> Trunk.rename(".gitignore.example", ".gitignore")
      |> Trunk.replace_everywhere("__MY__MODULE__", module_name)
      |> Trunk.replace_everywhere("__MY__APP__", app_name)

    # updated some files based on the module name etc
    # files = do_work(files, opts)

    # dump the files
    # Trunk.dump(files, "example_phx")
  end
end
