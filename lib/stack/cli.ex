defmodule Stack.CLI do

  def main(_args) do
    app_name = "example"
    module_name = "Example"
    opts = [
      use_repo: false
    ]
    Stack.Phx.create(app_name, module_name, opts)
  end
end
