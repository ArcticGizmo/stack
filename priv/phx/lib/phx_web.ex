defmodule EXAMPLE__MODULE__NAMEWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use EXAMPLE__MODULE__NAMEWeb, :controller
      use EXAMPLE__MODULE__NAMEWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: EXAMPLE__MODULE__NAMEWeb

      import Plug.Conn
      import EXAMPLE__MODULE__NAMEWeb.Helper
      alias EXAMPLE__MODULE__NAMEWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/phx_web/templates",
        namespace: EXAMPLE__MODULE__NAMEWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import EXAMPLE__MODULE__NAMEWeb.ErrorHelpers
      alias EXAMPLE__MODULE__NAMEWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

defmodule EXAMPLE__MODULE__NAMEWeb.Helper do
  def respond(conn), do: Plug.Conn.send_resp(conn)

  def respond(conn, code, data) when is_binary(data) do
    Plug.Conn.send_resp(conn, code, data)
  end

  def respond(conn, code, data) do
    payload = Jason.encode!(data)
    Plug.Conn.send_resp(conn, code, payload)
  end
end
