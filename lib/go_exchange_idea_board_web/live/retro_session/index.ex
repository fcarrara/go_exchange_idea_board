defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Index do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.RetroSessions
  alias GoExchangeIdeaBoardWeb.RetroSessionView

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns), do: RetroSessionView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, retro_sessions: RetroSessions.list_retro_sessions())
  end

  def handle_event("delete_retro_session", id, socket) do
    retro_session = RetroSessions.get_retro_session!(id)
    {:ok, _retro_session} = RetroSessions.delete_retro_session(retro_session)

    {:noreply, fetch(socket)}
  end

  def handle_info(%{event: "save"}, socket) do
    {:noreply, fetch(socket)}
  end
end
