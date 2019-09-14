defmodule GoExchangeIdeaBoardWeb.RetroFormatLive.Index do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormats
  alias GoExchangeIdeaBoardWeb.RetroFormatView

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns), do: RetroFormatView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, retro_formats: RetroFormats.list_retro_formats())
  end

  def handle_event("delete_retro_format", id, socket) do
    retro_format = RetroFormats.get_retro_format!(id)
    {:ok, _retro_format} = RetroFormats.delete_retro_format(retro_format)

    {:noreply, fetch(socket)}
  end

  def handle_info(%{event: "save"}, socket) do
    {:noreply, fetch(socket)}
  end
end
