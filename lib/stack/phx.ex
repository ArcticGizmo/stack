defmodule Stack.Phx do
  alias Stack.{Data, Git}

  @source "stack-phx"
  @source_branch "main"
  @dir "phx"

  def create(app_name, module_name, opts \\ []) do
    Git.clone(@source, @source_branch, @dir)

    Data.read(@dir)
    |> Data.replace_everywhere("EXAMPLE__MODULE__NAME", module_name)
    |> Data.replace_everywhere("example__app__name", app_name)
    |> Data.dump()
  end
end
