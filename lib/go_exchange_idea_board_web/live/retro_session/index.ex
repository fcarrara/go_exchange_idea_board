defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Index do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.Retrospectives
  alias GoExchangeIdeaBoardWeb.RetroSessionView

  def mount(_session, socket) do
    {:ok, fetch(socket)}
  end

  def render(assigns), do: RetroSessionView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, retro_sessions: Retrospectives.list_retro_sessions())
  end

  def handle_event("delete_retro_session", id, socket) do
    retro_session = Retrospectives.get_retro_session!(id)
    {:ok, _retro_session} = Retrospectives.delete_retro_session(retro_session)
    {:noreply, fetch(socket) }
  end
end
