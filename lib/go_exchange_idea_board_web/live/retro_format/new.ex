defmodule GoExchangeIdeaBoardWeb.RetroFormatLive.New do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormats, RetroFormat}
  alias GoExchangeIdeaBoardWeb.RetroFormatLive
  alias GoExchangeIdeaBoardWeb.RetroFormatView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok,
     assign(socket, %{
       changeset: RetroFormats.change_retro_format(%RetroFormat{})
     })}
  end

  def render(assigns), do: RetroFormatView.render("new.html", assigns)

  def handle_event("validate", %{"retro_format" => params}, socket) do
    changeset =
      %RetroFormat{}
      |> RetroFormats.change_retro_format(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"retro_format" => retro_format_params}, socket) do
    case RetroFormats.create_retro_format(retro_format_params) do
      {:ok, retro_format} ->
        {:stop,
         socket
         |> redirect(to: Routes.live_path(socket, RetroFormatLive.Show, retro_format))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
