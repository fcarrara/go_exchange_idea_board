defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias GoExchangeIdeaBoard.Retrospectives.RetroSessions
  alias GoExchangeIdeaBoardWeb.RetroSessionView
  alias Phoenix.LiveView.Socket

  def render(assigns), do: RetroSessionView.render("show.html", assigns)

  def mount(%{path_params: %{"id" => id}}, socket) do
    {:ok, fetch(assign(socket, id: id))}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, retro_session: RetroSessions.get_retro_session!(id))
  end
end
