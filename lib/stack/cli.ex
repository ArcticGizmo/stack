defmodule Stack.CLI do

  def main(_args) do
    app_name = "example"
    module_name = "Example"
    opts = [
      use_repo: false
    ]

    # do something here to get all the settings etc

    Stack.Phx.create(app_name, module_name, opts)

    # Stack.Phx.create(app_name, module_name, opts)
    # Stack.Vue.create(app_name, module_name, opts)
  end
end
