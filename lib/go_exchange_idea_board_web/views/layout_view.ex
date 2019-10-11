defmodule GoExchangeIdeaBoardWeb.LayoutView do
  use GoExchangeIdeaBoardWeb, :view

  alias GoExchangeIdeaBoardWeb.{RetroFormatLive, RetroSessionLive, ActionItemLive}

  def is_active_menu?(conn, module) do
    if controller_module(conn) == module, do: "active", else: ""
  end
end
