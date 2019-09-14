defmodule GoExchangeIdeaBoardWeb.RetroFormatColumnLive.Index do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormatColumns
  alias GoExchangeIdeaBoardWeb.RetroFormatColumnView

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns), do: RetroFormatColumnView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, retro_format_columns: RetroFormatColumns.list_retro_format_columns())
  end

  def handle_event("delete_retro_format_column", id, socket) do
    retro_format_column = RetroFormatColumns.get_retro_format_column!(id)
    {:ok, _retro_format_column} = RetroFormatColumns.delete_retro_format_column(retro_format_column)

    {:noreply, fetch(socket)}
  end

  def handle_info(%{event: "save"}, socket) do
    {:noreply, fetch(socket)}
  end
end
