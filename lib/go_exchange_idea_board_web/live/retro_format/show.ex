defmodule GoExchangeIdeaBoardWeb.RetroFormatLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoardWeb.RetroFormatView
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormats

  def render(assigns), do: RetroFormatView.render("show.html", assigns)

  def mount(%{path_params: %{"id" => id}}, socket) do
    EventCenter.subscribe()

    retro_format = RetroFormats.get_retro_format!(id)

    {:ok,
     assign(socket, %{
       retro_format: retro_format
     })}
  end
end
