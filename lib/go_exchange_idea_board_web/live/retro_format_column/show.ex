defmodule GoExchangeIdeaBoardWeb.RetroFormatColumnLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoardWeb.RetroFormatColumnView
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormatColumns

  def render(assigns), do: RetroFormatColumnView.render("show.html", assigns)

  def mount(%{path_params: %{"id" => id}}, socket) do
    EventCenter.subscribe()

    retro_format_column = RetroFormatColumns.get_retro_format_column!(id)

    {:ok,
     assign(socket, %{
       retro_format_column: retro_format_column
     })}
  end
end
